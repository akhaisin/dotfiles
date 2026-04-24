#!/bin/zsh

# ── History ───────────────────────────────────────────────────────────────────

HISTFILE="$XDG_DATA_HOME/zsh/.zhistory"
HISTSIZE=1000000
SAVEHIST=1000000

# ── PATH ──────────────────────────────────────────────────────────────────────

export PATH="$HOME/.local/bin:$PATH"

# ── Editor ────────────────────────────────────────────────────────────────────

export EDITOR="$(command -v nvim)"
export VISUAL="$EDITOR"
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# ── FZF ───────────────────────────────────────────────────────────────────────

# Use fd for finding files (respects .gitignore, fast)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# bat for syntax-highlighted previews; toggle with Ctrl+/
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --bind='ctrl-/:toggle-preview'
  --preview='bat --color=always --style=numbers --line-range=:50 {}'
  --preview-window=right:50%:hidden
"

# ── Zoxide ────────────────────────────────────────────────────────────────────

eval "$(zoxide init zsh)"
