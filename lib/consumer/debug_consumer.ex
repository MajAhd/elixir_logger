defmodule ElxLogger.DebugConsumer do
  @moduledoc """
    Debug Consumer
    - create Debug Consumer via genserver
    - Exchange type : Topic
    - incomming topics:
       - debug.db : save log to database
       - debug.file : save log to file
       - debug.mail : publish log via email
  """
  use GenServer
  use AMQP

  def start_link(arg \\ []) do
    GenServer.start_link(__MODULE__, arg, [])
  end

  @exchange Application.compile_env!(:elx_logger, :debug_exchange)
  @queue "debug"

  def init(_opts) do
    {:ok, conn} = Connection.open()
    {:ok, chan} = Channel.open(conn)

    Queue.declare(chan, @queue, durable: true)
    Exchange.topic(chan, @exchange, durable: true)
    Queue.bind(chan, @queue, @exchange, routing_key: "debug.*")
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
      action == "debug.db" -> ElxLogger.make(:db, :debug, payload)
      action == "debug.file" -> ElxLogger.make(:file, :debug, payload)
      action == "debug.mail" -> ElxLogger.make(:mail, :debug, payload)
    end
  rescue
    _ ->
      IO.puts("Debug Consumer did not completed")
  end
end
