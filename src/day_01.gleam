import gleam/int
import gleam/list
import gleam/string

type Rotation {
  Left(Int)
  Right(Int)
}

pub fn part_one(input: String) -> Int {
  string.split(input, on: "\n")
  |> list.map(parse)
  |> list.scan(from: 50, with: rotate)
  |> list.count(where: fn(a) { a == 0 })
}

pub fn part_two(input: String) -> Int {
  string.split(input, on: "\n")
  |> list.map(parse)
  |> list.flat_map(fn(r) {
    case r {
      Left(d) -> list.repeat(Left(1), times: d)
      Right(d) -> list.repeat(Right(1), times: d)
    }
  })
  |> list.scan(from: 50, with: rotate)
  |> list.count(where: fn(a) { a == 0 })
}

fn parse(line: String) -> Rotation {
  case int.parse(string.drop_start(line, 1)) {
    Ok(dist) ->
      case string.first(line) {
        Ok("L") -> Left(dist)
        Ok("R") -> Right(dist)
        _ -> Left(0)
      }
    _ -> Left(0)
  }
}

fn rotate(acc: Int, r: Rotation) -> Int {
  case r {
    Left(d) -> { acc - d } % 100
    Right(d) -> { acc + d } % 100
  }
}
