# Applications and modules

[Guide index](../roc-syntax-guide.md) · Roc nightly `2026-09-18-1d982dc` · [Version and sources](sources.md)

## Files and modules in this repository

The runner's existing header selects the platform and pins the compiler. Preserve this project's header rather than copying a newer example's platform setup:

```roc
app [main!] {
    cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.22.2/9zUBxb1LtXYVc4eR4hAtd1WQDwBYDhM6HQdZz1UFCm2m.tar.zst",
    roc: "nightly-2026-09-18-1d982dc",
}
```

The platform supplies I/O. Existing runner imports include `import cli.Stdout` and `import cli.Path`; a day import looks like `import days/day03/Day03`. `Stdout.line!(...)` writes a line and returns a fallible result, so the runner handles or propagates it.

The runnable companion needs no file I/O and uses a minimal app header with the compiler pin and no external platform. It also contains this checked effectful function:

```roc
log! : Str => {}
log! = |text| echo!(text)
```

That `echo!` belongs to the minimal Echo platform context. For the project's CLI runner, follow its `cli.Stdout` style.

A separate module follows the same namespace pattern as `Input.roc`:

```roc
# Label.roc
Label :: [].{
    decorate : Str -> Str
    decorate = |text| "[${text}]"
}
```

```roc
# A neighboring importing file
import Label

expect Label.decorate("note") == "[note]"
```

Match the type module's name to its filename. `Label :: [].{ ... }` publishes functions on `Label`; the `[]` here is an empty tag-union backing type, used as a namespace, rather than an input list value. Day modules use the corresponding `DayNN :: [].{ ... }` form. Put a public member's signature and implementation inside the interface, as the existing modules do.

The day API is:

```roc
solve : Str -> { part1 : Str, part2 : Str }
```

It accepts input text and returns a record of answer strings. Keep puzzle computation pure; the runner owns file reads and output. Shared text helpers are already available through `Input.lines`, `Input.trimmed_lines`, `Input.sections`, and `Input.fields`. Check their definitions when deciding whether blank lines or outer whitespace must be preserved.

[Previous: Aliases and nominal types](types.md) · [Guide index](../roc-syntax-guide.md) · [Next: Tests and debugging](testing.md)
