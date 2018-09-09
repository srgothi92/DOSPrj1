defmodule Mix.Tasks.Thing do
  use Mix.Task
  use Supervisor

  @shortdoc "Give a short salutation"

  def init(:ok) do
    children = [
      {KV.Registry, name: KV.Registry},
      # Will need to resert the task in case of failures
      supervisor(Task.Supervisor, [[name: KV.TaskSupervisor, restart: :transient]])
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def run(args) do
    children = [
      {KV.Registry, name: KV.Registry},
      # Will need to resert the task in case of failures
      supervisor(Task.Supervisor, [[name: KV.TaskSupervisor, restart: :transient]])
    ]

    Supervisor.init(children, strategy: :one_for_one)
    Supervisor.start_link(__MODULE__, :ok, [])
    a = KV.Registry.execute(KV.Registry, "shopping")
    IO.inspect(a)
  end
end
