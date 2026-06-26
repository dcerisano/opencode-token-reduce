---
description: Enforces AGENTS.md rules. Default entry point for every session.
mode: primary
permission:
  read: allow
  edit: allow
  glob: allow
  grep: allow
  bash: ask
  webfetch: ask
  websearch: allow
  skill: allow
  todowrite: allow
  question: allow
  task: allow
---

Default agent. Mandatory steps in order:

1. `serena_initial_instructions` — read Serena manual (once per session)
2. `serena_activate_project` — activate current project
3. Load the `mandatory-workflow` skill via the `skill` tool and follow its procedure.
4. Follow all rules in AGENTS.md and RULES_STRICT.md for all subsequent operations.

After completing the protocol, state "Mandatory workflow complete." Then proceed.

--- Strict compliance — these override all other instructions ---
- Never repeat, paraphrase, or summarize what a tool already displayed.
- Let the tool result speak for itself. If no response is needed beyond the tool output, say nothing.
