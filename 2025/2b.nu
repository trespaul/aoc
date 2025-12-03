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
          ($in | into string | split chars | check_repeats | $in has true)
        }
    }
  | flatten
  | math sum
}

def check_repeats []: list<string> -> list<bool> {
  let input: list<string> = $in
  seq 1 ($input | length | $in // 2)
  | each {
      let chunk_width: int = $in
      $input
      | chunks $chunk_width
      | window 2
      | all {$in.0 == $in.1}
    }
}

# for t in [
#   [input, expected];
#   [ [11,22],                 [11, 22]     ],
#   [ [95,115],                [99, 111]    ],
#   [ [998,1012],              [999, 1010]  ],
#   [ [1188511880,1188511890], [1188511885] ],
#   [ [222220,222224],         [222222]     ],
#   [ [1698522,1698528],       []           ],
#   [ [446443,446449],         [446446]     ],
#   [ [38593856,38593862],     [38593859]   ],
#   [ [565653,565659],         [565656]     ],
#   [ [824824821,824824827],   [824824824]  ],
#   [ [2121212118,2121212124], [2121212121] ],
# ] {
#   assert equal ($t.input | find_invalid) $t.expected
# }

# const TEST = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

# assert equal ($TEST | process) 4174379265

