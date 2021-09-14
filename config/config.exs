import Config

config :elx_logger, ElxLogger.Repo,
  database: "elx_logger",
  username: "postgres",
  password: "majid",
  hostname: "127.0.0.1"

config :elx_logger, ecto_repos: [ElxLogger.Repo]

config :elx_logger,
  # Mail Data
  logs_reciver: "example@example.com",
  relay: "smtp.YOUR-DOMAIN.com",
  username: "USERNAME@DOMAIN.com",
  password: "PASSWORD",
  port: 587,
  tls: :always,
  auth: :always,
  # Consumer data
  debug_exchange: "debug_logs_exchange",
  error_exchange: "error_logs_exchange",
  info_exchange: "info_logs_exchange",
  trace_exchange: "trace_logs_exchange",
  warning_exchange: "warning_logs_exchange"
