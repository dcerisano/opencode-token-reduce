# Task Completion

## Validation steps
- No linter, formatter, or type checker configured — this is a config template, not application code
- Verify `opencode.json` is valid JSON: `python3 -c "import json; json.load(open('opencode.json'))"`
- Verify `.serena/project.yml` is valid YAML: `python3 -c "import yaml; yaml.safe_load(open('.serena/project.yml'))"`
- Verify all memory files are consistent: `serena memories check` (if Serena is running)

## Before commit
- Ensure `.githooks/pre-push` is executable
- Memory files auto-staged on push; no manual staging needed for `.serena/memories/*.md`

## Note
- This project produces no build artifacts; there is no test suite, build step, or CI pipeline
- The "correctness" of the template is validated by using it to create a new project and verifying Serena/Context7 launch correctly