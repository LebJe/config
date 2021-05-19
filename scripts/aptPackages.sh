#/bin/bash

echo "installing packages..."

sudo apt install -y zsh exa neovim python3-neovim python3 nodejs npm bat ripgrep fd-find


sudo ln -s $(which fdfind) /usr/local/bin/fd
sudo ln -s $(which batcat) /usr/local/bin/bat

echo "ZSH is installed. Change your shell to ZSH with \`chsh -s /usr/bin/zsh\`."
