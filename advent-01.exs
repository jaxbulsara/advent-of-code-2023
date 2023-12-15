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
    first = line |> find_value
    last = line |> String.reverse() |> find_value
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

  def find_value(line) do
    find_value(String.codepoints(line))
  end

  def words_to_digits(line) do
    words_to_digits("", String.codepoints(line))
  end

  def words_to_digits(line, []), do: line

  def words_to_digits(line, [char | rest]) do
    numbers = [
      ["one", "1"],
      ["two", "2"],
      ["three", "3"],
      ["four", "4"],
      ["five", "5"],
      ["six", "6"],
      ["seven", "7"],
      ["eight", "8"],
      ["nine", "9"]
    ]

    IO.puts(line <> ", " <> char <> ", " <> List.to_string(rest))

    line = (line <> char) |> replace(numbers)
    IO.puts(line)
    line |> words_to_digits(rest)
  end

  def replace(line, []), do: line

  def replace(line, [replacement | rest]) do
    [word, digit] = replacement
    replace(line, rest) |> String.replace(word, digit)
  end
end

Advent.run()
