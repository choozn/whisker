#!/usr/bin/env bash
# Copyright (C) 2025 choozn
# Installation script for my dotfiles
# It is recommended to install on a fresh installation of Arch Linux using systemd.
# Using a different distro and/or init system will lead to unwanted problems.
#
# To install in one line, run the following command:
# sh <(curl -sL dots.choozn.dev)

install_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$install_path/whisker/main"

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

sudo_keepalive() {
    while true; do
        sleep 60
        sudo -n true 2>/dev/null || exit
    done
}
sudo_keepalive &
SUDO_KEEPALIVE_PID=$!

cleanup() {
    kill "$SUDO_KEEPALIVE_PID" 2>/dev/null
}
trap cleanup EXIT

# Install Steps
check_root_prompt
greet
request_sudo
whisker

# Done
echo -e "[!] Installation was successful! Rebooting."
sudo systemctl soft-reboot
