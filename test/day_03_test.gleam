import day_03

const example = "
987654321111111
811111111111119
234234234234278
818181911112111"

pub fn part_one_test() {
  assert day_03.part_one(example) == 357
}

pub fn part_two_test() {
  assert day_03.part_two(example) == 3_121_910_778_619
}
