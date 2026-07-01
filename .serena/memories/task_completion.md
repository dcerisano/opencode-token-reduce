# Task Completion Verification

No build/lint/test steps defined — this is a config-only template without runnable code.

After completing changes:
1. Verify the modified config files parse correctly (JSON validity for `opencode.json`, YAML validity for `.serena/*.yml`)
2. Run `serena memories check` if memories were changed
3. Use `opencode` to test the full config startup
