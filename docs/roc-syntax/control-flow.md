# Conditionals patterns and loops

[Guide index](../roc-syntax-guide.md) · Roc nightly `2026-09-18-1d982dc` · [Version and sources](sources.md)

- [Conditionals and pattern matching](#conditionals-and-pattern-matching)
- [Local variables and loops](#local-variables-and-loops)

## Conditionals and pattern matching

An `if` expression chooses a value:

```roc
describe_sign : I64 -> Str
describe_sign = |number| {
    if number < 0 {
        "negative"
    } else if number == 0 {
        "zero"
    } else {
        "positive"
    }
}
```

For an `if` used as a value, provide the `else` branch and make the branch result types compatible. Compact form is available too: `if number == 0 "zero" else "other"`.

Use `match` to select by shape or tag:

```roc
size_label : List(I64) -> Str
size_label = |numbers| match numbers {
    [] => "empty"
    [only] if only > 0 => "one positive"
    [_] => "one other"
    [_, _, ..] => "several"
}
```

The guard `if only > 0` adds a condition to that branch. Branches are checked in order. Cover every possible case; favor explicit tag cases when that helps the compiler flag a newly introduced alternative.

| Pattern | Matches |
| --- | --- |
| `[]` | An empty list |
| `[only]` | Exactly one element, binding it to `only` |
| `[head, ..]` | At least one element, binding the first |
| `[head, .. as tail]` | At least one element, also binding the remaining list |
| `[_, _, ..]` | At least two elements |
| `Ok(value)` | A success, binding its payload |
| `Err(BadNumStr)` | A particular error tag |
| `Err(_)` | Any error payload, discarded |
| `Red \| Yellow` | Either tag |
| `_` | Anything, discarded |

For example, a recursive function can consume a list one element at a time:

```roc
sum_recursive : List(I64) -> I64
sum_recursive = |numbers| match numbers {
    [] => 0
    [head, .. as tail] => head + sum_recursive(tail)
}
```

The empty-list branch ends the recursion. Each recursive call receives a shorter list. This demonstrates syntax rather than prescribing a performance strategy.

## Local variables and loops

Local reassignment can be used inside a pure function:

```roc
sum_loop : List(I64) -> I64
sum_loop = |numbers| {
    var $total = 0
    for number in numbers {
        $total = $total + number
    }
    $total
}
```

Declare with `var $total`, read with `$total`, and reassign with `$total = ...`. The `$` distinguishes variables from constants. Variables may be reassigned within the function that declares them; a callback is a separate function and cannot reassign an outer variable. Use a `for` loop or pass state through `fold` instead.

```roc
count_up : U64 -> U64
count_up = |limit| {
    var $count = 0
    while $count < limit {
        $count = $count + 1
    }
    $count
}
```

`for` and `while` are statements. Return the accumulated value after the loop. Use `break` to exit a loop early:

```roc
contains_zero : List(I64) -> Bool
contains_zero = |numbers| {
    var $found = Bool.False
    for number in numbers {
        if number == 0 {
            $found = Bool.True
            break
        } else {
            {}
        }
    }
    $found
}
```

The empty record `{}` supplies the do-nothing branch value here. A function using local reassignment can remain pure: it still computes its result solely from its inputs.

[Previous: Records tuples lists and dictionaries](collections.md) · [Guide index](../roc-syntax-guide.md) · [Next: Tags and error handling](error-handling.md)
