Personal instructions for every project. They bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

- Ask when a choice changes the result and the code cannot answer it. Otherwise state the assumption and continue.
- If multiple interpretations exist, present them. Don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- Disagree honestly. If my approach seems wrong, say so. Don't be sycophantic.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- If you write 200 lines and it could be 50, rewrite it.

The test: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

- If you notice unrelated dead code, mention it. Don't delete it.
- Remove imports, variables, and functions that your change made unused.

The test: every changed line traces directly to my request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Turn tasks into verifiable goals:

- "Add validation" → write tests for invalid inputs, then make them pass.
- "Fix the bug" → write a test that reproduces it, then make it pass.
- "Refactor X" → make sure tests pass before and after.

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong criteria let you loop on your own. Weak criteria ("make it work") need constant clarification.

## 5. Comments

**Let the code explain itself.**

- Match the comment density of the surrounding code.
- Add a comment only when the reason is not clear from names and structure.
- Keep doc comments short, usually one or two lines.
- Don't remove or rewrite existing comments unless your change makes them wrong.

## 6. Commits and PRs

- Sign off commits with `-s` (`git commit -s`).
- If a repo asks for AI disclosure on commits or PRs, use this line instead of `Co-Authored-By`, with the real model name:

  ```
  AI-assisted: written with Claude Code ({model}) and reviewed by the author.
  ```

## 7. Subagents

Delegate these tasks to a subagent. Do not do them in the main session.

- When I tell you to implement a plan, give the implementation to an `Agent` with `model: sonnet`, `effort: medium`.
- When I ask for a code review, give the review to an `Agent` with `model: sonnet`, `effort: medium`.
- When I ask for documentation, or for a trivial task with no coding, review, or architecture, give it to an `Agent` with `model: haiku`, `effort: medium`.

The main session keeps the planning, the decisions, and the check of the subagent's result.
