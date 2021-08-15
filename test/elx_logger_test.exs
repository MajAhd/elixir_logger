defmodule ElxLoggerTest do
  use ExUnit.Case
  doctest ElxLogger

  test "make log" do
    assert ElxLogger.make("error", "Sample Error") == {:error, "Sample Error"}
  end
end
