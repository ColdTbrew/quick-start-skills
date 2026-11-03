#!/usr/bin/env bash
# Install quick-start-skills into Codex skill folders.
#   bash install.sh              -> $HOME/.agents/skills   (user scope, not part of the workspace)
#   bash install.sh --project    -> ./.agents/skills       (repo scope, current directory)
#   add --with-pstack            -> copy six skills from ColdTbrew/pstack-codex
#   add --with-pstack-plugin     -> register the full pstack-codex plugin globally
#   add --with-taste             -> install official Leonxlnx/taste-skill via npx skills for Codex
#   add --with-tanstack          -> install official TanStack Start and Router skills for Codex
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
dest="$HOME/.agents/skills"
with_pstack=0
with_pstack_plugin=0
with_taste=0
with_tanstack=0
for a in "$@"; do
  case "$a" in
    --project) dest="$PWD/.agents/skills" ;;
    --with-pstack) with_pstack=1 ;;
    --with-pstack-plugin) with_pstack_plugin=1 ;;
    --with-taste) with_taste=1 ;;
    --with-tanstack) with_tanstack=1 ;;
    *) echo "unknown option: $a" >&2; exit 2 ;;
  esac
done
mkdir -p "$dest"
for d in "$here"/skills/*/; do
  name="$(basename "$d")"
  rm -rf "${dest:?}/$name"
  cp -R "$d" "$dest/$name"
  echo "installed $name"
done
if [ "$with_pstack" = 1 ]; then
  tmp="$(mktemp -d)"
  git clone -q --depth 1 https://github.com/ColdTbrew/pstack-codex "$tmp/pstack"
  for s in principle-prove-it-works principle-explain-the-number principle-fix-root-causes \
           principle-laziness-protocol principle-subtract-before-you-add in-your-own-words; do
    rm -rf "${dest:?}/$s"
    cp -R "$tmp/pstack/plugins/pstack-codex/skills/$s" "$dest/$s"
    echo "installed pstack-codex/$s"
  done
  rm -rf "$tmp"
fi
if [ "$with_pstack_plugin" = 1 ]; then
  if ! command -v codex >/dev/null 2>&1; then
    echo "error: --with-pstack-plugin requires the Codex CLI" >&2
    exit 1
  fi
  codex plugin marketplace add ColdTbrew/pstack-codex --ref main
  codex plugin add pstack-codex@pstack-codex
  echo "installed pstack-codex plugin (custom-agent profiles require a separate install)"
fi
if [ "$with_taste" = 1 ]; then
  if ! command -v npx >/dev/null 2>&1; then
    echo "error: --with-taste requires npm/npx and Node.js (skills CLI requires Node.js 22.20+)" >&2
    exit 1
  fi
  # Install taste from its upstream repository, rather than vendoring or copying it here.
  # Match quick-start-skills' global user scope unless --project was requested.
  if [ "$dest" = "$HOME/.agents/skills" ]; then
    npx -y skills add Leonxlnx/taste-skill --skill design-taste-frontend -a codex -g -y
  else
    npx -y skills add Leonxlnx/taste-skill --skill design-taste-frontend -a codex -y
  fi
  echo "installed taste-skill/design-taste-frontend"
fi
if [ "$with_tanstack" = 1 ]; then
  if ! command -v npx >/dev/null 2>&1; then
    echo "error: --with-tanstack requires npm/npx and Node.js (skills CLI requires Node.js 22.20+)" >&2
    exit 1
  fi
  if [ "$dest" = "$HOME/.agents/skills" ]; then
    npx -y skills add TanStack/router --full-depth --skill start-core react-start router-core react-router -a codex -g -y
  else
    npx -y skills add TanStack/router --full-depth --skill start-core react-start router-core react-router -a codex -y
  fi
  echo "installed TanStack Start and Router skills"
fi
echo "done -> $dest  (restart codex if skills do not show in /skills)"
