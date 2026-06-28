# Suggested Commands

This is a **configuration-only template** — no application code, no language-specific build system. No `npm run` scripts or Makefile targets are defined.

## Useful External Commands

| Action | Command |
|--------|---------|
| OpenCode startup | `opencode --prompt "startup"` |
| Serena dashboard | Open `http://127.0.0.1:24282/dashboard/index.html` (auto-launch disabled) |
| Install Serena deps | `uvx -p 3.13 --from git+https://github.com/oraios/serena serena --help` (auto-installs) |
| Install @opencode-ai/plugin | `npm install` (inside `.opencode/`) |

## No Predefined Commands For

- **dev**: N/A (no application)
- **build**: N/A (no application)
- **test**: N/A (no application)
- **lint**: N/A (no application)
- **typecheck**: N/A (no application)

If application code is added to a project created from this template, add `build`, `test`, `lint`, `typecheck` commands to `package.json` scripts and update this memory.
