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
    printf -- "\e[32m---- \n"
    printf -- "\e[32m---- [%s]\e[0m %s\n" "$timestamp" "$1"
    printf -- "\e[32m---- \n"
}

cd ~

# Add mirrorlist
center_text "Add mirrorlist"
yay -S --noconfirm reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector --verbose -c KR --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
center_text "/etc/pacman.d/mirrorlist"
sudo cat /etc/pacman.d/mirrorlist
center_text ""
write_log "Done"

# Edit concurrent downloads
center_text "Edit concurrent downloads"
sudo sed -E 's/#?ParallelDownloads = [0-9]+/ParallelDownloads = 8/g' /etc/pacman.conf
center_text "/etc/pacman.conf"
sudo cat /etc/pacman.conf
center_text ""
write_log "Done"

# Update the systeem
center_text "Updating the system"
yay -Syu --noconfirm
write_log "Done"

# Update firmware
center_text "Updating firmware"
yay -S --noconfirm linux-firmware
write_log "Done"

# Install keyd
center_text "Install keyd"
yay -S --noconfirm keyd
usermod -aG keyd lewohy
sudo systemctl enable keyd.service
sudo systemctl start keyd.service
write_log "Done"

# Install github-cli
center_text "github-cli"
yay -S --noconfirm github-cli
gh auth login -p https -w
write_log "Done"

# Install Rust
center_text "Install Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
write_log "Done"

# Install packages
center_text "Install packages"
yay -S --noconfirm \
    gdm \
    google-chrome \
    obsidian \
    discord \
    fish \
    ttf-jetbrains-mono-nerd \
    tofi \
    eww \
    bat \
    kitty \
    fd \
    fzf \
    lsd \
    neovim \
    neovide \
    ripgrep \
    starship \
    zoxide \
    croc \
    curl \
    dua-cli \
    duf \
    procs \
    tre-command \
    neofetch \
    fastfetch \
    bottom \
    git-delta \
    sd \
    tealdeer \
    rslsync \
    kime-git \
    jetbrains-toolbox \
    go \
    hyprland-git \
    hyprlock-git \
    xdg-desktop-portal-hyprland-git \
    swaync-git \
    cliphist \
    playerctl-git \
    grim-git \
    slurp-git \
    jq \
    wf-recorder-git \
    brightnessctl-git \
    telegram-desktop \
    figma-linux-bin \
    notion-app-electron

# TODO: wine-stable

write_log "Done"

center_text "Install hyprls"
go install github.com/ewen-lbh/hyprls/cmd/hyprls@latest
write_log "Done"

# Set default shell to fish
center_text "Setting default shell to fish"
chsh -s $(which fish)
write_log "Done"

# Install resilio-sync
center_text "Setup resilio-sync"
mkdir -p ~/.config/rslsync ~/.sync
gh repo clone lewohy/rslsync ~/.config/rslsync
sudo systemctl enable --user rslsync.service
sudo systemctl start --user rslsync.service
write_log "Done"

# Enable gdm
center_text "Enable gdm"
sudo systemctl enable gdm.service
write_log "Done"

# timedatectl(듀얼부팅시 윈도우-리눅스 시간안맞는 문제 해결)
center_text "Fix time issue"
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
# center_text "Setup scripts"
# chmod +x ~/.config/scripts/*
# write_log "Done"
