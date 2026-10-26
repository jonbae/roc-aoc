# Quick reference

[Guide index](../roc-syntax-guide.md) · Roc nightly `2026-09-18-1d982dc` · [Version and sources](sources.md)

- [Quick lookup](#quick-lookup)
- [Common mixups](#common-mixups)

## Quick lookup

Read these as syntax forms; names such as `value`, `condition`, and `items` stand for your own expressions. Expand any unfamiliar form in the [topic guides](../roc-syntax-guide.md#topic-guides).

| I want to… | Form |
| --- | --- |
| Name a value | `count = 3` |
| Annotate a value | `count : U64` above its definition |
| Define a function | `add = \|left, right\| left + right` |
| Describe a pure function | `add : I64, I64 -> I64` |
| Describe an effectful function | `log! : Str => {}` |
| Call a function | `add(3, 4)` |
| Define and call a zero-argument function | `greeting = \|\| "Hello"`, then `greeting()` |
| Pass a function | `List.map(items, double)` |
| Write an inline function | `items.map(\|item\| item * 2)` |
| Choose a value | `if condition { first } else { second }` |
| Match a case | `match value { ... }` with a separate `pattern => result` line for each case |
| Build a record | `{ name: "pen", count: 3 }` |
| Read a record field | `item.count` |
| Copy a record with a changed field | `{ ..item, count: 4 }` |
| Destructure a record | `{ name, count } = item` |
| Build and destructure a tuple | `pair = ("pen", 3)`, then `(name, count) = pair` |
| Read a tuple element | `pair.0` |
| Build a list | `[2, 5, 8]` |
| Read a list element safely | `List.get(items, 1)` returns `Ok(value)` or `Err(OutOfBounds)` |
| Match a head and tail | `[head, .. as tail] => ...` |
| Interpolate a string | `"Count: ${count.to_str()}"` |
| Pipe into the first argument | `items \|> List.map(double)` |
| Propagate a failure | `value = operation()?` |
| Supply a fallback for a failure | `operation() ?? fallback` |
| Replace a failure before propagating | `operation() ? \|_\| CustomError` |
| Use a local variable | `var $total = 0`, then `$total = $total + 1` |
| Test a condition | `expect add(3, 4) == 7` |
| Add a comment | `# comment`; `## documentation comment` |

The table escapes pipe characters for Markdown rendering. In actual Roc code, type ordinary `|` characters, as in the code blocks in the topic guides.

## Common mixups

| If you forget… | Remember |
| --- | --- |
| `=` versus `==` | `=` binds or reassigns; `==` compares. |
| `:` versus `=` | `name : Type` annotates; `name = value` defines. In a record literal, `field: value` supplies a field. |
| `->` versus `=>` | `->` describes pure functions. `=>` describes effectful functions and also introduces a `match` branch result. |
| Where `return` goes | The last expression returns normally; `return` is for an early exit. |
| Single-field record shorthand | Use `{ text: text }`; `{ text }` is a block in the pinned compiler. |
| How to call or pass a function | `double(6)` calls it; `double` passes the function value. |
| How a pipe passes arguments | The left side becomes the first argument. |
| A list versus a tuple | List items share a compatible type; tuple positions can have different types. |
| How to unwrap a `Try` | Use `match`, `?`, or `??` according to the intended failure behavior. |
| Whether `?` means I/O | It means error propagation; it also works in pure functions. |
| Whether `??` returns a `Try` | It returns the successful payload or the fallback. |
| Whether numbers interpolate automatically | Convert them with `.to_str()`. |
| Whether `3` is definitely `I64` | Inference chooses the type; an unconstrained number defaults to `Dec`. |
| How to filter and reduce | This checked version uses `keep_if` and `fold`. |
| Whether `insert` mutates your binding | Capture the returned updated dictionary. |
| Whether a callback can change an outer `$var` | It cannot reassign a variable declared in another function. |
| Whether old snippets are compatible | Check their compiler and platform versions. Verify with this project's compiler. |

[Guide index](../roc-syntax-guide.md) · [Next: Names numbers and strings](basics.md)
