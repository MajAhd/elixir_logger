import Config

config :elx_logger, ElxLogger.Repo,
  database: "elx_logger",
  username: "postgres",
  password: "majid",
  hostname: "127.0.0.1"

config :elx_logger, ecto_repos: [ElxLogger.Repo]
