defmodule ElxValidation.AmqpWarningTest do
  use ExUnit.Case

  @exchange Application.fetch_env!(:elx_logger, :warning_exchange)
  @message "Warning Log Test AMQP Source #{DateTime.utc_now()}"

  test "AMQP Warning logs into file" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "warning.file"
    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)

    assert is_published == :ok
  end

  test "AMQP Warning logs into db" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "warning.db"
    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)

    assert is_published == :ok
  end

  test "AMQP Warning logs publish via mail" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "warning.mail"

    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)
    assert is_published == :ok
  end
end
