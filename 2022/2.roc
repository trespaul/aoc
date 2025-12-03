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

example =
    """
    A Y
    B X
    C Z
    """

main =
    AoC.solve {
        year: 2022,
        day: 2,
        title: "Rock Paper Scissors",
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
    |> List.map \x -> when x is
        "A X" -> 4
        "B X" -> 1
        "C X" -> 7
        "A Y" -> 8
        "B Y" -> 5
        "C Y" -> 2
        "A Z" -> 3
        "B Z" -> 9
        "C Z" -> 6
        _ -> 0
    |> List.sum
    |> Num.toStr
    |> Ok

part2 : Str -> Result Str []
part2 = \in -> in
    |> parse
    |> List.map \x -> when x is
        "A X" -> 3
        "B X" -> 1
        "C X" -> 2
        "A Y" -> 4
        "B Y" -> 5
        "C Y" -> 6
        "A Z" -> 8
        "B Z" -> 9
        "C Z" -> 7
        _ -> 0
    |> List.sum
    |> Num.toStr
    |> Ok

expect parse example == [ "A Y", "B X", "C Z" ]
expect part1 example == Ok "15"
expect part2 example == Ok "12"

