# Advent of Code in Roc

This repository contains the Advent of Code 2020 solutions. Puzzle logic is
kept pure in a module for each day, while one runner owns file I/O and output.

For syntax lookup and practice, see the [Roc syntax study and reference guide](docs/roc-syntax-guide.md).

```text
2020/
├── main.roc
├── Input.roc
└── days/
    └── day01/
        ├── Day01.roc
        └── input.txt
```

Run a day from the 2020 directory:

```sh
cd 2020
roc main.roc -- 01
```

`main.roc` reads the day's `input.txt`, calls its pure `solve` function, and
prints both answers. `Input.roc` contains reusable text parsing helpers.

To add a day:

1. Create `days/dayNN/DayNN.roc` and `days/dayNN/input.txt`.
2. Import `days/dayNN/DayNN` in `main.roc`.
3. Add a `"NN"` branch to the dispatch in `run!`.

Keep each day's public API consistent:

```roc
solve : Str -> { part1 : Str, part2 : Str }
```

This keeps file handling out of puzzle code and makes `solve` easy to test with
sample input using top-level `expect` declarations.
