#!/bin/bash

center_text() {
    width=$(tput cols)
    message_size=${#1}

    pad_size=$((($width - $message_size) / 2))
    extra_size=$((1 - ($message_size % 2)))

    printf "\e[32m"
    printf "%0.s-" $(seq 1 $pad_size)
    printf "$1"
    printf "%0.s-" $(seq 1 $pad_size)
    printf "\n"
    printf "\e[0m"
}

write_log() {
    timestamp=$(date +"%Y-%m-%d %H:%m:%S")
    printf "[%s] %s\n" "$timestamp" "$1"
}

cd ~

# Update the systeem
center_text "Updating the system"
yay -Syu --noconfirm
write_log "Done"

# Update firmware
center_text "Updating firmware"
yay -S --noconfirm linux-firmware
# sudo systemctl restart NetworkManager
write_log "Done"

# Install
center_text "Install packages"
yay -S --noconfirm google-chrome
yay -S --noconfirm obsidian
yay -S --noconfirm discord
yay -S --noconfirm fish
yay -S --noconfirm ttf-jetbrains-mono-nerd
yay -S --noconfirm tofi
yay -S --noconfirm eww
yay -S --noconfirm keyd
yay -S --noconfirm bat
yay -S --noconfirm kitty
yay -S --noconfirm fd
yay -S --noconfirm fzf
yay -S --noconfirm lsd
yay -S --noconfirm neovim
yay -S --noconfirm neovide
yay -S --noconfirm ripgrep
yay -S --noconfirm starship
yay -S --noconfirm zoxide
yay -S --noconfirm croc
yay -S --noconfirm curl
yay -S --noconfirm dua-cli
yay -S --noconfirm sd
yay -S --noconfirm duf
yay -S --noconfirm procs
yay -S --noconfirm tre-command
yay -S --noconfirm neofetch
yay -S --noconfirm fastfetch
yay -S --noconfirm bottom
yay -S --noconfirm git-delta
yay -S --noconfirm sd
yay -S --noconfirm tealdeer
yay -S --noconfirm rslsync
yay -S --noconfirm github-cli
yay -S --noconfirm kime
yay -S --noconfirm jetbrains-toolbox
yay -S --noconfirm go
yay -S --noconfirm hyprland-git
yay -S --noconfirm swaync-git
yay -S --noconfirm hyprlock-git
yay -S --noconfirm xdg-desktop-portal-hyprland-git
yay -S --noconfirm cliphist
yay -S --noconfirm playerctl-git
yay -S --noconfirm grim-git
yay -S --noconfirm slurp-git
yay -S --noconfirm jq-git
yay -S --noconfirm wf-recorder-git
yay -S --noconfirm brightnessctl-git
yay -S --noconfirm wine
yay -S --noconfirm telegram-desktop
yay -S --noconfirm figma-linux-bin
yay -S --noconfirm notion-app-electron
yay -S --noconfirm github-cli
write_log "Done"

center_text "Install hyprls"
go install github.com/ewen-lbh/hyprls/cmd/hyprls@latest
write_log "Done"

# Set default shell to fish
center_text "Setting default shell to fish"
chsh -s $(which fish)
write_log "Done"

# Setup keyd
center_text "Setup keyd"
sudo systemctl enable keyd.service
sudo systemctl start keyd.service
# TODO: Add keyd configuration

# Setup github-cli
center_text "Setup github-cli"
gh auth login -p https -w
write_log "Done"

# Install resilio-sync
center_text "Setup resilio-sync"
mkdir -p ~/.config/rslsync ~/.sync
gh repo clone lewohy/rslsync ~/.config/rslsync
systemctl enable --user rslsync.service
systemctl start --user rslsync.service
write_log "Done"

# timedatectl(듀얼부팅시 윈도우-리눅스 시간안맞는 문제 해결)
center_text "Fixing time issue"
timedatectl set-local-rtc 1 --adjust-system-clock
write_log "Done"

# Setup tldr
center_text "Setup tldr"
tldr --update
write_log "Done"

# pam 설정 변경
# /etc/security/faillock.conf
# deny = 0설정

# 테마 설정
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' && gsettings set org.gnome.desktop.interface color-scheme 'default'

# Setup scripts
center_text "Setup scripts"
chmod +x ~/.config/scripts/*
write_log "Done"
