#!/bin/bash

echo "Enabling Touch ID Authentication, you'll be asked for your password..."

# Authenticate using Touch ID for `sudo`.
sudo su -

echo "auth       sufficient     pam_tid.so\n$(cat /etc/pam.d/sudo)" > /etc/pam.d/sudo

exit
