import argv
import day_01
import gleam/int
import gleam/io
import gleam/result
import simplifile

pub fn main() -> Nil {
  case argv.load().arguments {
    ["1", "1", input_file] -> run_with_file(input_file, day_01.part_one)
    _ -> io.println("Usage: aoc_2025 <day> <part> [input_file]")
  }
}

fn run_with_file(input_file: String, target: fn(String) -> Int) {
  simplifile.read(input_file)
  |> result.map(target)
  |> result.map(int.to_string)
  |> result.unwrap("Error reading file " <> input_file)
  |> io.println
}
