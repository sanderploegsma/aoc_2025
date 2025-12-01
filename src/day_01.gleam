import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

pub fn run() -> Nil {
  let assert Ok(input) = simplifile.read("input/01.txt")
  io.println("Part one: " <> int.to_string(part_one(input)))
  io.println("Part two: " <> int.to_string(part_two(input)))
}

pub fn part_one(input: String) -> Int {
  let parse_line = fn(line: String) -> Int {
    case string.first(line), int.parse(string.drop_start(line, 1)) {
      Ok("L"), Ok(d) -> -1 * d
      Ok("R"), Ok(d) -> d
      _, _ -> 0
    }
  }

  string.split(input, on: "\n")
  |> list.map(parse_line)
  |> rotate_and_count_zeroes
}

pub fn part_two(input: String) -> Int {
  let parse_line = fn(line: String) -> List(Int) {
    case string.first(line), int.parse(string.drop_start(line, 1)) {
      Ok("L"), Ok(d) -> list.repeat(-1, times: d)
      Ok("R"), Ok(d) -> list.repeat(1, times: d)
      _, _ -> []
    }
  }

  string.split(input, on: "\n")
  |> list.flat_map(parse_line)
  |> rotate_and_count_zeroes
}

fn rotate_and_count_zeroes(rotations: List(Int)) {
  rotations
  |> list.scan(from: 50, with: fn(acc, cur) { { acc + cur } % 100 })
  |> list.count(where: fn(a) { a == 0 })
}
