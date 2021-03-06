defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    count_letters( strand, nucleotide, 0 )
  end

  defp count_letters( [], _nucleotide, number), do: number
  defp count_letters( strand, nucleotide, number) do
    [ comparate_letter | rest ] = strand
    number = get_number( nucleotide, comparate_letter, number )
    count_letters( rest, nucleotide, number )
  end

  defp get_number(nucleotide, comparate_letter, number) when nucleotide == comparate_letter, do: number + 1
  defp get_number(_nucleotide, _comparate_letter, number), do: number

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    Map.new(@nucleotides, fn nucleotide -> {nucleotide, count(strand, nucleotide)} end)
  end
end
