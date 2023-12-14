defmodule Advent do
  @input "input/day01.txt"
  def run() do
    {:ok, input} = File.read(@input)

    IO.puts("Part 1:")

    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&decode/1)
    |> Enum.sum()
    |> IO.puts()

    IO.puts("\nPart 2")

    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&words_to_digits/1)
    |> Enum.map(&decode/1)
    |> Enum.sum()
    |> IO.puts()
  end

  def decode(line) do
    first = line |> String.codepoints() |> find_value
    last = line |> String.reverse() |> String.codepoints() |> find_value
    {decoded, _} = (first <> last) |> Integer.parse()
    decoded
  end

  def find_value([char | rest]) do
    case Integer.parse(char) do
      :error ->
        find_value(rest)

      _ ->
        char
    end
  end

  def words_to_digits(line) do
    numbers = [
      ["nine", "9"],
      ["eight", "8"],
      ["seven", "7"],
      ["six", "6"],
      ["five", "5"],
      ["four", "4"],
      ["three", "3"],
      ["two", "2"],
      ["one", "1"]
    ]

    IO.puts(line)
    line = replace(numbers, line)
    IO.puts(line)
    line
  end

  def replace([], line), do: line

  def replace([replacement | rest], line) do
    [word, digit] = replacement
    replace(rest, line) |> String.replace(word, digit)
  end
end

Advent.run()
