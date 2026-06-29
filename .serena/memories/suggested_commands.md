# Suggested Commands

## OpenCode
```bash
opencode --prompt "startup"    # Launch with startup prompt
oc                              # Alias (user-configured)
opencode --prompt "/migrate /path/to/project"  # Migrate template into existing project
```

## Git (standard)
```bash
git status
git diff
git add ...
git commit ...
git push
```

## Git hooks
```bash
git config core.hooksPath .githooks  # Enable template's pre-push hook
```

## Serena
- Web dashboard: http://127.0.0.1:24282/dashboard/index.html
- CLI: `serena memories check` — check for stale memory references

## npm (within .opencode/)
```bash
npm install  # Install @opencode-ai/plugin (only if needed for plugin development)
```

## Prerequisites (one-time)
```bash
gh repo create <name> --template dcerisano/opencode-token-reduce --public --clone
export CONTEXT7_API_KEY="your_key_here"
```