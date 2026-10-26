# Tests and debugging

[Guide index](../roc-syntax-guide.md) · Roc nightly `2026-09-18-1d982dc` · [Version and sources](sources.md)

The `add` and `double` functions are defined in [Functions and types](functions.md#functions-and-types). The `Point` and `move_right` definitions are in [Records and tuples](collections.md#records-and-tuples).


Use a small top-level `expect` for one behavior:

```roc
expect add(3, 4) == 7

expect {
    original : Point
    original = { x: 2, y: 5 }
    moved = move_right(original)
    moved.x == 3 and original.x == 2
}
```

A block-form `expect` ends with a Boolean expression. Top-level expectations run with `roc test`. Keep tests close to the behavior they teach.

`dbg` helps inspect an intermediate value, including inside a pure function:

```roc
debug_double : I64 -> I64
debug_double = |number| {
    dbg number
    double(number)
}
```

Use `dbg number` as a statement and leave a normal result expression at the end. `crash "message"` deliberately aborts execution; use `Try` for failures the caller should handle. Do not rely on development `expect` checks as production input validation.

From the repository root:

```powershell
roc version
roc check docs/reference/syntax-examples.roc
roc test docs/reference/syntax-examples.roc
roc repl
```

Inside the REPL, try `U64.from_str("23")`, `U64.from_str("oops")`, or `[2, 5, 8].map(|n| n * 2)`. Check the displayed type or result when an unfamiliar form is ambiguous.

Use `roc fmt path/to/file.roc` to format a file; it edits that file. To run a registered puzzle day, use the existing runner from `2020`:

```powershell
cd 2020
roc main.roc -- 01
```

[Previous: Applications and modules](modules.md) · [Guide index](../roc-syntax-guide.md) · [Next: Study routine and exercises](study.md)
