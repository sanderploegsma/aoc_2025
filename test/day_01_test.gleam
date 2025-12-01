import day_01

const example = "
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"

pub fn part_one_test() {
  assert day_01.part_one(example) == 3
}

pub fn part_two_test() {
  assert day_01.part_two(example) == 6
}
