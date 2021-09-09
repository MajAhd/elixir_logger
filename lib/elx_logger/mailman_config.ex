defmodule ElxLogger.MailmanConfig do
  def context do
    %Mailman.Context{
      config: %Mailman.SmtpConfig{
        relay: "smtp.YOUR-DOMAIN.com",
        username: "USER-NAME@domain.com",
        password: "YOUR PASSWORD",
        port: 587,
        tls: :always,
        auth: :always
      },
      composer: %Mailman.EexComposeConfig{}
    }
  end
end
