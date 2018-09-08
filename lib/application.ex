defmodule KV.Application do
  use Supervisor
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def init(:ok) do
    children = [
      {KV.Registry, name: KV.Registry},
      # Will need to resert the task in case of failures
      supervisor(Task.Supervisor, [[name: KV.TaskSupervisor, restart: :transient]]),
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def start(_type, _args) do
    Supervisor.start_link(__MODULE__, :ok, [])
  end
end
