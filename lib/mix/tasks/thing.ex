defmodule Mix.Tasks.Thing do
@moduledoc """
Custom task to find a perfect square that is the sum of squares of consecutive integers. 
"""

  use Mix.Task
  use Supervisor
  import OptionParser
  

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
  b = OptionParser.parse(args,[])

  IO.inspect elem(b,1) |> is_list
    children = [
      {KV.Registry, name: KV.Registry},
      # Will need to resert the task in case of failures
      supervisor(Task.Supervisor, [[name: KV.TaskSupervisor, restart: :transient]])
    ]

    Supervisor.init(children, strategy: :one_for_one)
    Supervisor.start_link(__MODULE__, :ok, [])
    a = KV.Registry.execute(KV.Registry,elem(b,1))
    IO.inspect(a)
  end
end
