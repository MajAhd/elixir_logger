defmodule ElxLogger.DebugConsumer do
  use GenServer
  use AMQP

  def start_link(arg \\ []) do
    GenServer.start_link(__MODULE__, arg, [])
  end

  @exchange Application.fetch_env!(:elx_logger, :debug_exchange)
  @queue "debug"

  def init(_opts) do
    {:ok, conn} = AMQP.Connection.open()
    {:ok, chan} = AMQP.Channel.open(conn)

    AMQP.Queue.declare(chan, @queue, durable: true)
    AMQP.Exchange.topic(chan, @exchange, durable: true)
    AMQP.Queue.bind(chan, @queue, @exchange, routing_key: "debug.*")
    {:ok, _consumer_tag} = AMQP.Basic.consume(chan, @queue, nil, no_ack: true)
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
    try do
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
end
