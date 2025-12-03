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
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    """

main =
    AoC.solve {
        year: 2022,
        day: 3,
        title: "",
        part1,
        part2,
    }

halve = \in ->
    length = Str.len in
    #Str.splitAt in length

parse : Str -> List { first : Str, second : Str }
parse = \in -> in
    |> Str.trim
    |> Str.split "\n"
    |> List.map \x ->

part1 : Str -> Result Str []
part1 = \in -> in
    |> parse
    |> Err TODO

part2 : Str -> Result Str []
part2 = \in -> in
    |> parse
    |> Err TODO

expect parse example ==
    [
        { first: "vJrwpWtwJgWr",     second: "hcsFMMfFFhFp" },
        { first: "jqHRNqRjqzjGDLGL", second: "rsFMfFZSrLrFZsSL" },
        { first: "PmmdzqPrV",        second: "vPwwTWBwg" },
        { first: "wMqvLMZHhHMvwLH",  second: "jbvcjnnSBnvTQFn" },
        { first: "ttgJtRGJ",         second: "QctTZtZT" },
        { first: "CrZsJsPPZsGz",     second: "wwsLwLmpwMDw" },
    ]

expect part1 example == Ok "157" # main: 7817
expect part2 example == Ok "70" # main: 2444



