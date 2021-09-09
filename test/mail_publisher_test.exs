defmodule ElxValidation.MailPublsherTest do
  use ExUnit.Case
  doctest ElxLogger.Mail

  test "email log publisher" do
    reciever = "mjd.ahd.tbr@gmail.com"
    assert ElxLogger.Mail.send_log(:error, reciever, "Test Error Logger") == :ok
    assert ElxLogger.Mail.send_log(:warning, reciever, "Test Warning Logger") == :ok
    assert ElxLogger.Mail.send_log(:debug, reciever, "Test Debug Logger") == :ok
    assert ElxLogger.Mail.send_log(:info, reciever, "Test Info Logger") == :ok
    assert ElxLogger.Mail.send_log(:trace, reciever, "Test Trace Logger") == :ok
  end
end
