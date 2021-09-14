# ElxLogger

Simple and easy way to Manage Log's with RabbitMq

## Logic

- Get Logs via rabbitMq
- Save Logs via : file , database
- publish log via email
- emit logs via rabbitmq `topic` excgange

## instalation

- RabbitMq
- PostgreSQL

# Config

- Postgres (config/config.exs) also read [ecto](https://hexdocs.pm/ecto/getting-started.html#content) documentation

- setup your mail data (config/config.exs):
  - logs_reciver : email address that you wants recieve logs
  - relay: if you use gmail `smtp.gmail.com`
  - username: "USERNAME@DOMAIN.com"
  - password: "YOUR PASSWORD"
- Exchange (config/config.exs):
  - debug_exchange: "debug_logs_exchange",
  - error_exchange: "error_logs_exchange",
  - info_exchange: "info_logs_exchange",
  - trace_exchange: "trace_logs_exchange",
  - warning_exchange: "warning_logs_exchange"

## Scripts

- mix deps.get
- iex -S mix
- mix run test

# Manual Test (via Nodejs)

- clone [Node.Js with RabbitMQ](https://github.com/MajAhd/nodejs_rabbitmq)
- cd topics
- node publish_topic.js "error.mail" "This Error Message will mailed"
