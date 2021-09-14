defmodule ElxValidation.AmqpErrorTest do
  use ExUnit.Case

  @exchange Application.fetch_env!(:elx_logger, :error_exchange)
  @message "Error Log Test AMQP Source #{DateTime.utc_now()}"

  test "AMQP Error logs into file" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "error.file"

    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)

    assert is_published == :ok
  end

  test "AMQP Error logs into db" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "error.db"

    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)

    assert is_published == :ok
  end

  test "AMQP Error logs publish via mail" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "error.mail"

    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)
    assert is_published == :ok
  end
end
