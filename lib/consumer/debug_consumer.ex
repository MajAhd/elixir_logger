defmodule ElxLogger.DebugConsumer do
  use GenServer
  use AMQP

  def start_link(arg \\ []) do
    GenServer.start_link(__MODULE__, arg, [])
  end

  @exchange "gen_server_test_exchange"
  @queue "debug"
  # @queue_error "#{@queue}_error"

  def init(_opts) do
    {:ok, conn} = AMQP.Connection.open()
    {:ok, chan} = AMQP.Channel.open(conn)

    AMQP.Queue.declare(chan, @queue, durable: true)

    AMQP.Exchange.fanout(chan, @exchange, durable: true)
    AMQP.Queue.bind(chan, @queue, @exchange)
    {:ok, _consumer_tag} = AMQP.Basic.consume(chan, @queue)
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
        {:basic_deliver, payload, %{delivery_tag: _tag, redelivered: _redelivered}},
        chan
      ) do
    spawn(fn -> consume(payload) end)
    {:noreply, chan}
  end

  defp consume(payload) do
    try do
      if payload.file == "true" do
        spawn(fn -> ElxLogger.File.file_factory(:debug, payload.msg) end)
      end
    rescue
      _ ->
        IO.puts("DebugConsumer did not completed at #{DateTime.utc_now()}")
    end
  end
end
