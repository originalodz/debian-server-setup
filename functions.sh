#!/bin/bash

# Exit if user ID is not 0 (root)
function isRoot() {
    if  [[ $EUID != 0 ]]; then
        echo "You need to run me as root. Exiting."
        exit
    fi
}

# Add a user account with sudo permissions
function addUserAccount() {
    read -p "Username: " username
    read -sp "Password: " password
    
    # Check for an empty username or password
    if [[ -z "$username" ]] || [[ -z "$password" ]]; then
        echo "Username cannot be empty."
        read -p "Username: " username
    elif [[ -z "$password" ]]; then
        echo "Password cannot be empty."
        read -sp "Password: " password
    else 
        # Neither was empty so add the user.
        # --disabled-login does not run passwd
        # --gecos removes prompts for user account info
        adduser --disabled-login --gecos '' $username
        # Give the user account sudo access
        usermod -aG sudo $username
        # Update the user account with supplied password
        echo "$username:$password" | chpasswd
        echo "$username has been added with sudo permission."
}