defmodule ElxLogger.Mail do
  @moduledoc false
  import ElxLogger.MailmanConfig

  def send_log(log_type, reciever, log) do
    string_log_type = Atom.to_string(log_type)

    email = %Mailman.Email{
      subject: "Elixir Logger!",
      from: "onedaric.coin@gmail.com",
      to: [reciever],
      data: [
        name: "ElxLogger #{string_log_type} Report"
      ],
      # text: "Elx Logger text",
      html: """
       <strong> Elx Logger #{string_log_type} report at #{DateTime.utc_now() |> DateTime.to_string()} UTC! </strong>
       <p> #{log} </p>
      """
    }

    Mailman.deliver(email, context())
    :ok
  end
end
