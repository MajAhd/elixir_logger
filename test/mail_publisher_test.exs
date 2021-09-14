defmodule ElxValidation.MailPublsherTest do
  use ExUnit.Case
  doctest ElxLogger.Mail

  test "email log publisher" do
    assert ElxLogger.Mail.send_log(
             :error,
             "Error Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok

    assert ElxLogger.Mail.send_log(
             :warning,
             "Warning Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok

    assert ElxLogger.Mail.send_log(
             :debug,
             "Debug Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok

    assert ElxLogger.Mail.send_log(
             :info,
             "Info Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok

    assert ElxLogger.Mail.send_log(
             :trace,
             "Trace Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok
  end
end
