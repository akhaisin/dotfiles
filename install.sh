#!/usr/bin/env bash

set -euo pipefail

OS="$(uname -s)"

# ── Mode detection ────────────────────────────────────────────────────────────
# Running from inside the repo → refresh (re-stow + brew bundle).
# Running from elsewhere       → fresh install (clone first, then same steps).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$SCRIPT_DIR/Brewfile" ] && [ -d "$SCRIPT_DIR/.config" ]; then
    DOTFILES_DIR="$SCRIPT_DIR"
    FRESH=false
    echo "Refresh mode: using repo at $DOTFILES_DIR"
else
    DOTFILES_DIR="$HOME/.dotfiles"
    FRESH=true
    echo "Fresh install: repo will be cloned to $DOTFILES_DIR"
fi

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

# ── Fresh install only ────────────────────────────────────────────────────────

if [ "$FRESH" = true ]; then
    brew install git

    if [ -f "$HOME/.ssh/id_ed25519" ]; then
        echo "SSH key already exists at ~/.ssh/id_ed25519, skipping keygen."
    else
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
    fi

    if [ ! -d "$DOTFILES_DIR" ]; then
        git clone git@github.com:akhaisin/dotfiles.git "$DOTFILES_DIR"
    fi
fi

# ── Zsh ───────────────────────────────────────────────────────────────────────

ZSH_PATH=/usr/bin/zsh

if [ "$OS" = "Linux" ] && ! command -v "$ZSH_PATH" &>/dev/null; then
    sudo apt-get install -y zsh
fi

if ! grep -qF "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi

if [ "$SHELL" != "$ZSH_PATH" ]; then
    chsh -s "$ZSH_PATH"
    echo "Default shell changed to $ZSH_PATH (takes effect on next login)."
fi

# ── Packages + dotfiles ───────────────────────────────────────────────────────

cd "$DOTFILES_DIR"

brew bundle install

# Back up any real files that stow would conflict with, then stow.
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"

conflicts=$(stow --simulate --dir="$DOTFILES_DIR" --target="$HOME" . 2>&1 \
    | grep -i "existing target" \
    | sed -n 's/.*over existing target \([^ ]*\) .*/\1/p; s/.*existing target[^:]*: //p') || true

if [ -n "$conflicts" ]; then
    echo "Backing up conflicting files to $BACKUP_DIR ..."
    mkdir -p "$BACKUP_DIR"
    while IFS= read -r rel; do
        src="$HOME/$rel"
        dst="$BACKUP_DIR/$rel"
        mkdir -p "$(dirname "$dst")"
        mv "$src" "$dst"
        echo "  $src → $dst"
    done <<< "$conflicts"
    echo ""
fi

stow --dir="$DOTFILES_DIR" --target="$HOME" .

echo ""
if [ "$FRESH" = true ]; then
    echo "Dotfiles installed. Open a new terminal to apply ZSH config."
else
    echo "Dotfiles refreshed."
fi
