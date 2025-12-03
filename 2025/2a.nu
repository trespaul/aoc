use std/assert

def main [file: path] {
  open $file | process
}

def process []: string -> int {
  $in
  | str trim
  | split row ","
  | split column "-"
  | rename from to
  | update cells {detect type}
  | par-each {
      seq $in.from $in.to
      | where {
          let value = $in | into string
          ( ($value | split chars | length | $in mod 2 == 0) and
            ($value | split_in_half | $in.0 == $in.1)
          )
        }
    }
  | flatten
  | math sum
}

def split_in_half []: string -> list<string> {
  let input: string = $in
  let middle: int = $input | str length | $in // 2
  [ ($input | str substring 0..($middle - 1)),
    ($input | str substring ($middle)..)
  ]
}

# for t in [
#   [input, expected];
#   [ [11,22],                 [11, 22]     ],
#   [ [95,115],                [99]         ],
#   [ [998,1012],              [1010]       ],
#   [ [1188511880,1188511890], [1188511885] ],
#   [ [222220,222224],         [222222]     ],
#   [ [1698522,1698528],       []           ],
#   [ [446443,446449],         [446446]     ],
#   [ [38593856,38593862],     [38593859]   ],
# ] {
#   assert equal ($t.input | find_invalid) $t.expected
# }

const TEST = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

assert equal ($TEST | process) 1227775554
