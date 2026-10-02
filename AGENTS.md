# AGENTS.md

## Purpose
This repository is a hands-on learning project for Advent of Code in Roc.

## Roc source policy

Roc is evolving quickly and older material may use obsolete syntax or APIs.
Treat these learner-provided resources as the primary references:

1. [Mini Tutorial for the New Compiler](https://github.com/roc-lang/roc/blob/main/docs/mini-tutorial-new-compiler.md)
2. [Official Roc Examples](https://roc-lang.org/examples/)
3. [All Syntax File](https://roc-lang.org/examples/AllSyntax/README)

Also treat the repository's pinned compiler, the `app` header in
`2020/main.roc`, and diagnostics from that compiler as authoritative for this
project. Currently the app targets Roc nightly `2026-09-18-1d982dc`.

Before recommending syntax or an API:

- Check the new-compiler tutorial and official examples first.
- Make sure an example matches the pinned compiler; do not copy old-platform or
  old-compiler syntax from memory, blogs, archived examples, or search results.
- If the references disagree with the installed compiler, explain the mismatch
  and follow the pinned compiler's diagnostics and behavior.
- State uncertainty instead of guessing. Verify uncertain syntax with a small,
  puzzle-independent REPL experiment when useful.
- Keep any experiment separate from the learner's challenge implementation and
  explain what it demonstrates.

## Repository conventions

- Year entry point: `2020/main.roc`
- Shared input helpers: `2020/Input.roc`
- Day modules: `2020/days/dayNN/DayNN.roc`
- Day input: `2020/days/dayNN/input.txt`
- Day module API: `solve : Str -> { part1 : Str, part2 : Str }`
- Puzzle logic should remain pure; the runner owns file I/O and output.
- Use small top-level `expect` declarations for sample-driven checks.

The local nightly compiler is under
`roc_nightly-macos_x86_64-2026-09-18-1d982dc/`. Checks and test runs are welcome.
For a diagnostic in protected puzzle logic, explain the important message and
let the learner make the logic change. For plumbing, infrastructure, or a
structural refactor, edit and verify the requested change normally.
