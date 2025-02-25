#!/usr/bin/env bash

###############################################################################
# This script is the bootstrap script for Lina
###############################################################################

export LINA_ROOT="$HOME/.lina"

# Set log messages
BOLD='\033[1m'
BRIGHT_BLUE='\033[0;94m'
BRIGHT_GREEN='\033[0;92m'
YELLOW='\033[0;33m'
BRIGHT_RED='\033[0;91m'
NC='\033[0m' # No Color (resets to default)

export LINA_TITLE="${BOLD}[#]${NC}"
export LINA_TASK="${BRIGHT_BLUE}[>]${NC}"
export LINA_DONE="${BRIGHT_GREEN}[✔]${NC}"
export LINA_WARN="${YELLOW}[!]${NC}"
export LINA_FAIL="${BRIGHT_RED}[✖]${NC}"
export LINA_INDENT="   "

# small functions for ignition, not big enough to be in a separate lib file
ack() {
    local action="${1:-continue}"
    echo -e "$LINA_WARN Press [ENTER] to $action, or Ctrl-c to cancel."
    read -r
}
export -f ack

is_command_exists() {
    command -v "$1" >/dev/null 2>&1
}
export -f is_command_exists

mkdir_withlog() {
  if [ -d "$1" ]; then
    echo -e "$LINA_DONE Directory already exists: $1"
  else
    mkdir -p "$1"
    echo -e "$LINA_DONE Created directory: $1"
  fi
}
export -f mkdir_withlog