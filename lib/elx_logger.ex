defmodule ElxLogger do
  @moduledoc """
    Trigger log actions :
     file : save to file
     db : save to db
     mail : publish log via email
  """
  use Application
  alias ElxLogger.{Database, File, Mail}

  def start(_types, _args) do
    ElxLogger.Supervisor.start_link()
  end

  def listen do
    receive do
      {:file, log_type, message} ->
        spawn(fn -> File.file_factory(log_type, message) end)

      {:db, log_type, message} ->
        spawn(fn -> Database.save_to_db(log_type, message) end)

      {:mail, log_type, message} ->
        spawn(fn -> Mail.send_log(log_type, message) end)
    end
  end

  def make(action, log_type, message) do
    pid = spawn(ElxLogger, :listen, [])
    send(pid, {action, log_type, message})
  end
end
