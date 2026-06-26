---
name: installer-setup
description: Runs the installer for the opencode-token-reduce template. Loaded by the mandatory-workflow skill in the template repo. Not present in projects created by install.sh.
---

# Installer Setup

## Procedure

1. Ask the user if they want to run `install.sh`. This installs any missing system dependencies (git, curl, uvx), checks `CONTEXT7_API_KEY`, and optionally creates a new OpenCode project from this template.
   - If the user agrees, run `install.sh` with bash. It is interactive — the user will respond to prompts directly.
   - If the user declines, check dependencies manually: ensure `uvx` is on PATH (auto-install if missing) and `CONTEXT7_API_KEY` is set (ask the user to provide one if not, do not proceed until confirmed).
