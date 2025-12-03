# use std/assert

def main [file: path] {
  open $file | process
}

def process []: string -> int {
  $in | lines --skip-empty | reduce --fold {sum: 50, zeroes: 0} {|it, acc|
    let operation: string = $it | str substring 0..0
    let value: int = $it | str substring 1.. | detect type
    let raw_sum: int = match $operation {
      "L" => ($acc.sum - $value)
      "R" => ($acc.sum + $value)
    }
    let zeroes: int = (
      ($raw_sum | math abs | $in // 100)
      + (if $raw_sum <= 0 and $acc.sum != 0 {1} else {0})
    )
    {sum: ($raw_sum mod 100), zeroes: ($acc.zeroes + $zeroes) }
  } | get zeroes
}

# const TEST = "
# L68
# L30
# R48
# L5
# R60
# L55
# L1
# L99
# R14
# L82
# "

# assert equal ($TEST | process) 6
