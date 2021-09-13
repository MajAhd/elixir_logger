defmodule ElxLogger do
  use Application

  def start(_types, _args) do
    ElxLogger.Supervisor.start_link()
  end

  def listen do
    receive do
      {:file, log_type, message} ->
        spawn(fn -> ElxLogger.File.file_factory(log_type, message) end)

      {:db, log_type, message} ->
        spawn(fn -> ElxLogger.Database.save_to_db(log_type, message) end)

      {:mail, log_type, message} ->
        spawn(fn -> ElxLogger.Mail.send_log(log_type, message) end)
    end
  end

  def make(action, log_type, message) do
    pid = spawn(ElxLogger, :listen, [])
    send(pid, {action, log_type, message})
  end
end
