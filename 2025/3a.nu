use std/assert

def main [file: path] {
  open $file | process
}

def process []: string -> int {
  $in | str trim | lines | par-each {max_joltage} | math sum
}

def max_joltage [] {
  let $input = $in | split chars | each {into int} | enumerate
  let first = $input | reverse | drop nth 0 | reverse | largest_in_enumerated
  let second = $input | drop nth ..$first.index | largest_in_enumerated
  ($first.item * 10) + ($second.item)
}

def largest_in_enumerated [] {
  $in | reduce --fold {index: 0, item: 0} {|it, acc|
    if $it.item > $acc.item {
      {index: $it.index, item: $it.item}
    } else {
      $acc
    }
  }
}


for test in [
  [input, expected];
  ["987654321111111",98],
  ["811111111111119",89],
  ["234234234234278",78],
  ["818181911112111",92],
] {
  assert equal ($test.input | max_joltage) $test.expected
}

const TEST = "
987654321111111
811111111111119
234234234234278
818181911112111
"

assert equal ($TEST | process) 357
