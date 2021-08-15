defmodule ElxLogger do

  def listen do
    receive do
      {:debug, message} -> IO.puts(message)
      {:error, message} -> IO.puts(message)
      {:info, message} -> IO.puts(message)
      {:trace, message} -> IO.puts(message)
      {:warn, message} -> IO.puts(message)
    end
  end

  def make(log_type, message) do
    pid = spawn(ElxLogger, :listen, [])
    send pid, {String.to_atom(log_type), message}
  end
end
