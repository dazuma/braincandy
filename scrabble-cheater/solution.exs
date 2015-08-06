defmodule ScrabbleCheater do

  @dict_file "/usr/share/dict/words"

  def find_words(tiles) do
    File.stream!(@dict_file)
      |> Stream.map(&String.strip/1)
      |> Stream.filter(fn word ->
        word_letters = word |> String.downcase |> String.to_char_list
        Enum.empty?(word_letters -- tiles)
      end)
      |> Enum.sort_by(&score/1)
  end

  # TODO: Maybe use the real Scrabble score
  defp score(word), do: -String.length(word)

  def main(tiles) do
    words = find_words(tiles)
    IO.puts("Found #{words |> Enum.count} words:")
    IO.puts(words |> Enum.join(", "))
  end

end

# To run with tiles 'cheater':
# elixir -r solution.exs -e "ScrabbleCheater.main('cheater')"
