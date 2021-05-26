#/bin/bash

PACKAGES="zsh exa gh neovim python3-neovim python3 nodejs npm bat ripgrep fd-find"

echo "installing $PACKAGES ..."

sudo add-apt-repository ppa:neovim-ppa/unstable

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update -q

sudo apt install -yq $PACKAGES
sudo ln -s $(which fdfind) /usr/local/bin/fd
sudo ln -s $(which batcat) /usr/local/bin/bat

echo "ZSH is installed. Change your shell to ZSH with \`chsh -s /usr/bin/zsh\`."
