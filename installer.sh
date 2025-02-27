#!/usr/bin/env bash

###############################################################################
# This script downloads Lina for macOS
# Dependencies: git, homebrew
###############################################################################

# Bootstrap Lina
source <(curl -fsSL "https://raw.githubusercontent.com/marosige/lina-macos/refs/heads/main/bootstrap.sh") || { echo "[X] Bootstrap error: Failed to run Lina installer."; exit 1; }


echo -e "$LINA_TITLE Welcome to Lina installer!"
echo -e "$LINA_INDENT This script will download and install Lina, along with its dependencies. (homebrew, git)"
ack

# Check if Lina folder already exists
if [ -d "$LINA_ROOT" ]; then
  echo -e "$LINA_FAIL Lina is already downloaded at $LINA_ROOT"
  ack "run Lina"
  cd "$LINA_ROOT" || exit 1
  exec bash lina.sh
  exit 0
fi

# Install dependencies
if ! is_command_exists brew ; then (/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || echo -e "$LINA_FAIL Failed to install Homebrew" && exit 1); fi
if ! is_command_exists git ; then (brew install git || echo -e "$LINA_FAIL Failed to install Git" && exit 1); fi

# Download Lina
echo -e "$LINA_TASK Downloading Lina into $LINA_ROOT"
git clone https://github.com/marosige/lina-macos "$LINA_ROOT"
git -C "$LINA_ROOT" checkout main
echo -e "$LINA_DONE Lina downloaded successfully"


# Add Lina to PATH
echo -e "$LINA_TASK Installing Lina"
# Ensure ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    echo 'set -x PATH $HOME/.local/bin $PATH' >> "$HOME/.config/fish/config.fish"
    echo "$LINA_DONE Added $HOME/.local/bin to PATH. Please restart your shell after installation."
fi
ln -sf "$LINA_ROOT/lina.sh" "$HOME/.local/bin/lina" && echo -e "$LINA_DONE Lina installed successfully" || echo -e "$LINA_FAIL Link error: Failed to install Lina"

ack "run Lina"

cd "$LINA_ROOT" || exit
exec bash lina.sh
