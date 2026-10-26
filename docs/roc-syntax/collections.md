# Records tuples lists and dictionaries

[Guide index](../roc-syntax-guide.md) · Roc nightly `2026-09-18-1d982dc` · [Version and sources](sources.md)

Examples using `double` refer to the function defined in [Functions and types](functions.md#functions-and-types).

- [Records and tuples](#records-and-tuples)
- [Lists and transformations](#lists-and-transformations)
- [Dictionaries](#dictionaries)

## Records and tuples

Records group **named** fields:

```roc
Point : { x : I64, y : I64 }

move_right : Point -> Point
move_right = |point| { ..point, x: point.x + 1 }

record_total : Point -> I64
record_total = |point| {
    { x, y } = point
    x + y
}
```

`point.x` reads a field. `{ x, y } = point` binds both fields to local names. `{ ..point, x: ... }` produces an updated record while preserving the original record's value.

Record shorthand uses names already in scope:

```roc
name = "pen"
count = 3
item = { name, count }
# Equivalent to { name: name, count: count }
```

Tuples group values by **position**, and their elements may have different types:

```roc
pair : (Str, U64)
pair = ("pen", 3)

(name, count) = pair
# pair.0 is "pen"; pair.1 is 3
```

Tuple field positions start at zero. A list element lookup uses `List.get`, rather than tuple field syntax.

## Lists and transformations

```roc
numbers : List(I64)
numbers = [2, 5, 8]
```

List items must have compatible types. Use a tuple for a fixed collection of differently typed positions, or wrap alternatives in tags when building a heterogeneous collection.

| Task | Example | Result |
| --- | --- | --- |
| Count items | `[2, 5, 8].len()` | `3` |
| Read index 1 | `List.get([2, 5, 8], 1)` | `Ok(5)` |
| Read beyond the end | `List.get([2, 5, 8], 9)` | `Err(OutOfBounds)` |
| Read the first item of an empty list | `List.first([])` | `Err(ListWasEmpty)` |
| Transform each item | `[2, 5, 8].map(\|n\| n * 2)` | `[4, 10, 16]` |
| Keep matching items | `[2, 5, 8].keep_if(\|n\| n > 4)` | `[5, 8]` |
| Accumulate a result | `[2, 5, 8].fold(0, \|total, n\| total + n)` | `15` |
| Parse every item | `List.map_try(["3", "9"], U64.from_str)` | `Ok([3, 9])` |

`map` changes each element. `keep_if` selects elements. `fold` carries a state through the list, taking the initial state and a callback whose arguments are **state first, item second**. The callback returns the next state.

`map_try` combines fallible transformations: it returns all successful results in `Ok`, or an `Err` if a transformation fails. Ordinary `map` with a fallible callback instead produces a list of individual `Try` values.

## Dictionaries

```roc
counts : Dict(Str, U64)
counts = Dict.empty().insert("pen", 3)

updated = counts.insert("pen", 4)

expect counts.get("pen") == Ok(3)
expect updated.get("pen") == Ok(4)
expect counts.get("paper") == Err(KeyNotFound)
```

Read `Dict(Str, U64)` as “string keys with unsigned-integer values.” `insert` returns an updated dictionary; capture its result. The original dictionary retains its value. Lookup is fallible, so handle its `Try` rather than assuming a key exists.

[Previous: Functions and composition](functions.md) · [Guide index](../roc-syntax-guide.md) · [Next: Conditionals patterns and loops](control-flow.md)
