defmodule ElxValidation.AmqpInfoTest do
  use ExUnit.Case

  @exchange Application.fetch_env!(:elx_logger, :info_exchange)
  @message "Info Log Test AMQP Source #{DateTime.utc_now()}"

  test "AMQP Info logs into file" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "info.file"
    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)

    assert is_published == :ok
  end

  test "AMQP Info logs into db" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "info.db"
    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)

    assert is_published == :ok
  end

  test "AMQP Info logs publish via mail" do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    topic = "info.mail"

    AMQP.Exchange.topic(channel, @exchange, durable: true)
    is_published = AMQP.Basic.publish(channel, @exchange, topic, @message)
    AMQP.Connection.close(connection)
    assert is_published == :ok
  end
end
