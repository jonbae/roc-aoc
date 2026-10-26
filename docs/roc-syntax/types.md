# Aliases and nominal types

[Guide index](../roc-syntax-guide.md) · Roc nightly `2026-09-18-1d982dc` · [Version and sources](sources.md)


Start with aliases for ordinary shapes. Learn nominal types when you need a distinct type or an explicit public interface.

| Declaration | Purpose | Construction |
| --- | --- | --- |
| `Point : { x : I64, y : I64 }` | Alias for a record shape | `{ x: 2, y: 5 }` |
| `Position := { x : I64, y : I64 }` | Distinct nominal type with visible representation | `Position.{ x: 2, y: 5 }` |
| `Token :: { text : Str }.{ ... }` | Opaque nominal type with an associated interface | Through a function such as `Token.new("note")` |

An alias gives a shape a convenient name. A nominal type has its own identity. `::` hides the representation from outside its interface.

```roc
Position := { x : I64, y : I64 }

position_x : Position -> I64
position_x = |Position.{ x, y: _ }| x

Token :: { text : Str }.{
    new : Str -> Token
    new = |text| { text: text }

    read : Token -> Str
    read = |token| token.text
}

expect position_x(Position.{ x: 2, y: 5 }) == 2
expect Token.read(Token.new("note")) == "note"
```

Inside the `Token` interface, its functions can work with the backing record. Callers use the published functions.

For a generic function that calls a type's method, a `where` constraint can require that method:

```roc
as_text : a -> Str where [a.to_str : a -> Str]
as_text = |value| value.to_str()

expect as_text(23.U64) == "23"
```

Read the constraint as “`a` must provide a `to_str` method with this type.”

[Previous: Tags and error handling](error-handling.md) · [Guide index](../roc-syntax-guide.md) · [Next: Applications and modules](modules.md)
