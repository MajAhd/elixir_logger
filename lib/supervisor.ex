defmodule ElxLogger.Supervisor do
  use Supervisor
  use AMQP

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      # {ElxLogger.Server, []},
      {ElxLogger.DebugConsumer, []},
      {ElxLogger.ErrorConsumer, []},
      {ElxLogger.InfoConsumer, []},
      {ElxLogger.TraceConsumer, []},
      {ElxLogger.WarnConsumer, []}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
