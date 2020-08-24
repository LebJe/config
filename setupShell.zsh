brew install zsh

sudo sh -c "echo /usr/local/bin/zsh >> /etc/shells"
echo "Changing shells, you will be prompted for your password..."
chsh -s /usr/local/bin/zsh
