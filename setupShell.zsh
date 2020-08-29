brew install zsh

sudo sh -c "echo $(which zsh) >> /etc/shells"
echo "Changing shells, you will be prompted for your password..."
chsh -s $(which zsh)
