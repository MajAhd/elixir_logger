defmodule ElxLogger.Database do
  @moduledoc false
  def save_to_db(type, log) do
    ElxLogger.Logs.save_loge(Atom.to_string(type), log)
  end
end
