#!/usr/bin/env bash
#
# Installer for ai-commit-hook
# Installs the commit-msg hook globally or into the current repo.
#
set -euo pipefail

HOOK_SOURCE="$(cd "$(dirname "$0")" && pwd)/commit-msg"
BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

echo -e "${CYAN}"
echo '    _    ___    ____                          _ _   '
echo '   / \  |_ _|  / ___|___  _ __ ___  _ __ ___ (_) |_ '
echo '  / _ \  | |  | |   / _ \| '\''_ ` _ \| '\''_ ` _ \| | __|'
echo ' / ___ \ | |  | |__| (_) | | | | | | | | | | | | |_ '
echo '/_/   \_\___|  \____\___/|_| |_| |_|_| |_| |_|_|\__|'
echo -e "${RESET}"
echo -e "${BOLD}Because your manager needs to see AI in every commit.${RESET}"
echo ""

usage() {
  echo "Usage: $0 [--global | --local | --uninstall-global | --uninstall-local]"
  echo ""
  echo "  --global             Install hook for all future repos (git >= 2.9)"
  echo "  --local              Install hook in the current repository"
  echo "  --uninstall-global   Remove the global hook"
  echo "  --uninstall-local    Remove the hook from the current repository"
  echo ""
  exit 1
}

install_global() {
  local hook_dir="${HOME}/.git-hooks"
  mkdir -p "$hook_dir"
  cp "$HOOK_SOURCE" "$hook_dir/commit-msg"
  chmod +x "$hook_dir/commit-msg"
  git config --global core.hooksPath "$hook_dir"
  echo -e "${GREEN}✓ Global hook installed!${RESET}"
  echo -e "  Hook location: ${BOLD}${hook_dir}/commit-msg${RESET}"
  echo -e "  All your repos will now show Claude as a co-author."
  echo -e "  ${YELLOW}Your KPIs will be through the roof.${RESET}"
}

install_local() {
  if [ ! -d ".git" ]; then
    echo "Error: Not inside a git repository. Run this from your repo root." >&2
    exit 1
  fi
  local hook_dir=".git/hooks"
  cp "$HOOK_SOURCE" "$hook_dir/commit-msg"
  chmod +x "$hook_dir/commit-msg"
  echo -e "${GREEN}✓ Local hook installed!${RESET}"
  echo -e "  Hook location: ${BOLD}${hook_dir}/commit-msg${RESET}"
  echo -e "  This repo's commits will now feature Claude as a co-author."
}

uninstall_global() {
  local hook_dir="${HOME}/.git-hooks"
  if [ -f "$hook_dir/commit-msg" ]; then
    rm "$hook_dir/commit-msg"
    echo -e "${GREEN}✓ Global hook removed.${RESET}"
    # Only unset hooksPath if the directory is now empty
    if [ -z "$(ls -A "$hook_dir" 2>/dev/null)" ]; then
      git config --global --unset core.hooksPath 2>/dev/null || true
      rmdir "$hook_dir" 2>/dev/null || true
    fi
  else
    echo "No global hook found."
  fi
}

uninstall_local() {
  if [ ! -d ".git" ]; then
    echo "Error: Not inside a git repository." >&2
    exit 1
  fi
  if [ -f ".git/hooks/commit-msg" ]; then
    rm ".git/hooks/commit-msg"
    echo -e "${GREEN}✓ Local hook removed.${RESET}"
  else
    echo "No local hook found."
  fi
}

case "${1:-}" in
  --global)           install_global ;;
  --local)            install_local ;;
  --uninstall-global) uninstall_global ;;
  --uninstall-local)  uninstall_local ;;
  *)                  usage ;;
esac
