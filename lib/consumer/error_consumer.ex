defmodule ElxLogger.ErrorConsumer do
  use GenServer
  use AMQP

  def start_link(arg \\ []) do
    GenServer.start_link(__MODULE__, arg, name: :elx_logger)
  end

  @exchange Application.fetch_env!(:elx_logger, :error_exchange)
  @queue "error"
  # @queue_error "#{@queue}_error"

  def init(_opts) do
    {:ok, conn} = AMQP.Connection.open()
    {:ok, chan} = AMQP.Channel.open(conn)

    AMQP.Queue.declare(chan, @queue, durable: true)
    AMQP.Exchange.topic(chan, @exchange, durable: true)
    AMQP.Queue.bind(chan, @queue, @exchange, routing_key: "error.*")
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
        action == "error.db" -> ElxLogger.make(:db, :error, payload)
        action == "error.file" -> ElxLogger.make(:file, :error, payload)
        action == "error.mail" -> ElxLogger.make(:mail, :error, payload)
      end
    rescue
      _ ->
        IO.puts("Error Consumer did not completed")
    end
  end
end
