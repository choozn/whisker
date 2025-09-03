#!/usr/bin/env bash
# Copyright (C) 2025 choozn
# Installation script for my dotfiles
# It is recommended to install on a fresh installation of Arch Linux using systemd.
# Using a different distro and/or init system will lead to unwanted problems.
#
# To install in one line, run the following command:
# bash <(curl -sL dots.choozn.dev)

source ./whisker/main

check_root() {
    if [[ $EUID -eq 0 ]]; then
        echo "[!] This script should NOT be run as root (or using sudo)."
        echo "[!] Please run this script only as the user for whom you want to install the dotfiles."
        exit 1
    fi
}

greet() {
    clear
    cat <<"EOF"

 /\_/\
( o.o )  Meow! I'm whisker and I'll help you to make this place feel like home!.
 > ^ <          Let's get those dotfiles and dependencies installed!

EOF

    echo "[!] To install the dotfiles and other dependencies, I'll need you to give me sudo privileges."
    echo -e "[!] Don't worry, I'm a well-behaved kitty! No messes, just magic.\n"
}

# Install Steps
check_root
greet
whisker

# Done
echo -e "[!] Installation of successful! Rebooting."
sudo systemctl soft-reboot
