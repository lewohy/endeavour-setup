FROM archlinux:latest

# Update
RUN pacman -Syu --noconfirm
RUN pacman -S --needed --noconfirm git base-devel

# Create User
RUN useradd -m lewohy
RUN echo "lewohy:1234" | chpasswd
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER lewohy
WORKDIR /home/lewohy

RUN git clone https://aur.archlinux.org/yay.git
RUN cd yay
RUN makepkg -si

# Update
RUN yay -Syu --noconfirm

# setup.sh
COPY --chown=lewohy:lewohy setup.sh /home/lewohy/setup.sh
RUN chmod +x /home/lewohy/setup.sh

# Run setup.sh
CMD [ "./setup.sh", ";", "bash" ]
