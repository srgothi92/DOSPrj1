defmodule KV do
  @moduledoc """
  Documentation for KV.
  """

  @doc """
  Hello world.

  ## Examples

      iex> KV.hello()
      :world

  """
  def hello do
    :world
  end

  def perfectSquare(n, _, start, out ) when start >n do
    out
  end

  def perfectSquare(n, k, start, out) do
    last = start + k-1
    window = Enum.to_list start..last
    # IO.puts window
    seqList = checkPerfrectSq?(window)
    out = if(seqList != []) do
      [ seqList | out]
    else
      out
    end

    perfectSquare(n, k, (start + 1), out)
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
