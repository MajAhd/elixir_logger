defmodule ElxValidation.DatabasePublisherTest do
  use ExUnit.Case
  doctest ElxLogger.Database

  test "database logs Publisher" do
    assert ElxLogger.Database.save_to_db(:error, "Test Error Logger") == :ok
    assert ElxLogger.Database.save_to_db(:warning, "Test Warning Logger") == :ok
    assert ElxLogger.Database.save_to_db(:debug, "Test Debug Logger") == :ok
    assert ElxLogger.Database.save_to_db(:info, "Test Info Logger") == :ok
    assert ElxLogger.Database.save_to_db(:trace, "Test Trace Logger") == :ok
  end
end
