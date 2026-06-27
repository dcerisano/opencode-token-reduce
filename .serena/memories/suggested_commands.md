# Commands

## OpenCode (via `opencode.json` command templates)

| Command   | Template                                                                 |
|-----------|--------------------------------------------------------------------------|
| `test`    | Run project tests and report pass/fail counts per tier. Fix failures.    |
| `fix`     | Run build/tests, identify failures, fix, re-run until green.             |
| `status`  | Show git branch, uncommitted changes, recent commits.                    |

## System

- `opencode` — launch OpenCode
- `opencode --prompt "startup"` — quick startup alias (recommended)
- `gh repo create <name> --template dcerisano/opencode-token-reduce` — create new project from template
- `serena memories check` — verify memory references (run from project root after onboarding)
