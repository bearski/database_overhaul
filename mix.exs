defmodule DatabaseOverhaul.Mixfile do
  use Mix.Project

  def project do
    [
      app: :database_overhaul,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [
        :logger,
        :postgrex
      ],
      mod: {DatabaseOverhaul.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "2.0.1"},
      {:postgrex, "0.11.2"}
    ]
  end
end
