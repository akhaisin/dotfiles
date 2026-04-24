# dotfiles

Personal dotfiles for **macOS (Darwin)** and **Linux**, managed with [GNU Stow](https://www.gnu.org/software/stow/).  
Package manager: [Homebrew](https://brew.sh) (works on both platforms).

## Installation

On a fresh machine, run one command:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/akhaisin/dotfiles/main/install.sh)"
```

What `install.sh` does:
1. Installs Homebrew (if not present)
2. Installs `git` via Homebrew
3. Optionally generates an SSH key and prompts you to add it to GitHub
4. Clones this repo to `~/.dotfiles`
5. Runs `brew bundle install` (installs all packages from `Brewfile`)
6. Runs `stow .` to symlink all dotfiles into `$HOME`

### macOS: Nerd Font setup

Install a Nerd Font (already in `Brewfile`) and set it in your terminal emulator (iTerm2 / Terminal.app / Ghostty).

---

## Shell — ZSH

Config lives in `.config/zsh/` and is loaded via `ZDOTDIR`.

| File | Purpose |
|---|---|
| `.zshrc` | Options, plugins, key bindings |
| `exports.zsh` | `PATH`, `EDITOR`, history vars, FZF env |
| `aliases.zsh` | `ls`→`eza`, `vim`→`nvim`, etc. |
| `prompt.zsh` | Git-aware prompt via `vcs_info` |
| `vim_mode.zsh` | Vi key bindings + cursor shape |
| `functions.zsh` | `zsh_add_plugin` / `zsh_add_file` helpers |

### Plugins (auto-cloned on first launch)

| Plugin | Purpose |
|---|---|
| `zsh-autosuggestions` | Ghost-text suggestions from history |
| `zsh-syntax-highlighting` | Fish-like command highlighting |
| `zsh-history-substring-search` | Up/Down arrows search by prefix |
| `zsh-autopair` | Auto-close brackets/quotes |
| `fzf-tab` | FZF-powered tab completion menu |

### Key bindings

| Key | Action |
|---|---|
| `Ctrl+R` | FZF history search |
| `Ctrl+T` | FZF file search |
| `Alt+C` | FZF cd into directory |
| `↑` / `↓` | History search by prefix |
| `Ctrl+P` / `Ctrl+N` | Same as ↑/↓ |
| `Ctrl+E` | Edit command line in `$EDITOR` |
| `Ctrl+/` | Toggle FZF preview pane |

---

## Editor — NeoVim (LazyVim)

Single config at `.config/nvim/`, built on [LazyVim](https://lazyvim.github.io/).

### VSCode-like keymaps

| Key | Action |
|---|---|
| `Ctrl+S` | Save file |
| `Ctrl+P` | Find files (Telescope) |
| `Ctrl+F` | Live grep across project |
| `Ctrl+B` | Toggle file explorer (neo-tree) |
| `Ctrl+/` | Toggle comment (`Ctrl+_` in terminal) |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `[d` / `]d` | Prev/next diagnostic |
| `<leader>gg` | Open lazygit |

LazyVim defaults are documented at https://lazyvim.github.io/keymaps.

### Extras enabled (`lazyvim.json`)

- `lang.typescript` — TypeScript/JS LSP + tools
- `lang.python` — Python LSP + tools
- `editor.aerial` — Symbol outline panel

---

## Packages (`Brewfile`)

Key tools installed:

| Tool | Purpose |
|---|---|
| `neovim` | Editor |
| `lazygit` | Git TUI (integrated in NeoVim) |
| `fzf` | Fuzzy finder |
| `fd` | Fast file finder (used by Telescope + FZF) |
| `bat` | `cat` with syntax highlighting (FZF previews) |
| `ripgrep` | Fast grep (used by Telescope live\_grep) |
| `eza` | Modern `ls` with icons + git status |
| `zoxide` | Smarter `cd` with frecency |
| `fastfetch` | System info on shell startup |
| `tmux` | Terminal multiplexer |
