defmodule ElxLogger.MixProject do
  use Mix.Project

  def project do
    [
      app: :elx_logger,
      version: "0.1.0",
      elixir: "~> 1.11",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :amqp],
      mod: {ElxLogger, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:jason, "~> 1.2"},
      {:amqp, "~> 1.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:mailman, "~> 0.4.3"}
    ]
  end

  defp description do
    """
    Library for Manage Logs data.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*", "CHANGELOG*"],
      maintainers: ["Majid Ahmaditabar"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/MajAhd/elx_logger",
        "Wiki" => "https://github.com/MajAhd/elx_logger/wiki"
      }
    ]
  end
end
