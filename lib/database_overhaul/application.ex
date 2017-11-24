defmodule DatabaseOverhaul.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: DatabaseOverhaul.Worker.start_link(arg)
      # {DatabaseOverhaul.Worker, arg},
      #worker(DatabaseOverhaul.Repo, []),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DatabaseOverhaul.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
