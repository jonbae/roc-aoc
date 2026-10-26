# Study routine and exercises

[Guide index](../roc-syntax-guide.md) · Roc nightly `2026-09-18-1d982dc` · [Version and sources](sources.md)


For quick reference, use the [lookup table](quick-reference.md#quick-lookup) and search for a keyword such as `fold`, `??`, or `record`. For study, work through functions and blocks first, then collections and patterns, then error handling and modules.

Spend ten minutes on one group: read an example, hide it, type it from memory in a separate practice file, predict the result, and run an `expect`. Change one input and predict again. Keep experiments outside `2020/days`.

1. Write `triple : I64 -> I64`. Check that `triple(4)` equals `12`.
2. Build `{ name: "cup", count: 2 }`, create an updated record with count `3`, and verify the original still has count `2`.
3. Transform `[2, 5, 8]` by keeping numbers above `4`, then doubling them. Predict the result before running it.
4. Read the following function. Predict both `label("12")` and `label("oops")` before evaluating either:

   ```roc
   label = |text| {
       value = U64.from_str(text)?
       Ok("count ${value.to_str()}")
   }
   ```

5. Write a `match` for `[]`, `[only]`, and lists with at least two elements. Return a different string for each shape.
6. Write a loop that counts items in a list, then express the same computation with `fold`. Compare how each carries state.

<details>
<summary>Check your answers after trying</summary>

1. `triple = |number| number * 3`, with the signature above it.
2. Use `updated = { ..original, count: 3 }`; inspect both counts.
3. The result is `[10, 16]`. The chain is `.keep_if(|n| n > 4).map(|n| n * 2)`.
4. `Ok("count 12")` and `Err(BadNumStr)`. The second call returns at `?`.
5. The shapes can be `[]`, `[only]`, and `[_, _, ..]`; prefix the unused `only` name with `_` if you do not use it.
6. A loop updates `var $count`; a fold returns a new count at each step. The fold step is `|count, _item| count + 1` with initial state `0`.

</details>

[Previous: Tests and debugging](testing.md) · [Guide index](../roc-syntax-guide.md) · [Next: Sources and verification](sources.md)
