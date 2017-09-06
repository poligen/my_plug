defmodule MyPlug.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, MyRouter, [], [port: 4001]),
      Plug.Adapters.Cowboy.child_spec(:http, MyPlug, [], [port: 4000])
      # Starts a worker by calling: MyPlug.Worker.start_link(arg)
      # {MyPlug.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyPlug.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
