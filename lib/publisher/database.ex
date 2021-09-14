defmodule ElxLogger.Database do
  @moduledoc false
  def save_to_db(type, log) do
    ElxLogger.Logs.save_log(Atom.to_string(type), log)
    :ok
  rescue
    _ ->
      false
  end
end
