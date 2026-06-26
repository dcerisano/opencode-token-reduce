#!/usr/bin/env bash
# install.sh
#
# Installer for opencode-token-reduce.
#
# Usage:
#   ./install.sh
#
# This script:
#   1. Checks for and installs missing dependencies (uvx)
#   2. Checks CONTEXT7_API_KEY is set
#   3. Optionally creates a new OpenCode project from this template
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "===================================="
echo " opencode-token-reduce installer"
echo "===================================="
echo ""

# ---- Dependencies ----
echo "--- Checking dependencies ---"

DEP_MISSING=0

if command -v uvx &>/dev/null; then
  echo "  uvx:         found ($(uvx --version 2>/dev/null || echo "present"))"
else
  echo "  uvx:         NOT FOUND — installing..."
  if command -v curl &>/dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
    if command -v uvx &>/dev/null; then
      echo "  uvx:         installed successfully"
    else
      echo "  ERROR: uvx installation failed. Try: pip install uv" >&2
      DEP_MISSING=1
    fi
  else
    echo "  ERROR: curl not found. Install curl or manually install uv from https://docs.astral.sh/uv/" >&2
    DEP_MISSING=1
  fi
fi

if command -v git &>/dev/null; then
  echo "  git:         found ($(git --version 2>/dev/null))"
else
  echo "  ERROR: git not found. Install git and re-run." >&2
  DEP_MISSING=1
fi

if [ -n "${CONTEXT7_API_KEY:-}" ]; then
  echo "  CONTEXT7_API_KEY: set"
else
  echo "  CONTEXT7_API_KEY: NOT SET"
  echo "  → Get a free key at https://context7.com and set it:"
  echo "    export CONTEXT7_API_KEY=your_key_here"
  echo ""
  echo "  Without it, Context7 documentation lookups will not work."
  echo "  Token savings will suffer — the model falls back to training data."
  echo "  You can set it later — the rest of the template still functions."
fi

echo ""

if [ "$DEP_MISSING" -ne 0 ]; then
  echo "Some dependencies could not be installed automatically." >&2
  echo "Fix the issues above and re-run." >&2
  exit 1
fi

# ---- Option: create a new project ----
echo "--- Create a new OpenCode project? ---"
echo "Set up a new directory with this template, a git repo,"
echo "and optionally a GitHub remote."
echo ""
select REPLY in "Yes" "No"; do
  case "$REPLY" in
    Yes)
      echo ""
      read -r -p "Enter the full path for the new project directory: " RAW_PATH

      if [[ -z "$RAW_PATH" ]]; then
        echo "Error: No path provided." >&2
        exit 1
      fi

      # Resolve relative paths relative to $HOME
      if [[ "$RAW_PATH" != /* ]]; then
        TARGET_DIR="$HOME/$RAW_PATH"
      else
        TARGET_DIR="$RAW_PATH"
      fi

      if [[ -d "$TARGET_DIR" ]] && [[ "$(ls -A "$TARGET_DIR" 2>/dev/null)" ]]; then
        echo "Error: Target directory exists and is not empty: $TARGET_DIR" >&2
        exit 1
      fi

      mkdir -p "$TARGET_DIR"
      echo "Installing into: $TARGET_DIR"

      # Copy files
      if command -v rsync &>/dev/null; then
        rsync -a --exclude='.git/' \
                 --exclude='.serena/cache/' \
                 "$SCRIPT_DIR"/ "$TARGET_DIR"/
      else
        cd "$SCRIPT_DIR"
        tar cf - --exclude='.git' \
                 --exclude='.serena/cache' \
                 . | (cd "$TARGET_DIR" && tar xf -)
        cd "$SCRIPT_DIR"
      fi
      echo "Template files copied."

      # Git init
      cd "$TARGET_DIR"
      if [ ! -d .git ]; then
        git init
        if ! git config user.email &>/dev/null; then
          git config user.email "user@opencode-token-reduce"
          git config user.name "opencode-token-reduce"
        fi
        git add -A
        git commit -m "Initial commit: opencode-token-reduce template"
        echo "Git repository initialized."
      fi

      # GitHub remote
      echo ""
      echo "Create a remote repository on GitHub?"
      select REPLY2 in "Yes" "No"; do
        case "$REPLY2" in
          Yes)
            if ! command -v gh &>/dev/null; then
              echo "GitHub CLI (gh) not found. Skipping."
              break
            fi
            if ! gh auth status &>/dev/null; then
              echo "Not authenticated with gh. Skipping."
              break
            fi
            read -r -p "Repository name (e.g. owner/repo): " REPO_NAME
            if [ -n "$REPO_NAME" ]; then
              echo "Visibility?"
              select VIS in "public" "private"; do
                case "$VIS" in
                  public|private) break ;;
                esac
              done
              gh repo create "$REPO_NAME" --"$VIS" --push --source=.
              echo "Remote created and pushed."
            fi
            break
            ;;
          No)
            echo "Skipping. You can set it up later with:"
            echo "  git remote add origin <url>"
            echo "  git push -u origin main"
            break
            ;;
        esac
      done

      echo ""
      echo "Done. Your new project is ready at: $TARGET_DIR"
      echo "Run 'opencode' in that directory to start."
      break
      ;;
    No)
      echo "Skipping project creation."
      echo "To create one later, re-run this script or copy the template manually."
      break
      ;;
  esac
done
