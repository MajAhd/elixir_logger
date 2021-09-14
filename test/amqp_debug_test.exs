defmodule ElxValidation.AmqpDebugTest do
  use ExUnit.Case

  @exchange Application.fetch_env!(:elx_logger, :debug_exchange)
  @message "Debug Log Test AMQP Source #{DateTime.utc_now()}"

  test "AMQP Debug logs into file" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "debug.file"
    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)

    assert is_published == :ok
  end

  test "AMQP Debug logs into db" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "debug.db"
    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)

    assert is_published == :ok
  end

  test "AMQP Debug logs publish via mail" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "debug.mail"

    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)
    assert is_published == :ok
  end
end
