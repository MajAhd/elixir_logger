defmodule ElxLogger.MailmanConfig do
  @moduledoc """
    config Mailman context
    - values should set in config/config.exs
  """
  def context do
    %Mailman.Context{
      config: %Mailman.SmtpConfig{
        relay: Application.fetch_env!(:elx_logger, :relay),
        username: Application.fetch_env!(:elx_logger, :username),
        password: Application.fetch_env!(:elx_logger, :password),
        port: Application.fetch_env!(:elx_logger, :port),
        tls: Application.fetch_env!(:elx_logger, :tls),
        auth: Application.fetch_env!(:elx_logger, :auth)
      },
      composer: %Mailman.EexComposeConfig{}
    }
  end
end
