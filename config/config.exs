import Config

config :elx_logger, ElxLogger.Repo,
  database: "elx_logger",
  username: "postgres",
  password: "majid",
  hostname: "127.0.0.1"

config :elx_logger, ecto_repos: [ElxLogger.Repo]

config :elx_logger,
  logs_reciver: "example@example.com",
  relay: "smtp.YOUR-DOMAIN.com",
  username: "USERNAME@DOMAIN.com",
  password: "PASSWORD",
  port: 587,
  tls: :always,
  auth: :always
