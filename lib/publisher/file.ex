defmodule ElxLogger.File do
  @error_path Path.join(:code.priv_dir(:elx_logger), "error.log")
  @warning_path Path.join(:code.priv_dir(:elx_logger), "warning.log")
  @info_path Path.join(:code.priv_dir(:elx_logger), "info.log")
  @trace_path Path.join(:code.priv_dir(:elx_logger), "trace.log")
  @debug_path Path.join(:code.priv_dir(:elx_logger), "debug.log")
  @moduledoc false

  def file_factory(type, log) do
    cond do
      type == :error -> save_log(@error_path, log)
      type == :warning -> save_log(@warning_path, log)
      type == :info -> save_log(@info_path, log)
      type == :trace -> save_log(@trace_path, log)
      type == :debug -> save_log(@debug_path, log)
      true -> IO.puts("Log type is not valid")
    end
  end

  def save_log(add, log) do
    {:ok, file} = File.read(add)
    File.write(add, "#{log}\n#{file}")
  end
end
