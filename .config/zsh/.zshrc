#!/bin/zsh

# ── Options ───────────────────────────────────────────────────────────────────

setopt autocd extendedglob nomatch menucomplete interactive_comments
setopt HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS SHARE_HISTORY HIST_REDUCE_BLANKS
stty stop undef
zle_highlight=('paste:none')
unsetopt BEEP

# ── Homebrew (Linux) ──────────────────────────────────────────────────────────

if [[ "$(uname -s)" == "Linux" ]] && [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ── Completion ────────────────────────────────────────────────────────────────

autoload -Uz compinit
zmodload zsh/complist
_comp_options+=(globdots)

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false

autoload -Uz colors && colors

# ── Source config files ───────────────────────────────────────────────────────

source "$ZDOTDIR/functions.zsh"
zsh_add_file "exports.zsh"
zsh_add_file "vim_mode.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "prompt.zsh"

# ── Plugins ───────────────────────────────────────────────────────────────────

# autopair — simple, no ordering requirements
zsh_add_plugin "hlissner/zsh-autopair"

# compinit must run before fzf-tab
compinit

# fzf-tab replaces the default completion menu with FZF
# must be after compinit, before autosuggestions/syntax-highlighting
zsh_add_plugin "Aloxaf/fzf-tab"

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-history-substring-search"

# syntax-highlighting must be sourced last
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# ── Key bindings ──────────────────────────────────────────────────────────────

# History search with Up/Down arrows (via history-substring-search)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down

bindkey '^[[P' delete-char
bindkey -r '^u'
bindkey -r '^d'

# Edit current command line in $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# ── FZF ───────────────────────────────────────────────────────────────────────

# fzf --zsh emits completion + key-binding setup (requires fzf >= 0.48)
if command -v fzf &>/dev/null; then
    eval "$(fzf --zsh)"
fi

# ── Fastfetch ─────────────────────────────────────────────────────────────────

if [[ -o interactive ]] && command -v fastfetch &>/dev/null; then
    fastfetch
fi
