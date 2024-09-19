FROM archlinux:latest

# Update
RUN pacman -Syu --noconfirm
RUN pacman -S --needed --noconfirm git base-devel

# Create User
RUN useradd -m lewohy
RUN echo "lewohy:1234" | chpasswd
RUN echo "lewohy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER lewohy
WORKDIR /home/lewohy

RUN git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm

RUN yay -S --noconfirm reflector
RUN sudo reflector --verbose -c KR --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
RUN sudo cat /etc/pacman.d/mirrorlist
RUN sudo sed -i 's/#?ParallelDownloads = \d+/ParallelDownloads = 8/g' /etc/pacman.conf

# Update
RUN yay -Syu --noconfirm
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN yay -S --noconfirm \
    keyd \
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
    # hyprland-git \
    # hyprlock-git \
    # xdg-desktop-portal-hyprland-git \
    # swaync-git \
    cliphist \
    # playerctl-git \
    grim-git \
    slurp-git \
    jq \
    wf-recorder-git \
    brightnessctl-git \
    # wine-stable \
    telegram-desktop \
    figma-linux-bin \
    notion-app-electron

# setup.sh
COPY --chown=lewohy:lewohy setup.sh /home/lewohy/setup.sh
RUN chmod +x /home/lewohy/setup.sh

# Run setup.sh
CMD [ "./setup.sh", ";", "bash" ]
