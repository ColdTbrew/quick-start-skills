#!/usr/bin/env bash
# Install quick-start-skills into Codex skill folders.
#   bash install.sh              -> $HOME/.agents/skills   (user scope, not part of the workspace)
#   bash install.sh --project    -> ./.agents/skills       (repo scope, current directory)
#   add --with-pstack            -> also copy a small subset of pstack principle skills (MIT, backnotprop/pstack)
#   add --with-taste             -> install official Leonxlnx/taste-skill via npx skills for Codex
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
dest="$HOME/.agents/skills"
with_pstack=0
with_taste=0
for a in "$@"; do
  case "$a" in
    --project) dest="$PWD/.agents/skills" ;;
    --with-pstack) with_pstack=1 ;;
    --with-taste) with_taste=1 ;;
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
  git clone -q --depth 1 https://github.com/backnotprop/pstack "$tmp/pstack"
  for s in principle-prove-it-works principle-explain-the-number principle-fix-root-causes \
           principle-laziness-protocol principle-subtract-before-you-add in-your-own-words; do
    rm -rf "${dest:?}/$s"
    cp -R "$tmp/pstack/skills/$s" "$dest/$s"
    echo "installed pstack/$s"
  done
  rm -rf "$tmp"
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
echo "done -> $dest  (restart codex if skills do not show in /skills)"
