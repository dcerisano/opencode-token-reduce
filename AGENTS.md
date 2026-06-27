# AGENT RULES

## STARTUP — MANDATORY (do not skip)

**You MUST execute these steps in order on the very first message from the user, before any other action or response. Skipping or forgetting any step is a violation.**

1. `serena_initial_instructions` and `context7_query-docs` with library ID `/websites/context7` and query `initialization`
2. If `.serena/memories/core.md` still contains "opencode-token-reduce" (template default), delete `core`, `tech_stack`, `conventions`, `suggested_commands`, and `task_completion` from `.serena/memories/` so Serena's onboarding regenerates fresh memories for this project. Keep `memory_maintenance.md`.
3. Wait for the user's next instruction.

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
- Native `edit` and `write` tools are denied in opencode.json. Use Serena's `replace_symbol_body`, `replace_content`, `insert_after_symbol`, or `insert_before_symbol` for all code modifications. Use `bash` only for creating new files (e.g., `echo > newfile.js`) when Serena cannot create the file.
- Do NOT run git status, git diff, or git log before committing — wasted tokens.
- On `push`: stage all (`git add -A`), commit, push in one sequence without intermediate inspection.

## AFTER CHANGES — MEMORY UPDATES

After completing meaningful project changes (new features, refactors, config changes, dependency updates), update relevant Serena memories to reflect the new state. Read the existing memory first, then update or add content. Do not update memories for trivial or one-off changes.

Create new memories for project domains not yet covered (e.g., `mem:architecture`, `mem:deployment`, `mem:testing`). Use topic folders to group related memories.

- `mem:core` — update if project purpose, structure, or key invariants changed
- `mem:tech_stack` — update if languages, tooling, or dependencies changed
- `mem:conventions` — update if new conventions were established
- `mem:suggested_commands` — update if custom commands or workflows changed
- `mem:task_completion` — update if verification steps changed


