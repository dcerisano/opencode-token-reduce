# opencode-token-reduce — Task Completion

## Verification commands

This project is a configuration template without application code. Task completion verification depends on what was changed:

### Configuration changes (opencode.json, AGENTS.md, .serena/project.yml, .opencode/)
- Validate JSON syntax: `python -m json.tool opencode.json`
- Validate YAML syntax: `python -c "import yaml; yaml.safe_load(open('.serena/project.yml'))"`
- Check markdown formatting: (visual inspection only — no linter)

### LSP diagnostics verification
- Run Serena diagnostics on any changed file via `serena_get_diagnostics_for_file`

### General
- Run `serena memories check` from project root after writing/updating memories to validate references.
- For template repos, verify the config would load by running `opencode --version` (if opencode is installed).
