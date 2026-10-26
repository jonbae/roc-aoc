# Tags and error handling

[Guide index](../roc-syntax-guide.md) · Roc nightly `2026-09-18-1d982dc` · [Version and sources](sources.md)


Tags name alternatives and can carry payloads:

```roc
Entry : [Word(Str), Count(U64)]

entry_label : Entry -> Str
entry_label = |entry| match entry {
    Word(text) => text
    Count(number) => number.to_str()
}
```

`Word("pen")` and `Count(3)` can inhabit the same union. A tag such as `BadNumStr` has no payload; `InvalidCount("oops")` carries a string.

### Handle a Try explicitly

`Try(success, error)` represents success or failure using `Ok` and `Err`. For example, `U64.from_str("23")` gives `Ok(23)`, while invalid text gives `Err(BadNumStr)`.

```roc
number = match U64.from_str("23") {
    Ok(value) => value
    Err(BadNumStr) => 0
}
```

Here both branches produce a number, so `number` is a number rather than a `Try`.

### Propagate an error with a question mark

```roc
parse_count : Str -> Try(U64, [BadNumStr])
parse_count = |text| {
    number = U64.from_str(text)?
    Ok(number)
}
```

`?` unwraps an `Ok`. For an `Err`, it immediately returns that `Err` from the enclosing function. The function must therefore have a compatible `Try` return type. It is not an exception or an effect marker; pure functions can use it.

The same control flow written out:

```roc
parse_count_explicit : Str -> Try(U64, [BadNumStr])
parse_count_explicit = |text| {
    number = match U64.from_str(text) {
        Ok(value) => value
        Err(error) => return Err(error)
    }
    Ok(number)
}
```

### Replace an error or provide a fallback

```roc
parse_named_count : Str -> Try(U64, [InvalidCount(Str)])
parse_named_count = |text| {
    number = U64.from_str(text) ? |_| InvalidCount(text)
    Ok(number)
}

expect (U64.from_str("oops") ?? 0) == 0
expect (U64.from_str("23") ?? 0) == 23
```

In `? |_| InvalidCount(text)`, the callback receives the original error payload, discards it, and returns a replacement payload. Roc propagates `Err(InvalidCount(text))`.

| Form | On `Ok(value)` | On `Err(error)` |
| --- | --- | --- |
| `result?` | Continue with `value` | Return `Err(error)` from the function |
| `result ? mapper` | Continue with `value` | Return `Err(mapper(error))` |
| `result ?? fallback` | Evaluate to `value` | Evaluate to `fallback` |

Choose a fallback only when it is meaningful to treat a failure that way. Otherwise preserve enough error information for the caller to decide what to do.

[Previous: Conditionals patterns and loops](control-flow.md) · [Guide index](../roc-syntax-guide.md) · [Next: Aliases and nominal types](types.md)
