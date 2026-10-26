# Functions and composition

[Guide index](../roc-syntax-guide.md) · Roc nightly `2026-09-18-1d982dc` · [Version and sources](sources.md)

- [Functions and types](#functions-and-types)
- [Blocks and returning values](#blocks-and-returning-values)
- [Pipelines and method calls](#pipelines-and-method-calls)

## Functions and types

```roc
add : I64, I64 -> I64
add = |left, right| left + right

double : I64 -> I64
double = |number| number * 2

greeting = || "Hello"

expect add(3, 4) == 7
expect greeting() == "Hello"
```

Read `I64, I64 -> I64` as “takes two signed integers and returns a signed integer.” Commas separate the arguments. The names between `|` characters are parameters; the expression afterward is the body. Calls use parentheses and commas.

Functions are values. `double` refers to the function; `double(6)` calls it. Pass a named function or an inline function to another function:

```roc
expect List.map([2, 5, 8], double) == [4, 10, 16]
expect [2, 5, 8].map(|number| number * 2) == [4, 10, 16]
```

Types are inferred even when you omit annotations. An annotation documents and constrains the inferred type; omitting it does not disable type checking.

| Type form | Meaning |
| --- | --- |
| `Str` | String |
| `Bool` | Boolean |
| `I64` | Signed 64-bit integer |
| `U64` | Unsigned 64-bit integer |
| `Dec` | Fixed-point decimal |
| `F32`, `F64` | Binary floating point |
| `List(Str)` | List of strings |
| `(Str, U64)` | Tuple with two positions |
| `{ x : I64, y : I64 }` | Record with named fields |
| `[Red, Yellow, Green]` | Tag union |
| `Try(U64, [BadNumStr])` | Successful integer or a particular failure |
| `I64 -> I64` | Pure function type |
| `Str => {}` | Effectful function returning an empty record |

A lowercase name in a type annotation is a **type variable**:

```roc
identity : a -> a
identity = |value| value
```

The same `a` on both sides means the input and output have the same type. It can be `Str` in one call and `U64` in another. A callback type is parenthesized when it appears inside a larger signature, for example the shape `List(a), (a -> b) -> List(b)` for `List.map`.

## Blocks and returning values

```roc
double : I64 -> I64
double = |number| {
    result = number * 2
    result
}
```

The final expression is the block's value, so it is also this function's result. A block can contain several statements before that expression. Separate statements with newlines; do not add semicolons.

Use `return value` to leave the enclosing function early. It does not merely leave the nearest pair of braces. The [explicit error handling example](error-handling.md#propagate-an-error-with-a-question-mark) demonstrates this.

Braces have several roles. `{ count: 3 }` is a record; `{ calculation }` can be a block. **For a one-field record, use an explicit label**, such as `{ text: text }`. The checked compiler treats `{ text }` as a block that returns `text`. Multiple-field shorthand such as `{ name, count }` is supported.

## Pipelines and method calls

These three expressions produce the same value:

```roc
List.map([2, 5, 8], double)
[2, 5, 8].map(double)
[2, 5, 8] |> List.map(double)
```

`value.method(args)` dispatches through the value's type. It is useful for functions associated with that type. `|>` passes the left value as the **first argument** of the call on its right, and also works with suitable functions in scope.

```roc
total =
    [2, 5, 8]
    |> List.map(double)
    |> List.fold(0, |sum, number| sum + number)
# total is 30
```

Read a pipeline from top to bottom. `List.map(double)` on the right side of `|>` is pipeline syntax; do not assume it is a standalone partially applied call elsewhere.

[Previous: Names numbers and strings](basics.md) · [Guide index](../roc-syntax-guide.md) · [Next: Records tuples lists and dictionaries](collections.md)
