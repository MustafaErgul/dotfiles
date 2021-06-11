#!/bin/bash

# Installation script to tools for the dotFiles.

OS_TYPE=$(echo -e $(uname)|awk '{print tolower($0)}')

case $OS_TYPE in

    darwin*)
    echo "MacOS"

        # Check Homebrew
        if [[ -d "/usr/local/Cellar" ]]; then
            echo "Homebrew is already installed."
        else
            curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
        fi

        # Zsh check-installation step
        if [[ -d "$HOME/.oh-my-zsh" ]]; then
            echo "zsh is already installed."
        else
            echo "zsh is installing..."
            curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
        fi

        # Vim and Nvim check-install step
        if [[ -d "$HOME/.vim" ]]; then
            if [[ -f "$HOME/.config/nvim/init.vim" ]]; then
                echo "Vim and Neovim is already installed."
            else
                echo "Vim and Neovim is installing..."
                curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
                tar xzf nvim-macos.tar.gz
                ./nvim-osx64/bin/nvim
                if [[ -f "$HOME/.vim/autoload/plug.vim" ]]; then
                    echo "Vim-plug is already installed."
                else
                echo "vim-plug is installing..."
                    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                fi
            fi
        fi

        # Tmux check and install step
        if [[ -d "$HOME/.tmux"  ]]; then
            echo "Tmux is already installed."
        else
            echo "Tmux is installing..."
            brew install tmux
            if [[ -d "$HOME/.tmux/plugins/tpm/" ]]; then
                echo "Tmux plugin manager is already installed."
            else
                git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
                echo "run '~/.tmux/plugins/tpm/tpm'" >> $HOME/.tmux.conf
            fi
        fi
    ;;

    linux*)
    echo "Linux"

        # Check Homebrew
        if command brew > /dev/null; then
            echo "Homebrew is already installed"
            brew update
            brew upgrade
        else
            echo "Homebrew installing..."
            curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
        fi

        # Zsh check-installtion step
        if command zsh > /dev/null; then
            echo "zsh is already installed"
        else
            echo "zsh is installing..."
            curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
        fi

        # Vim and Nvim check-install step
        if [ ! -d "$HOME/.vim"  ]; then
            if command nvim > /dev/null; then
                echo -e "Vim and Neovim is already installed"
            else
                echo -e "Vim and Neovim is installing..."
                curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
                tar xzf nvim-macos.tar.gz
                ./nvim-osx64/bin/nvim
                if [ ! -d "$HOME/.vim/autoload/plug.vim" ]; then
                    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                else
                    echo -e "Vim-plug is already installed."
                fi
            fi
        fi

        # Tmux check and install step
        if command tmux > /dev/null; then
            echo -e "Tmux is already installed"
        else
            echo -e "Tmux is installing"
            apt install tmux
            if [ ! -d "$HOME/.tmux/plugins/tpm/" ]; then
                git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
                echo -e "run '~/.tmux/plugins/tpm/tpm'" >> $HOME/.tmux/plugins
            else
                echo -e "Tmux plugin manager is already installed."
            fi
        fi
    ;;

    *)
    echo -e "Your OS environment install.sh script is not ready yet."
    ;;

esac

echo "Done! Please don't forget to source your dotfiles to take the effect."

set -x
