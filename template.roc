app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.17.0/lZFLstMUCUvd5bjnnpYromZJXkQUrdhbva4xdBInicE.tar.br",
    aoc: "https://github.com/lukewilliamboswell/aoc-template/releases/download/0.2.0/tlS1ZkwSKSB87_3poSOXcwHyySe0WxWOWQbPmp7rxBw.tar.br",
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
        day: 1,
        title: "",
        part1,
        part2,
    }

parse : Str -> List Str
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
    """

expect parse example == []
expect part1 example == Ok ""
expect part2 example == Ok ""
