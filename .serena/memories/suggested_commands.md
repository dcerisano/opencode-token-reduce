# opencode-token-reduce — Suggested Commands

## Custom opencode commands (run inside opencode via `opencode --prompt "<command>"`)
- `test` — Run project tests and report pass/fail counts per tier. If any test fails, analyze and fix.
- `fix` — Run build/tests, identify failures, fix them, re-run until green. Stop after 3 attempts on same error.
- `status` — Show git branch, uncommitted changes, and recent commits.

## Quick startup
```
opencode --prompt "startup"
alias oc='opencode --prompt "startup"'
```

## Standard tool usage
- `git`, `ls -a` (prefer `ls -a` over `ls`), `gh` (for GitHub tasks)

## Serena
- Dashboard: http://127.0.0.1:24282/dashboard/index.html (auto-launch disabled)
- Memory check: `serena memories check` (run from project root to validate references)
