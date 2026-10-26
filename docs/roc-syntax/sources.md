# Sources and verification

[Guide index](../roc-syntax-guide.md) · Roc nightly `2026-09-18-1d982dc` · [Version and sources](sources.md)


Primary reading, consulted on 2026-10-20:

- [Mini Tutorial for the New Compiler](https://github.com/roc-lang/roc/blob/main/docs/mini-tutorial-new-compiler.md)
- [Official Roc Examples](https://roc-lang.org/examples/)
- [All Syntax File](https://roc-lang.org/examples/AllSyntax/README)
- [List documentation](https://www.roc-lang.org/docs/main/List/) and [Str documentation](https://www.roc-lang.org/docs/main/Str/)
- [Basic dictionary example](https://roc-lang.org/examples/BasicDict/README)
- [Multiple Roc Files example](https://roc-lang.org/examples/MultipleRocFiles/README)

Project anchors: [AGENTS.md](../../AGENTS.md), [the runner](../../2020/main.roc), and [Input.roc](../../2020/Input.roc).

The companion's original examples were checked with `roc check` and exercised with `roc test` using **nightly `2026-09-18-1d982dc`**. It includes 75 passing top-level expectations across the example app and its imported module. The effectful logging and debugging functions are type checked; the tests do not invoke them. Project header and day API snippets are reference extracts rather than replacement implementations. The exercises are prompts for your own separate practice file.

This guide intentionally leaves newer or unverified features outside its scope, including optional record fields, custom literals, and newer iteration APIs. For unfamiliar syntax, start with the linked official sources and test a small independent example on the pinned compiler.

[Previous: Study routine and exercises](study.md) · [Guide index](../roc-syntax-guide.md)
