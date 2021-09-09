defmodule ElxLogger.Repo.Migrations.Loggers do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :log_type, :string , size: 50
      add :log_message, :string
      timestamps()
    end
  end
end
