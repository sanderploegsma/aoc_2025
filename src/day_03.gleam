import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn run() -> Nil {
  let assert Ok(input) = simplifile.read("input/03.txt")
  io.println("Part one: " <> int.to_string(part_one(input)))
  io.println("Part two: " <> int.to_string(part_two(input)))
}

pub fn part_one(input: String) -> Int {
  input
  |> string.split("\n")
  |> list.map(max_joltage(_, 2))
  |> list.fold(0, fn(a, b) { a + b })
}

pub fn part_two(input: String) -> Int {
  // Does not work on puzzle input
  input
  |> string.split("\n")
  |> list.map(max_joltage(_, 12))
  |> list.fold(0, fn(a, b) { a + b })
}

fn max_joltage(bank: String, cell_count: Int) -> Int {
  bank
  |> string.to_graphemes()
  |> list.combinations(cell_count)
  |> list.map(string.join(_, ""))
  |> list.map(int.parse)
  |> list.map(result.unwrap(_, 0))
  |> list.max(int.compare)
  |> result.unwrap(0)
}
