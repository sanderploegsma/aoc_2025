import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/set
import gleam/string
import simplifile

pub fn run() -> Nil {
  let assert Ok(input) = simplifile.read("input/02.txt")
  io.println("Part one: " <> int.to_string(part_one(input)))
  io.println("Part two: " <> int.to_string(part_two(input)))
}

pub fn part_one(input: String) -> Int {
  count_invalid(input, fn(id) {
    let digits = int.to_string(id) |> string.to_graphemes()
    let length = list.length(digits)

    int.is_even(length) && is_invalid(digits, [length / 2])
  })
}

pub fn part_two(input: String) -> Int {
  count_invalid(input, fn(id) {
    let digits = int.to_string(id) |> string.to_graphemes()
    let length = list.length(digits)

    length > 1 && is_invalid(digits, list.range(1, length / 2))
  })
}

fn count_invalid(input: String, check: fn(Int) -> Bool) -> Int {
  string.split(input, on: ",")
  |> list.flat_map(parse_range)
  |> list.filter(check)
  |> list.fold(0, fn(a, b) { a + b })
}

fn parse_range(range: String) -> List(Int) {
  let assert Ok(#(left, right)) = string.split_once(range, on: "-")
  let assert Ok([from, to]) = result.all([int.parse(left), int.parse(right)])
  list.range(from, to)
}

fn is_invalid(digits: List(String), chunks: List(Int)) -> Bool {
  case chunks {
    [] -> False
    [n, ..rest] ->
      case list.sized_chunk(digits, into: n) |> set.from_list() |> set.size() {
        1 -> True
        _ -> is_invalid(digits, rest)
      }
  }
}
