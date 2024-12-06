input = File.read!("./input.txt")

IO.puts("Part One")

IO.puts(
  Enum.reduce(Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)/, input), 0, fn thing, acc ->
    acc + elem(Integer.parse(Enum.at(thing, 1)), 0) * elem(Integer.parse(Enum.at(thing, 2)), 0)
  end)
)

IO.puts("Part Two")

IO.puts(
  elem(Enum.reduce(
    Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)|(do\(\))|(don\'t\(\))/, input),
    {0, true},
    fn thing, {curr, active} ->
      op = Enum.at(thing, 0)
      IO.puts op
      cond do
        String.contains?(op, "mul") && active ->
          {curr +
             elem(Integer.parse(Enum.at(thing, 1)), 0) * elem(Integer.parse(Enum.at(thing, 2)), 0),
           active}

        String.contains?(op, "mul") && !active ->
          {curr, active}

        String.contains?(op, "don't") ->
          {curr, false}

        String.contains?(op, "do") ->
          {curr, true}
      end
    end
  ), 0)
)
