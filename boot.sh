#!/usr/bin/env bash
# Copyright (C) 2025 choozn
# This is the self-contained boot script for whisker.
# Sourcing from other files is strictly prohibited, as the script is executed in an isolated script environment.

# Configuration
remote="https://github.com/choozn/whisker"
location="$HOME/.whisker"

# Functions
greet() {
    clear
    cat <<"EOF"

 /\_/\
( o.o )  Meow! I'm whisker and I'll help you to make this place feel like home!.
 > ^ <          Let's get those dotfiles and dependencies installed!

EOF
}

request_sudo() {
    if ! sudo -n true 2>/dev/null; then
        echo "[!] To install the dotfiles and other dependencies, I'll need you to give me sudo privileges."
        echo -e "[!] Don't worry, I'm a well-behaved kitty! No messes, just magic.\n"
        sudo -v
    fi
}

check_root_prompt() {
    if [[ $EUID -eq 0 ]]; then
        echo "[!] This script should NOT be run as root (or using sudo)."
        echo "[!] Please run this script only as the user for whom you want to install the dotfiles."
        exit 1
    fi
}

# Handle privileges and greet
check_root_prompt
greet
request_sudo

# Install git and clone
sudo pacman --noconfirm -S git
git clone "$remote" "$location"

# Run installer
cd "$location"
exec "./install.sh"
