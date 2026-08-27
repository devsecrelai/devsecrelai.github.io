defmodule DevSecRelAI.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    topologies = Application.get_env(:libcluster, :topologies) || []

    children = [
      {Cluster.Supervisor, [topologies, [name: DevSecRelAI.ClusterSupervisor]]},
      # Start the Telemetry supervisor
      DevSecRelAIWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DevSecRelAI.PubSub},
      # Start the Endpoint (http/https)
      DevSecRelAIWeb.Endpoint
      # Start a worker by calling: DevSecRelAI.Worker.start_link(arg)
      # {DevSecRelAI.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DevSecRelAI.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DevSecRelAIWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
