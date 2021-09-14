defmodule ElxValidation.FilePublisherTest do
  use ExUnit.Case
  doctest ElxLogger.File

  test "file logs publisher" do
    assert ElxLogger.File.file_factory(
             :error,
             "Error Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok

    assert ElxLogger.File.file_factory(
             :warning,
             "Warning Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok

    assert ElxLogger.File.file_factory(
             :debug,
             "Debug Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok

    assert ElxLogger.File.file_factory(
             :info,
             "Info Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok

    assert ElxLogger.File.file_factory(
             :trace,
             "Trace Logger Unit test Source #{DateTime.utc_now()}"
           ) == :ok
  end
end
