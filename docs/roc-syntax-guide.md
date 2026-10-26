# Roc syntax study and reference guide

For this repository's **Roc nightly `2026-09-18-1d982dc`**. Use this guide to look up a form quickly, then study the examples to understand what it does. It covers everyday language syntax and a small selection of useful built-in APIs; it is not an exhaustive standard library catalog.

The examples use unrelated toy data, so you can practice without solving an Advent of Code challenge. The [runnable companion](reference/syntax-examples.roc) checks the main examples against the pinned compiler. Its [small imported module](reference/Label.roc) demonstrates the repository's module style.

**Version rule:** the official tutorial and examples change over time. The examples index consulted for this guide targets October 2026 nightlies, newer than this project's September compiler. The checked companion and `2020/main.roc` are the compatibility anchors here. Recheck the examples after upgrading Roc. See [sources and verification](roc-syntax/sources.md#sources-and-verification).

The guide is split into topic files below. Use the quick reference for a reminder, or follow the topic order to study. Each file links back here and to its neighboring topics.

## Topic guides

| Guide | Covers |
| --- | --- |
| [Quick reference](roc-syntax/quick-reference.md) | Syntax lookup tables and common mistakes |
| [Names numbers and strings](roc-syntax/basics.md) | Bindings, literals, operators, interpolation, and text APIs |
| [Functions and composition](roc-syntax/functions.md) | Signatures, callbacks, return values, methods, and pipelines |
| [Records tuples lists and dictionaries](roc-syntax/collections.md) | Data shapes, access, updates, map, keep_if, and fold |
| [Conditionals patterns and loops](roc-syntax/control-flow.md) | Branching, destructuring, recursion, variables, and iteration |
| [Tags and error handling](roc-syntax/error-handling.md) | Tag unions, Try, match, error propagation, and fallbacks |
| [Aliases and nominal types](roc-syntax/types.md) | Aliases, nominal identity, opaque interfaces, and constraints |
| [Applications and modules](roc-syntax/modules.md) | App headers, platforms, imports, and repository conventions |
| [Tests and debugging](roc-syntax/testing.md) | Expectations, dbg, compiler commands, and the REPL |
| [Study routine and exercises](roc-syntax/study.md) | Practice prompts and answer checks |
| [Sources and verification](roc-syntax/sources.md) | Official references, compiler version, and verification scope |

## Try the examples

From the repository root:

```powershell
roc check docs/reference/syntax-examples.roc
roc test docs/reference/syntax-examples.roc
```

The runnable companion remains in [reference/syntax-examples.roc](reference/syntax-examples.roc), with its imported [Label module](reference/Label.roc). See [Tests and debugging](roc-syntax/testing.md) for more commands.
