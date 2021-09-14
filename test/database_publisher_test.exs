defmodule ElxValidation.DatabasePublisherTest do
  use ExUnit.Case
  doctest ElxLogger.Database

  test "database logs Publisher" do
    assert ElxLogger.Database.save_to_db(
             :error,
             "Error Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok

    assert ElxLogger.Database.save_to_db(
             :warning,
             "Warning Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok

    assert ElxLogger.Database.save_to_db(
             :debug,
             "Debug Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok

    assert ElxLogger.Database.save_to_db(
             :info,
             "Info Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok

    assert ElxLogger.Database.save_to_db(
             :trace,
             "Trace Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok
  end
end
