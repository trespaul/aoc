use std/assert

def main [file: path] {
  open $file | process
}

def process []: string -> int {
  $in | str trim | lines | par-each {max_joltage} | math sum
}

def max_joltage [] {
  let $input: string = $in
  let $input_length: int = $input | str length
  seq 12 -1 1 | reduce --fold {index: -1, value: ""} {|it, acc|
    $input
    | maximum_in_range ($acc.index + 1) ($input_length - $it)
    | {index: $in.index, value: ($acc.value + ($in.item | into string))}
  }
  | get value
  | into int
}

def maximum_in_range [start: int, end: int]: string -> record<index: int, item: int> {
  $in
  | str substring ($start)..($end)
  | split chars | each {into int} | enumerate
  | largest_in_enumerated
  | {index: ($in.index + $start), item: $in.item}
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
  ["987654321111111",987654321111],
  ["811111111111119",811111111119],
  ["234234234234278",434234234278],
  ["818181911112111",888911112111],
] {
  assert equal ($test.input | max_joltage) $test.expected
}

const TEST = "
987654321111111
811111111111119
234234234234278
818181911112111
"

assert equal ($TEST | process) 3121910778619
