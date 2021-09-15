defmodule ElxLogger.WarnConsumer do
  @moduledoc """
   Warning Consumer
    - create Warning Consumer via genserver
    - Exchange type : Topic
    - incomming topics:
       - warning.db : save log to database
       - warning.file : save log to file
       - warning.mail : publish log via email
  """
  use GenServer
  use AMQP

  def start_link(arg \\ []) do
    GenServer.start_link(__MODULE__, arg, [])
  end

  @exchange Application.compile_env!(:elx_logger, :warning_exchange)
  @queue "warning"
  # @queue_error "#{@queue}_error"

  def init(_opts) do
    {:ok, conn} = Connection.open()
    {:ok, chan} = Channel.open(conn)

    Queue.declare(chan, @queue, durable: true)
    Exchange.topic(chan, @exchange, durable: true)
    Queue.bind(chan, @queue, @exchange, routing_key: "warning.*")
    {:ok, _consumer_tag} = Basic.consume(chan, @queue, nil, no_ack: true)
    {:ok, chan}
  end

  # Confirmation sent by the broker after registering this process as a consumer
  def handle_info({:basic_consume_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  # Sent by the broker when the consumer is unexpectedly cancelled (such as after a queue deletion)
  def handle_info({:basic_cancel, %{consumer_tag: _consumer_tag}}, chan) do
    {:stop, :normal, chan}
  end

  # Confirmation sent by the broker to the consumer process after a Basic.cancel
  def handle_info({:basic_cancel_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  def handle_info(
        {:basic_deliver, payload,
         %{routing_key: routing_key, delivery_tag: _tag, redelivered: _redelivered}},
        chan
      ) do
    spawn(fn -> consume(payload, routing_key) end)
    {:noreply, chan}
  end

  defp consume(payload, action) do
    IO.puts("action: #{action} log: #{payload}")

    cond do
      action == "warning.db" -> ElxLogger.make(:db, :warning, payload)
      action == "warning.file" -> ElxLogger.make(:file, :warning, payload)
      action == "warning.mail" -> ElxLogger.make(:mail, :warning, payload)
    end
  rescue
    _ ->
      IO.puts("Warning Consumer did not completed")
  end
end
