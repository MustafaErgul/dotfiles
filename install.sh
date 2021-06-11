#!/bin/bash

# Installation script to tools for the dotFiles.

OS_TYPE=$(echo -e $(uname)|awk '{print tolower($0)}')

zsh_install(){
        if [[ -d "$HOME/.oh-my-zsh" ]]; then
            echo "zsh is already installed."
        else
            echo "zsh is installing..."
            curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
        fi
}

vim_nvim_install(){
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
}

case $OS_TYPE in

    darwin*)
    echo "MacOS"

        # Check Homebrew
        if [[ -d "/usr/local/Cellar" ]]; then
            echo "Homebrew is already installed."
        else
            echo "Homebrew installing..."
            curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
        fi

        # Zsh check-installation step
        zsh_install()

        # vim and neovim install step
        vim_nvim_install()

        # Tmux check and install step
        if [[ -d "$HOME/.tmux" ]]; then
            echo "Tmux is already installed."
        else
            echo "Tmux is installing..."
            brew install tmux
            if [[ -d "$HOME/.tmux/plugins/tpm/" ]]; then
                echo "Tmux plugin manager is already installed."
            else
                echo "Tmux plugin panager installing..."
                git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
                echo "run '~/.tmux/plugins/tpm/tpm'" >> $HOME/.tmux.conf
            fi
        fi
    ;;

    linux*)
    echo "Linux"

        # Zsh check-installtion step
        zsh_install()

        # vim and neovim install step
        vim_nvim_install()

        # Tmux check and install step
        if [[ $(which tmux) == "/usr/bin/tmux"  ]]; then
            echo "Tmux is already installed"
        else
            echo "Tmux is installing"
            apt install tmux
            if [[ -d "$HOME/.tmux/plugins/tpm/" ]]; then
                echo "Tmux plugin manager is already installed."
            else
                echo "Tmux plugin panager installing..."
                git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
                echo "run '~/.tmux/plugins/tpm/tpm'" >> $HOME/.tmux.conf
            fi
        fi
    ;;

    *)
    echo -e "Your OS environment install.sh script is not ready yet."
    ;;

esac

# Copy dotfiles from this repository and source them;
cp {.vimrc,.zshrc,.tmux.conf} $HOME
cp .config/nvim/init.vim $HOME/.config/nvim/init.vim
source $HOME/.zshrc

echo "Done! Please don't forget to source your dotfiles to take the effect."
