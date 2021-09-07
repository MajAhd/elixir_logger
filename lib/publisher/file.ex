defmodule ElxLogger.File do
  @error_path Path.join(:code.priv_dir(:elx_logger), "error.log")
  @warning_path Path.join(:code.priv_dir(:elx_logger), "warning.log")
  @info_path Path.join(:code.priv_dir(:elx_logger), "info.log")
  @trace_path Path.join(:code.priv_dir(:elx_logger), "trace.log")
  @debug_path Path.join(:code.priv_dir(:elx_logger), "debug.log")
  @moduledoc false

  def error_file_log(log) do
    {:ok, file} = File.read(@error_path)
    File.write(@error_path, "#{log}\n#{file}")
  end

  def warning_file_log(log) do
    {:ok, file} = File.read(@warning_path)
    File.write(@warning_path, "#{log}\n#{file}")
  end

  def info_file_log(log) do
    {:ok, file} = File.read(@info_path)
    File.write(@info_path, "#{log}\n#{file}")
  end

  def trace_file_log(log) do
    {:ok, file} = File.read(@trace_path)
    File.write(@trace_path, "#{log}\n#{file}")
  end

  def debug_file_log(log) do
    {:ok, file} = File.read(@debug_path)
    File.write(@debug_path, "#{log}\n#{file}")
  end
end
