defmodule ElxValidation.FilePublisherTest do
  use ExUnit.Case
  doctest ElxLogger.File

  test "error file logger" do
    assert ElxLogger.File.file_factory(:error, "Test Error Logger") == :ok
    assert ElxLogger.File.file_factory(:warning, "Test Warning Logger") == :ok
    assert ElxLogger.File.file_factory(:debug, "Test Debug Logger") == :ok
    assert ElxLogger.File.file_factory(:info, "Test Info Logger") == :ok
    assert ElxLogger.File.file_factory(:trace, "Test Trace Logger") == :ok
  end
end
