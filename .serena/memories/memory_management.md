# Memory management skill

Located at `.opencode/skills/memory-management/SKILL.md`.

## When to update
After meaningful project changes (features, refactors, config, deps). Not for trivial/one-off changes.

## Which memory to update
- `mem:core` — project purpose, structure, invariants
- `mem:tech_stack` — languages, tooling, deps
- `mem:conventions` — new conventions
- `mem:suggested_commands` — new workflows/commands
- `mem:task_completion` — verification steps (if exists)

## Style
Dense agent notes, not prose. Invariants and terse bullets. Avoid obvious context, rationale, examples, volatile details. Keep generalizable.

## Discovery model
- `mem:core` is the graph root. References to major domains via `` `mem:name` ``.
- Use topic folders like `frontend/core`, `backend/debugging`.
