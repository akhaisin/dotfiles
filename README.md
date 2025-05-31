# dotfiles

## TODO

- [x] consider using stow for installing/linking dotfiles
    - [x] workflow:
        - [x] run `~/.dotfiles/install.sh`
            - [x] checkout dotfiles repo into `~/.dotfiles`
            - [x] check for deps (git, brew, stow, nvim and etc)
            - [x] run `stow .`
- [ ] Add cool promt and status bar
    - [ ] tmux ?? check https://github.com/jakobwesthoff/dotfiles/blob/main/.tmux.conf
- [ ] NeoVim
    - [ ] 1
    - [ ] 2
    - [ ] 3

## Installation

### WSL

- Install Nerd Fonts (any) from https://www.nerdfonts.com/font-downloads
- Setup usage of this font in terminal emulator
- Launch WSL Debian

### MacOs


### Common

- copy/download run install.sh 
  - installs Homebrew
  - intallss git
  - clones dotfiles repo from GitHub
  - installs Homebrew packages (zsh, nvim, and etc)
  - stow dotfiles to home directory


## Details

### Shell

ZSH from scratch with basic completions and git repo prompt


### Nvim

There are 3 configs for NeoVim 

- .config/nvim.min - config from scratch
- .config/nvim.lazy
- .config/nvim.chad

`install.sh` links to nvim.lazy for now while work on nvim.min is in progress


### tmux

Work is in progress.
Current issues with keys mapping (e.g. backspace does not work)