defmodule ElxLogger.Logs do
  @moduledoc false
  use Ecto.Schema

  schema "logs" do
    field(:log_type, :string)
    field(:log_message, :string)
    timestamps()
  end
end
