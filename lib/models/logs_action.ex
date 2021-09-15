defmodule ElxLogger.LogsAction do
  alias ElxLogger.Repo

  @moduledoc """
    Logs : CRUD functions
    - save_log : save logs to `logs` table
       - log_type [:error , :info , :trace , :debug , :warning]
       - log_message: string
  """

  def save_log(log_type, log_message) do
    new_log_query = %ElxLogger.Logs{
      log_type: log_type,
      log_message: log_message
    }

    Repo.insert!(new_log_query)
  end
end
