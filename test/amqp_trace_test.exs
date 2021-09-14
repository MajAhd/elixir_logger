defmodule ElxValidation.AmqpTraceTest do
  use ExUnit.Case

  @exchange Application.fetch_env!(:elx_logger, :trace_exchange)
  @message "Trace Log Test AMQP Source #{DateTime.utc_now()}"

  test "AMQP Trace logs into file" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "trace.file"
    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)

    assert is_published == :ok
  end

  test "AMQP Trace logs into db" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "trace.db"
    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)

    assert is_published == :ok
  end

  test "AMQP Trace logs publish via mail" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "trace.mail"

    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)
    assert is_published == :ok
  end
end
