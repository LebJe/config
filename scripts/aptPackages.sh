#/bin/bash

PACKAGES="zsh exa gh neovim python3-neovim python3 nodejs npm bat ripgrep fd-find"

echo "installing $PACKAGES ..."

sudo add-apt-repository ppa:neovim-ppa/unstable
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update -q

sudo apt install -yq $PACKAGES

echo "Installed $PACKAGES, now installing delta (https://github.com/dandavison/delta)..."

# Install [delta](https://github.com/dandavison/delta)
case $(uname -m) in
	x86_64) wget -O delta.deb "https://github.com/dandavison/delta/releases/download/0.7.1/git-delta_0.7.1_amd64.deb" ;;
	aarch64) wget -O delta.deb "https://github.com/dandavison/delta/releases/download/0.7.1/git-delta_0.7.1_arm64.deb" ;;
esac

sudo apt install -yq ./delta.deb

rm delta.deb

sudo ln -s $(which fdfind) /usr/local/bin/fd
sudo ln -s $(which batcat) /usr/local/bin/bat

echo "Installation complete!"

echo "ZSH is installed. Change your shell to ZSH with \`chsh -s /usr/bin/zsh\`."
