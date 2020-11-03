#!/bin/bash

brew install zsh

sudo sh -c "echo $(which zsh) >> /etc/shells"
echo "Changing shells, you will be prompted for your password..."
chsh -s $(which zsh)

# Authenticate using Touch ID for `sudo`.

sudo su -

echo "auth       sufficient     pam_tid.so\n$(cat /etc/pam.d/sudo)" > /etc/pam.d/sudo
