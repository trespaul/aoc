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
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
    """

main =
    AoC.solve {
        year: 2022,
        day: 1,
        title: "Calorie Counting",
        part1,
        part2,
    }

parse = \in -> in
    |> Str.split "\n\n"
    |> List.map \x -> x
        |> Str.trim
        |> Str.split "\n"
        |> List.map \y -> y
            |> Str.toU64
            |> Result.withDefault 0

part1 = \in -> in
    |> parse
    |> List.map List.sum
    |> List.max
    |> Result.map Num.toStr

part2 = \in -> in
    |> parse
    |> List.map List.sum
    |> List.sortDesc
    |> List.takeFirst 3
    |> List.sum
    |> Num.toStr
    |> Ok

expect parse example ==
    [ [1000, 2000, 3000], [4000], [5000, 6000], [7000, 8000, 9000], [10000] ]

expect part1 example == Ok "24000"
expect part2 example == Ok "45000"
