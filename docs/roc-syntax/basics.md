# Names numbers and strings

[Guide index](../roc-syntax-guide.md) · Roc nightly `2026-09-18-1d982dc` · [Version and sources](sources.md)

- [Names and values](#names-and-values)
- [Numbers and operators](#numbers-and-operators)
- [Strings](#strings)

## Names and values

```roc
# A constant binding
name = "pen"

# An optional type annotation, followed by a definition
count : U64
count = 3

enabled = Bool.True
```

Use lowercase names for values and functions, commonly `snake_case`. Type names and tag names start with uppercase letters, such as `Str`, `Point`, `Ok`, and `BadNumStr`.

Ordinary bindings are constants. Give a newly computed value a new name; use `var $name` when you need a reassignable local variable. Avoid rebinding or shadowing a constant.

`_` discards a value in a pattern. An argument such as `_args` names an intentionally unused parameter. Functions ending in `!` indicate effects such as output; pure helpers do not use that suffix.

## Numbers and operators

```roc
expect 1_000 == 1000
expect 0x10 == 16
expect 0b101 == 5
expect 0o10 == 8

expect 7.I64 // 2 == 3
expect 7.I64 % 2 == 1
expect 7.Dec / 2 == 3.5
expect 0.1 + 0.2 == 0.3
```

Use an annotation such as `count : U64` to establish a numeric type, or a suffix such as `7.I64` in a small expression. An unconstrained number defaults to `Dec`; the literal `3` does not by itself guarantee an integer type. Unsigned types cannot represent negative values.

| Operators | Meaning |
| --- | --- |
| `+`, `-`, `*` | Addition, subtraction, multiplication |
| `/` | Division for a suitable decimal or floating-point type |
| `//` | Truncating division |
| `%` | Remainder |
| `-value` | Negation |
| `==`, `!=` | Equality and inequality |
| `<`, `<=`, `>`, `>=` | Comparisons |
| `and`, `or`, `!condition` | Boolean operations |

Use parentheses when mixing operators would make the order hard to read. Choose numeric types deliberately when subtraction, overflow, or division matters; this section is a syntax reference, not a guarantee that arbitrary arithmetic inputs are safe.

## Strings

```roc
make_label : Str, U64 -> Str
make_label = |name, count| "${name}: ${count.to_str()}"

expect make_label("items", 3) == "items: 3"
expect "line\nnext".split_on("\n") == ["line", "next"]
```

An ordinary interpolation must produce a `Str`. Convert a number with `.to_str()` before inserting it. Common escapes include `\n` for newline, `\t` for tab, `\"` for a quote, and `\\` for a backslash.

For multiline text, begin each content line with two backslashes:

```roc
two_lines : Str
two_lines =
    \\first
    \\second

expect two_lines == "first\nsecond"
```

| Operation | Example and result |
| --- | --- |
| Trim outer whitespace | `"  note  ".trim()` → `"note"` |
| Concatenate | `Str.concat("note", "book")` → `"notebook"` |
| Split | `"a,b".split_on(",")` → `["a", "b"]` |
| Join | `Str.join_with(["a", "b"], ",")` → `"a,b"` |
| Search | `"abc".contains("b")` → `Bool.True` |
| Test emptiness | `"".is_empty()` → `Bool.True` |
| Get UTF-8 bytes | `"cat".to_utf8()` → `[99, 97, 116]` |

UTF-8 bytes are not general-purpose characters. For example, `"é".count_utf8_bytes()` is `2`. An empty split separator is also **not** a character iterator: the checked compiler returns `["abc"]` for `"abc".split_on("")`.

[Previous: Quick reference](quick-reference.md) · [Guide index](../roc-syntax-guide.md) · [Next: Functions and composition](functions.md)
