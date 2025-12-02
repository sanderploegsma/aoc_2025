import argv
import day_01
import day_02
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn main() -> Nil {
  let solutions =
    dict.from_list([
      #(1, day_01.run),
      #(2, day_02.run),
    ])

  case
    argv.load().arguments
    |> list.first
    |> result.try(int.parse)
    |> result.try(fn(idx) { dict.get(solutions, idx) })
  {
    Ok(solution) -> solution()
    Error(_) ->
      io.println_error(
        "Valid arguments: "
        <> dict.keys(solutions)
        |> list.sort(by: int.compare)
        |> list.map(int.to_string)
        |> string.join("|"),
      )
  }
}
