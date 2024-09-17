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
    printf "\e[32m[%s]\e[0m %s\n" "$timestamp" "$1"
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
write_log "github-cli"
yay -S --noconfirm github-cli
gh auth login -p https -w


write_log "google-chrome"
yay -S --noconfirm google-chrome

write_log "obsidian"
yay -S --noconfirm obsidian

write_log "discord"
yay -S --noconfirm discord

write_log "fish"
yay -S --noconfirm fish

write_log "ttf-jetbrains-mono-nerd"
yay -S --noconfirm ttf-jetbrains-mono-nerd

write_log "tofi"
yay -S --noconfirm tofi

write_log "eww"
yay -S --noconfirm eww

write_log "keyd"
yay -S --noconfirm keyd

write_log "bat"
yay -S --noconfirm bat

write_log "kitty"
yay -S --noconfirm kitty

write_log "fd"
yay -S --noconfirm fd

write_log "fzf"
yay -S --noconfirm fzf

write_log "lsd"
yay -S --noconfirm lsd

write_log "neovim"
yay -S --noconfirm neovim

write_log "neovide"
yay -S --noconfirm neovide

write_log "ripgrep"
yay -S --noconfirm ripgrep

write_log "starship"
yay -S --noconfirm starship

write_log "zoxide"
yay -S --noconfirm zoxide

write_log "croc"
yay -S --noconfirm croc

write_log "curl"
yay -S --noconfirm curl

write_log "dua-cli"
yay -S --noconfirm dua-cli

write_log "duf"
yay -S --noconfirm duf

write_log "procs"
yay -S --noconfirm procs

write_log "tre-command"
yay -S --noconfirm tre-command

write_log "neofetch"
yay -S --noconfirm neofetch

write_log "fastfetch"
yay -S --noconfirm fastfetch

write_log "bottom"
yay -S --noconfirm bottom

write_log "git-delta"
yay -S --noconfirm git-delta

write_log "sd"
yay -S --noconfirm sd

write_log "tealdeer"
yay -S --noconfirm tealdeer

write_log "rslsync"
yay -S --noconfirm rslsync

write_log "kime"
yay -S --noconfirm kime

write_log "jetbrains-toolbox"
yay -S --noconfirm jetbrains-toolbox

write_log "go"
yay -S --noconfirm go

write_log "hyprland-git"
yay -S --noconfirm hyprland-git

write_log "swaync-git"
yay -S --noconfirm swaync-git

write_log "hyprlock-git"
yay -S --noconfirm hyprlock-git

write_log "xdg-desktop-portal-hyprland-git"
yay -S --noconfirm xdg-desktop-portal-hyprland-git

write_log "cliphist"
yay -S --noconfirm cliphist

write_log "playerctl-git"
yay -S --noconfirm playerctl-git

write_log "grim-git"
yay -S --noconfirm grim-git

write_log "slurp-git"
yay -S --noconfirm slurp-git

write_log "jq"
yay -S --noconfirm jq

write_log "wf-recorder-git"
yay -S --noconfirm wf-recorder-git

write_log "brightnessctl-git"
yay -S --noconfirm brightnessctl-git

write_log "wine"
yay -S --noconfirm wine

write_log "telegram-desktop"
yay -S --noconfirm telegram-desktop

write_log "figma-linux-bin"
yay -S --noconfirm figma-linux-bin

write_log "notion-app-electron"
yay -S --noconfirm notion-app-electron

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
