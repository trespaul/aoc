def main [file: path] {
  open $file | lines | reduce --fold {sum: 50, zeroes: 0} {|it, acc|
    let operation: string = $it | str substring 0..0
    let value: int = $it | str substring 1.. | detect type
    let sum: int = (match $operation {
      "L" => ($acc.sum - $value)
      "R" => ($acc.sum + $value)
    }) mod 100
    let zeroes: int = $acc.zeroes + (if $sum == 0 {1} else {0})
    {sum: $sum, zeroes: $zeroes}
  } | get zeroes
}
