defmodule ElxLogger.File do
  @moduledoc false
  def file_logger(log, type) do
    {:ok, file} = File.read("#{type}.txt")
    IO.puts(log)
    File.write("error.txt", "#{log}\n#{file}")
  end
end
