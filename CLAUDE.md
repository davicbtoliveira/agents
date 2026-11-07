# CLAUDE.md

Personal instructions for every project. They bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

- State assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them. Don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what is confusing. Ask.
- Disagree honestly. If my approach seems wrong, say so. Don't be sycophantic.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that was not requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

The test: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that are not broken.
- Match the existing style, even if you would do it differently.
- If you notice unrelated dead code, mention it. Don't delete it.
- Remove imports, variables, and functions that YOUR change made unused.
- Don't remove pre-existing dead code unless asked.

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

## 5. No Code Comments

**Let the code explain itself.**

- Don't add comments to code. Use clear names and structure instead.
- Add documentation (doc comments, docstrings) only when it is appropriate: public APIs, or behavior that the code cannot make clear.
- Documentation never exceeds 2 lines.
- Don't remove or rewrite existing comments unless your change makes them wrong.

## 6. Commits

- Always sign off commits with `-s` (`git commit -s`).
- Don't add `Co-Authored-By` lines or other AI attribution to commits or PRs.

## 7. Subagents

Pick the subagent model and effort by task type:

- Plan implementation and code review → Sonnet 5.5 (`model: sonnet`, `effort: medium`).
- Documentation writing and trivial tasks with no coding, review, or architecture → Haiku 5.5 (`model: haiku`, `effort: medium`).
- Everything else → the default model.

## 8. Responses in ASD-STE100 (Simplified Technical English)

Write every response to me in ASD-STE100 Simplified Technical English. This applies to chat replies, summaries, and explanations.

Rules:

- Use only words from the STE dictionary with their approved meaning. Use one word for one meaning (e.g. "start", not "launch/initiate/kick off").
- Technical names (product, file, function, command, flag names) and technical verbs from the project are permitted.
- Procedural sentences: max 20 words. Descriptive sentences: max 25 words.
- Write one instruction per sentence. Use the imperative for instructions ("Run the tests.").
- Use the active voice. Use only simple tenses: present, past, future.
- Do not use "-ing" verb forms, except in technical names.
- Use articles ("the", "a") and demonstratives where possible.
- Do not make noun clusters of more than three words.
- Paragraphs: one topic, max six sentences.
- Write warnings and cautions as a clear command first, then the reason.
- Use vertical lists for sequential steps or many items.

Exceptions — keep these exactly as they are, do not simplify them:

- Code, commands, logs, error messages, and quoted text.
- Commit messages, PR descriptions, code comments, and documentation files. These follow the conventions of the repository.

If I write in Portuguese, still answer in STE English unless I ask for another language.
