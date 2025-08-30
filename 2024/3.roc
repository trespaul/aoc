app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.17.0/lZFLstMUCUvd5bjnnpYromZJXkQUrdhbva4xdBInicE.tar.br",
    aoc: "https://github.com/lukewilliamboswell/aoc-template/releases/download/0.2.0/tlS1ZkwSKSB87_3poSOXcwHyySe0WxWOWQbPmp7rxBw.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br"
}

import pf.Stdin
import pf.Stdout
import pf.Utc
import aoc.AoC {
    stdin: Stdin.readToEnd,
    stdout: Stdout.write,
    time: \{} -> Utc.now {} |> Task.map Utc.toMillisSinceEpoch,
}

main =
    AoC.solve {
        year: 2024,
        day: 3,
        title: "Mull It Over",
        part1,
        part2,
    }

parse : Str -> List (Num *, Num *)
parse = \in -> in
    |> Str.trim
    |> Str.split "\n"

part1 : Str -> Result Str []
part1 = \in -> in
    |> parse
    |> Err TODO

part2 : Str -> Result Str []
part2 = \in -> in
    |> parse
    |> Err TODO


example =
    """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """

expect parse example == [ (2, 4), (5, 5), (11, 8), (8, 5) ]
expect part1 example == Ok "161" # main: 183669043
expect part2 example == Ok "48"

