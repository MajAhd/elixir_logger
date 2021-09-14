defmodule ElxLogger.Logs do
  use Ecto.Schema

  schema "logs" do
    field(:log_type, :string)
    field(:log_message, :string)
    timestamps()
  end

  def save_log(log_type, log_message) do
    new_log_query = %ElxLogger.Logs{
      log_type: log_type,
      log_message: log_message
    }

    ElxLogger.Repo.insert!(new_log_query)
  end
end
