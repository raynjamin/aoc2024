{left, right} =
  File.stream!("./data.txt")
  |> Enum.map(fn line ->
    [col1, col2] = String.split(line, ~r/\s+/, trim: true)
    {String.to_integer(col1), String.to_integer(col2)}
  end)
  |> Enum.unzip()


IO.puts Enum.zip(Enum.sort(left), Enum.sort(right))
  |> Enum.reduce(0, fn {l, r}, acc -> acc + abs(l - r) end)
