#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
OS="$(uname -s)"

# ── Homebrew ──────────────────────────────────────────────────────────────────

if ! command -v brew &>/dev/null; then
    /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

case "$OS" in
    Linux)
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        ;;
    Darwin)
        if [ -x /opt/homebrew/bin/brew ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        ;;
    *)
        echo "Unsupported OS: $OS" >&2
        exit 1
        ;;
esac

# ── Git ───────────────────────────────────────────────────────────────────────

brew install git

# ── SSH key ───────────────────────────────────────────────────────────────────

read -rp "Generate SSH key for GitHub (y/n)? " answer
case ${answer:0:1} in
    y|Y)
        ssh-keygen -t ed25519 -C "$USER@$(hostname)"
        echo ""
        echo "Add this public key to https://github.com/settings/keys :"
        cat "$HOME/.ssh/id_ed25519.pub"
        echo ""
        read -rp "Press Enter once the key is added to GitHub..."
        ;;
    *)
        echo "Skipping SSH key generation."
        ;;
esac

# ── Clone dotfiles ────────────────────────────────────────────────────────────

if [ ! -d "$DOTFILES_DIR" ]; then
    git clone git@github.com:akhaisin/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

# ── Packages + dotfiles ───────────────────────────────────────────────────────

brew bundle install
stow .

echo ""
echo "Dotfiles installed. Open a new terminal to apply ZSH config."
