defmodule Mix.Tasks.PerfectSquare do
  use Mix.Task
  use Supervisor
  import OptionParser
  @moduledoc """
Custom task to find the consecutive sequence of integers whose sum of squares is a perfect square.
Takes the input in the form of n,k where the perfect square sequence will be of length k between 1 and n.
## Example
Command : mix PerfectSquare 3 2
Output : [[3,4]]
"""
   @shortdoc "Find the sequence of integers"

   @doc "Implementing init function required by Supervisor to initialise GenServer"
  def init(:ok) do
    children = [
      {DOSPRJ.TaskManager, name: DOSPRJ.TaskManager},
      # Will need to resert the task in case of failures
      supervisor(Task.Supervisor, [[name: DOSPRJ.TaskSupervisor, restart: :transient]])
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end

  @doc "Implementing the run function of custom task to call the GenServer and monitor the task"
  def run(args) do
    input = OptionParser.parse(args,[])
    Supervisor.start_link(__MODULE__, :ok, [])
    output = DOSPRJ.TaskManager.execute(DOSPRJ.TaskManager,elem(input,1))
    IO.inspect(output)
  end
end
