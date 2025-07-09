#!/usr/bin/env bash
# Copyright (C) 2025 choozn
# Installation script for my dotfiles
# It is recommended to install on a fresh installation of Arch Linux using systemd.
# Using a different distro and/or init system might lead to unwanted problems.
#
# To install in one line, run the following command:
# curl -Ls dots.choozn.dev | bash

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

install_yay() {
    if command -v yay &>/dev/null; then
        export base="$(pwd)"
        sudo pacman -S --needed --noconfirm base-devel git
        git clone https://aur.archlinux.org/yay-bin.git /tmp/buildyay
        cd /tmp/buildyay
        makepkg -o
        makepkg -se
        makepkg -i --noconfirm
        cd $base
        rm -rf /tmp/buildyay
    fi
}

# Installation config
install_name="whisker"
install_path="$HOME/${install_name}"
backup_root="$HOME/${install_name}_backups"
backup_folder="${backup_root}/${install_name}_backup_$(date +'%Y-%m-%d_%H-%M-%S')"

# Whisker config
bundle_folder="bundles"
bundle_config="bundle.conf"

source ./whisker/bundle

# Install Steps
check_root
greet
request_sudo
install_yay

# Bundles
mandatory_bundles=(system audio fonts hyprland waybar alacritty thunar psd gtk zsh)
optional_bundles=(docker swap zen chromium common qemu nix ly syncthing)

# Install mandatory bundles
for bundle in "${mandatory_bundles[@]}"; do
    install_bundle "${bundle}"
done

echo -e "[!] Installation of all mandatory dependencies successful!"

# Start Hyprland
if [[ "$XDG_CURRENT_DESKTOP" != "Hyprland" ]]; then
    touch "$HOME/.config/hypr/first.start"
    echo -e 'exec-once = alacritty --class "alacritty-float,alacritty-float" -e zsh -i -c "~/.config/hypr/optional.sh; exec zsh"' >>"$HOME/.config/hypr/hyprland.conf"
    Hyprland &
else
    source "$HOME/.config/hypr/optional.sh"
fi
