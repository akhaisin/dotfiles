#!/bin/zsh

# echo ">> $ZDOTDIR/aliases.zsh"

# # Platform specific
# case "$(uname -s)" in
#     Linux)
#         alias ls='ls --color=auto'
#         ;;
#     Darwin)
#         alias ls="ls -G"
#         ;;
# esac
# alias ls="ls --color=auto"
# alias ll="ls -l"
# alias la="ls -a"
# alias lla="ls -la"
# alias l="lla"

alias ls="eza --icons --git"
alias l='eza -alg --color=always --group-directories-first --git'
alias ll='eza -aliSgh --color=always --group-directories-first --icons --header --long --git'
alias lt='eza -@alT --color=always --git'
alias llt="eza --oneline --tree --icons --git-ignore"
alias lr='eza -alg --sort=modified --color=always --group-directories-first --git'

alias tree="tree -L 2 -C -a --dirsfirst"

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias ln="ln -i"
alias mkdir="mkdir -pv"


alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# applications
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias nvimrc='nvim ~/.config/nvim/'
alias py="python3"


