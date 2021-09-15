defmodule ElxLogger.Database do
  @moduledoc false
  alias ElxLogger.LogsAction

  def save_to_db(type, log) do
    LogsAction.save_log(Atom.to_string(type), log)
    :ok
  rescue
    _ ->
      false
  end
end
