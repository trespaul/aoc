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
        day: 2,
        title: "Red-Nosed Reports",
        part1,
        part2,
    }


parse : Str -> List (List I64)
parse = \in -> in
    |> Str.trim
    |> Str.split "\n"
    |> List.map \x -> x
        |> Str.split " "
        |> List.map \y -> y
            |> Str.toI64
            |> \z -> when z is
                Err _ -> crash "not a number"
                Ok result -> result

isSafe : List (Num *) -> Bool
isSafe = \list -> list
    |> \y -> List.map2 y (List.dropFirst y 1) \a, b -> a - b
    |> \y ->
        List.all y ( \z -> z >= 1 && z <= 3 ) ||
        List.all y ( \z -> z >= -3 && z <= -1)

sublists : List a -> List (List a)
sublists = \list ->
    List.range { start: At 0, end: Before (List.len list) }
    |> List.map \x -> List.dropAt list x


part1 : Str -> Result Str []
part1 = \in -> in
    |> parse
    |> List.countIf \x -> isSafe x == Bool.true
    |> Num.toStr
    |> Ok

part2 : Str -> Result Str []
part2 = \in -> in
    |> parse
    |> List.countIf \x -> x
        |> sublists
        |> List.any \y -> isSafe y
        == Bool.true
    |> Num.toStr
    |> Ok


# TESTS

example =
    """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

expect parse example ==
    [
        [ 7, 6, 4, 2, 1 ],
        [ 1, 2, 7, 8, 9 ],
        [ 9, 7, 6, 2, 1 ],
        [ 1, 3, 2, 4, 5 ],
        [ 8, 6, 4, 4, 1 ],
        [ 1, 3, 6, 7, 9 ],
    ]
expect part1 example == Ok "2" # main: 421
expect part2 example == Ok "4" # main: 476
