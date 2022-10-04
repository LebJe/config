#!/bin/bash

echo "Enabling Touch ID Authentication, make sure you run this script with \`sudo\`!"

# Authenticate using Touch ID for `sudo`.
echo \"auth       sufficient     pam_tid.so\n$(cat /etc/pam.d/sudo)\" > /etc/pam.d/sudo


