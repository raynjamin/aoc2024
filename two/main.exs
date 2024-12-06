defmodule LevelUtil do
  defp increasing?([_]), do: true
  defp increasing?([a, b]), do: a < b
  defp increasing?([a, b | tail]), do: increasing?([a, b]) && increasing?([b | tail])

  defp decreasing?([_]), do: true
  defp decreasing?([a, b]), do: a > b
  defp decreasing?([a, b | tail]), do: decreasing?([a, b]) && decreasing?([b | tail])

  defp incremental?([_]), do: true
  defp incremental?([a, b]), do: abs(a - b) <= 3
  defp incremental?([a, b | tail]), do: incremental?([a, b]) && incremental?([b | tail])

  def safe?(list) do
    incremental?(list) && (increasing?(list) || decreasing?(list))
  end
end

IO.puts(
  File.stream!("./data.txt")
  |> Enum.map(fn line ->
    data = String.split(line, ~r/\s+/, trim: true)
    Enum.map(data, &elem(Integer.parse(&1), 0))
  end)
  |> Enum.reduce(0, fn thing, acc ->
    safe =
      Enum.any?(Enum.with_index(thing), fn {_, idx} ->
        {l, r} = Enum.split(thing, idx)
        LevelUtil.safe?(l ++ tl(r))
      end)

    if safe, do: acc + 1, else: acc
  end)
)
