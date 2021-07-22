defmodule ElxLoggerTest do
  use ExUnit.Case
  doctest ElxLogger

  test "greets the world" do
    assert ElxLogger.hello() == :world
  end
end
