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
gyay -S --noconfirm --overwrite linux-firmware
# sudo systemctl restart NetworkManager
write_log "Done"

# Install
center_text "Install packages"
write_log "github-cli"
gyay -S --noconfirm --overwrite github-cli
gh auth login -p https -w


write_log "google-chrome"
gyay -S --noconfirm --overwrite google-chrome

write_log "obsidian"
gyay -S --noconfirm --overwrite obsidian

write_log "discord"
gyay -S --noconfirm --overwrite discord

write_log "fish"
gyay -S --noconfirm --overwrite fish

write_log "ttf-jetbrains-mono-nerd"
gyay -S --noconfirm --overwrite ttf-jetbrains-mono-nerd

write_log "tofi"
gyay -S --noconfirm --overwrite tofi

write_log "eww"
gyay -S --noconfirm --overwrite eww

write_log "keyd"
gyay -S --noconfirm --overwrite keyd

write_log "bat"
gyay -S --noconfirm --overwrite bat

write_log "kitty"
gyay -S --noconfirm --overwrite kitty

write_log "fd"
gyay -S --noconfirm --overwrite fd

write_log "fzf"
gyay -S --noconfirm --overwrite fzf

write_log "lsd"
gyay -S --noconfirm --overwrite lsd

write_log "neovim"
gyay -S --noconfirm --overwrite neovim

write_log "neovide"
gyay -S --noconfirm --overwrite neovide

write_log "ripgrep"
gyay -S --noconfirm --overwrite ripgrep

write_log "starship"
gyay -S --noconfirm --overwrite starship

write_log "zoxide"
gyay -S --noconfirm --overwrite zoxide

write_log "croc"
gyay -S --noconfirm --overwrite croc

write_log "curl"
gyay -S --noconfirm --overwrite curl

write_log "dua-cli"
gyay -S --noconfirm --overwrite dua-cli

write_log "duf"
gyay -S --noconfirm --overwrite duf

write_log "procs"
gyay -S --noconfirm --overwrite procs

write_log "tre-command"
gyay -S --noconfirm --overwrite tre-command

write_log "neofetch"
gyay -S --noconfirm --overwrite neofetch

write_log "fastfetch"
gyay -S --noconfirm --overwrite fastfetch

write_log "bottom"
gyay -S --noconfirm --overwrite bottom

write_log "git-delta"
gyay -S --noconfirm --overwrite git-delta

write_log "sd"
gyay -S --noconfirm --overwrite sd

write_log "tealdeer"
gyay -S --noconfirm --overwrite tealdeer

write_log "rslsync"
gyay -S --noconfirm --overwrite rslsync

write_log "kime"
gyay -S --noconfirm --overwrite kime

write_log "jetbrains-toolbox"
gyay -S --noconfirm --overwrite jetbrains-toolbox

write_log "go"
gyay -S --noconfirm --overwrite go

write_log "hyprland-git"
gyay -S --noconfirm --overwrite hyprland-git

write_log "swaync-git"
gyay -S --noconfirm --overwrite swaync-git

write_log "hyprlock-git"
gyay -S --noconfirm --overwrite hyprlock-git

write_log "xdg-desktop-portal-hyprland-git"
gyay -S --noconfirm --overwrite xdg-desktop-portal-hyprland-git

write_log "cliphist"
gyay -S --noconfirm --overwrite cliphist

write_log "playerctl-git"
gyay -S --noconfirm --overwrite playerctl-git

write_log "grim-git"
gyay -S --noconfirm --overwrite grim-git

write_log "slurp-git"
gyay -S --noconfirm --overwrite slurp-git

write_log "jq"
gyay -S --noconfirm --overwrite jq

write_log "wf-recorder-git"
gyay -S --noconfirm --overwrite wf-recorder-git

write_log "brightnessctl-git"
gyay -S --noconfirm --overwrite brightnessctl-git

write_log "wine"
gyay -S --noconfirm --overwrite wine

write_log "telegram-desktop"
gyay -S --noconfirm --overwrite telegram-desktop

write_log "figma-linux-bin"
gyay -S --noconfirm --overwrite figma-linux-bin

write_log "notion-app-electron"
gyay -S --noconfirm --overwrite notion-app-electron

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

# 언어 설정
localectl set-locale LANG=en_US.UTF-8

# 테마 설정
# gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' && gsettings set org.gnome.desktop.interface color-scheme 'default'

# Setup scripts
center_text "Setup scripts"
chmod +x ~/.config/scripts/*
write_log "Done"
