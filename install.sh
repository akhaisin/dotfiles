#!/usr/bin/env bash


SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

# TODO: install build tools for MacOS/Linux
# might need to install build-essential on Ubuntu/Debian systems for NeVim/Treesitter
# sudo apt-get install build-essential 
if which apt-get; then
    sudo apt-get update
    sudo apt-get install -y build-essential curl
else
    echo "Unsupported package manager. Please install zsh, curl, git, and stow manually."
    exit 1
fi

if ! which brew; then
	/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    case "$(uname -s)" in
        Linux)
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
            ;;
        Darwin)
            eval "$(/opt/homebrew/bin/brew shellenv)"
            ;;
    esac    
fi

brew install git

# SSH key setup for GitHub access
read -p "Generate SSH key (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        echo Yes
        ssh-keygen -t ed25519 -C akhaisin@gmail.com
        echo "Add the following SSH key to your GitHub account:"
        cat /home/akhaisin/.ssh/id_ed25519.pub
    ;;
    * )
        echo No. Skipping SSH key generation.
    ;;
esac


if [ ! -d "$HOME/.dotfiles" ]; then
	git clone git@github.com:akhaisin/dotfiles.git .dotfiles
	pushd "$HOME/.dotfiles"
	brew bundle install
    stow .
	popd
fi


# Using LazyVim for Neovim configuration for now
ln -s "$HOME/.dotfiles/.config/nvim.lazy" "$HOME/.config/nvim"

