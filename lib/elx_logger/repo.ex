defmodule ElxLogger.Repo do
  use Ecto.Repo,
    otp_app: :elx_logger,
    adapter: Ecto.Adapters.Postgres
end
