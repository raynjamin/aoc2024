{left, right} =
  File.stream!("./data.txt")
  |> Enum.map(fn line ->
    [col1, col2] = String.split(line, ~r/\s+/, trim: true)
    {String.to_integer(col1), String.to_integer(col2)}
  end)
  |> Enum.unzip()

IO.puts Enum.map(left, fn n ->
  n * Enum.count(right, &(n == &1))
end) |> Enum.reduce(0, &(&1 + &2))
