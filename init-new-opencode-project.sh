#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "===================================="
echo " OpenCode Token-Reduce Project Init"
echo "===================================="
echo ""

# ---- Step 1: target directory ----
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
echo ""

# ---- Step 2: copy files ----
echo "Copying template files ..."

# Use rsync if available; fall back to cp + tar pipe
if command -v rsync &>/dev/null; then
  rsync -a --exclude='.git/' \
           --exclude='.serena/cache/' \
           "$SCRIPT_DIR"/ "$TARGET_DIR"/
else
  # Fallback: tar pipe, which handles hidden files correctly
  cd "$SCRIPT_DIR"
  tar cf - --exclude='.git' \
           --exclude='.serena/cache' \
           . | (cd "$TARGET_DIR" && tar xf -)
  cd "$SCRIPT_DIR"
fi

echo "Files copied."
echo ""

# ---- Step 3: git init ----
cd "$TARGET_DIR"
if [[ -d .git ]]; then
  echo "Git repository already initialized."
else
  git init
  git add -A
  git commit -m "Initial commit: opencode-token-reduce template"
  echo "Git repository initialized and first commit made."
fi
echo ""

# ---- Step 4: GitHub remote ----
echo "Create a remote repository on GitHub?"
select REPLY in "Yes" "No"; do
  case "$REPLY" in
    Yes)
      if ! command -v gh &>/dev/null; then
        echo "GitHub CLI (gh) not found. Install it from https://cli.github.com/ then re-run."
        echo "Skipping remote creation."
        break
      fi

      if ! gh auth status &>/dev/null; then
        echo "You are not authenticated with GitHub CLI."
        echo "Run 'gh auth login' first, then re-run this script."
        echo "Skipping remote creation."
        break
      fi

      read -r -p "Repository name (e.g. owner/repo or just repo): " REPO_NAME
      if [[ -z "$REPO_NAME" ]]; then
        echo "No name provided. Skipping remote creation."
        break
      fi

      echo "Visibility:"
      select VIS in "public" "private"; do
        case "$VIS" in
          public|private) break ;;
        esac
      done

      gh repo create "$REPO_NAME" --"$VIS" --push --source=.
      echo "Remote created and code pushed."
      break
      ;;
    No)
      echo "Skipping remote creation. You can set it up later with:"
      echo "  git remote add origin <url>"
      echo "  git push -u origin main"
      break
      ;;
  esac
done

echo ""
echo "Done. Your new project is ready at: $TARGET_DIR"
echo "Run 'opencode' in that directory to start."
