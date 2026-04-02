#!/usr/bin/env bash
#
# Remote installer for ai-commit-hook
# Run via:
#   curl -o- https://raw.githubusercontent.com/samosad/ai-commit-hook/main/remote-install.sh | bash
#   wget -qO- https://raw.githubusercontent.com/samosad/ai-commit-hook/main/remote-install.sh | bash
#
set -euo pipefail

REPO="https://github.com/samosad/ai-commit-hook.git"
HOOK_DIR="${HOME}/.git-hooks"
INSTALL_DIR="${HOME}/.ai-commit-hook"

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
echo -e "${BOLD}Installing ai-commit-hook...${RESET}"
echo ""

# Check for git
if ! command -v git &> /dev/null; then
  echo "Error: git is not installed." >&2
  exit 1
fi

# Check git version for global hooks support
git_version=$(git --version | sed 's/git version //')
git_major=$(echo "$git_version" | cut -d. -f1)
git_minor=$(echo "$git_version" | cut -d. -f2)
if [ "$git_major" -lt 2 ] || { [ "$git_major" -eq 2 ] && [ "$git_minor" -lt 9 ]; }; then
  echo -e "${YELLOW}Warning: git ${git_version} detected. Global hooks require git >= 2.9${RESET}"
  echo "Please upgrade git and try again."
  exit 1
fi

# Clone or update the repo
if [ -d "$INSTALL_DIR" ]; then
  echo "=> Updating existing installation in ${INSTALL_DIR}..."
  cd "$INSTALL_DIR"
  git pull --ff-only origin main 2>/dev/null || {
    echo "Update failed, re-cloning..."
    cd "$HOME"
    rm -rf "$INSTALL_DIR"
    git clone --depth 1 "$REPO" "$INSTALL_DIR"
  }
else
  echo "=> Downloading ai-commit-hook..."
  git clone --depth 1 "$REPO" "$INSTALL_DIR"
fi

# Install the hook globally
mkdir -p "$HOOK_DIR"
cp "$INSTALL_DIR/commit-msg" "$HOOK_DIR/commit-msg"
chmod +x "$HOOK_DIR/commit-msg"

# Check if core.hooksPath is already set to something else
existing_hooks_path=$(git config --global core.hooksPath 2>/dev/null || echo "")
if [ -n "$existing_hooks_path" ] && [ "$existing_hooks_path" != "$HOOK_DIR" ]; then
  echo -e "${YELLOW}Note: core.hooksPath was set to '${existing_hooks_path}'${RESET}"
  echo -e "${YELLOW}Overwriting with '${HOOK_DIR}'${RESET}"
fi

git config --global core.hooksPath "$HOOK_DIR"

echo ""
echo -e "${GREEN}✓ ai-commit-hook installed successfully!${RESET}"
echo ""
echo -e "  Hook installed to:  ${BOLD}${HOOK_DIR}/commit-msg${RESET}"
echo -e "  Source cloned to:   ${BOLD}${INSTALL_DIR}${RESET}"
echo ""
echo -e "  Every commit you make will now include:"
echo -e "  ${CYAN}Co-authored-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>${RESET}"
echo ""
echo -e "  ${YELLOW}Your AI adoption KPIs are now on autopilot. You're welcome.${RESET}"
echo ""
echo -e "  To uninstall:  ${BOLD}~/.ai-commit-hook/install.sh --uninstall-global${RESET}"
