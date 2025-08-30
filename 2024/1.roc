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
        title: "Historian Hysteria",
        part1,
        part2,
    }

parse : Str -> { after : List I64, before : List I64 }
parse = \in -> in
    |> Str.trim
    |> Str.split "\n"
    |> List.map \x -> x
        |> Str.splitFirst "   "
        |> unwrap "invalid input"
        |> beforeAfterWith \z -> z
            |> Str.toI64
            |> unwrap "not a number"
    |> \x ->
        {
            before: List.map x .before,
            after:  List.map x .after
        }

part1 : Str -> Result Str []
part1 = \in -> in
    |> parse
    |> beforeAfterWith List.sortAsc
    |> \{ before, after } ->
        List.map2 before after \a, b -> Num.abs (a - b)
    |> List.sum
    |> Num.toStr
    |> Ok
        

part2 : Str -> Result Str []
part2 = \in -> in
    |> parse
    |> \{ before, after } ->
        List.map before \x ->
            List.countIf after \y -> y == x
            |> Num.toI64
            |> Num.mul x
    |> List.sum
    |> Num.toStr
    |> Ok


# HELPERS

unwrap = \result, message -> when result is
    Err _ -> crash message
    Ok value -> value

beforeAfterWith = \{ before, after }, f ->
    {
        before: f before,
        after:  f after,
    }


# TESTS

example =
    """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """

expect parse example ==
    {
        before: [ 3, 4, 2, 1, 3, 3 ],
        after:  [ 4, 3, 5, 3, 9, 3 ],
    }

expect part1 example == Ok "11" # main: 1579939
expect part2 example == Ok "31" # main: 20351745
