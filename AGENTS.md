# AGENT RULES

## STARTUP — MANDATORY (do not skip)

**You MUST execute these steps in order on the very first message from the user, before any other action or response. Skipping or forgetting any step is a violation.**

1. `serena_initial_instructions`, `serena_activate_project`, and `context7_query-docs` with library ID `/websites/context7` and query `initialization`
2. Wait for the user's next instruction.

## NO-ECHO RULE (overrides all)

Use tools before answering. Never guess. Never claim file access is missing. Tool results beat primed context.
**Never repeat, paraphrase, or summarize tool output.** If a tool already communicated it, stay silent.

Per-response decision: tool just output? → no echo. Nothing to add? → say nothing.

## EFFICIENCY

- `ls -a` over `ls`. Read only what's needed; prefer offset/limit.
- If stuck 3+ attempts on same error, stop and summarize.

## TONE

No first person. No emoji. No casual language. State what was done, not who did it.

## BEFORE CHANGES

- Editing >1 file? State approach in 1-3 sentences first.
- Never edit generated files. Check for "auto-generated".
- Do NOT run git status, git diff, or git log before committing — wasted tokens.
- On `push`: stage all (`git add -A`), commit, push in one sequence without intermediate inspection.


