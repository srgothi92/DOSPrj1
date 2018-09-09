defmodule KV.Registry do
  use GenServer

  ## Client API

  @doc """
  Starts the registry.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Looks up the bucket pid for `name` stored in `server`.

  Returns `{:ok, pid}` if the bucket exists, `:error` otherwise.
  """
  def execute(server, args) do
    GenServer.call(server, {:compute, args}, 150000)
  end

  @doc """
  Ensures there is a bucket associated with the given `name` in `server`.
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  ## Server Callbacks
  def init(:ok) do
    names = %{}
    refs = %{}
    {:ok, {names, refs}}
  end

  defp combineTaskOutput(task, acc) do
    seqList =Task.await(task)
    acc = if(seqList != []) do
      [ seqList | acc]
    else
      acc
    end
  end

  def handle_call({:compute, args}, _from, state) do
    n = List.first(args) |> String.to_integer
    k = List.last(args) |> String.to_integer
    IO.inspect n
    start = System.monotonic_time(:microsecond)
    taskList = splitTask(n,k,1,[])
    out = Enum.reduce(taskList, [], fn task,acc ->  combineTaskOutput(task, acc) end)
    time_spent = System.monotonic_time(:microsecond) - start
    IO.puts(time_spent)
    {:reply, out, state}
  end

  # def handle_cast({:create, name}, {names, refs}) do
  #   if Map.has_key?(names, name) do
  #     {:noreply, {names, refs}}
  #   else
  #     {:ok, pid} = KV.Bucket.start_link([],[5,2])
  #     ref = Process.monitor(pid)
  #     refs = Map.put(refs, ref, name)
  #     names = Map.put(names, name, pid)
  #     {:noreply, {names, refs}}
  #   end
  # end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    names = Map.delete(names, name)
    {:noreply, {names, refs}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

  def splitTask(n, _, start, out ) when start >n do
    out
  end

  def splitTask(n, k, start, out) do
    last = start + k-1
    window = Enum.to_list start..last
    task = Task.Supervisor.async(KV.TaskSupervisor, fn -> checkPerfrectSq?(window) end)
    out = [task | out]
    splitTask(n, k, (start + 1), out)
  end

  defp checkPerfrectSq?(list) do
    if calculateSquare(list) |>  is_sqrt_natural? == true do
      list
    else
      []
    end
  end

  defp is_sqrt_natural?(n) when is_integer(n) do
    :math.sqrt(n) |> :erlang.trunc |> :math.pow(2) == n
  end

  defp is_sqrt_natural?(_n) do
    false
  end

  defp calculateSquare(list) do
    Enum.map(list, fn x -> x*x end) |> Enum.sum
  end
end
