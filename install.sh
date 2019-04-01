#!/usr/bin/env bash

set -e

printf %s\\n "updating system and installing prerequisite software..."
sudo pacman --noconfirm --needed -Syu base-devel curl git stow

printf %s\\n "installing yay..."
TMP="$(mktemp -d)"
pushd "$TMP"
curl "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay-bin" -o PKGBUILD
makepkg -si --noconfirm --needed
popd

sudo sed -i '/Color/s/^#//g' /etc/pacman.conf
yay --sudoloop --save

printf %s\\n "installing zsh as login shell..."
yay --noconfirm --needed -S zsh
printf %s\\n "you'll be prompted for your password to chsh."
sudo chsh -s "$(command -v zsh)" "$(whoami)"

printf %s\\n "installing core graphical software..."
yay --noconfirm --needed -S \
    bspwm sxhkd \
    polybar rofi rxvt-unicode ttf-font-awesome-4 ttf-hack \
    dunst libnotify \
    light redshift-minimal feh maim \
    udisks2 udiskie \
    xorg-xinit xorg-server xclip

printf %s\\n "installing physlock..."
yay --noconfirm --needed -S physlock
sudo tee /etc/systemd/system/physlock.service >/dev/null <<EOF
[Unit]
Description=Lock X session with physlock
Before=sleep.target

[Service]
Type=forking
ExecStart=$(command -v physlock) -dsp 'this computer is locked.'

[Install]
WantedBy=sleep.target
EOF
sudo systemctl enable /etc/systemd/system/physlock.service

printf %s\\n "installing other good software..."
yay --noconfirm --needed -S \
    dfc ncdu htop ripgrep fd exa rsync jq atool binutils upx qemu \
    inotify-tools android-tools firejail wget aria2 \
    strace ltrace bind-tools \
    editorconfig-core-c micro-bin nano screen tmux tio \
    pass rofi-pass \
    inxi acpi lshw \
    mpv-git pavucontrol-qt cava \
    irssi qbittorrent \
    grabc \
    qpdfview gpicview leafpad

printf %s\\n "installing dotfiles..."
git clone --recursive https://github.com/JoshuaRLi/dotfiles "${HOME}/dotfiles"
cd "${HOME}/dotfiles"
# prevent conflict with GNU stow - more conflicting files may exist if user is not running a fresh Arch install
mv "${HOME}/.bashrc"{,.bak}
bash ./link.sh og

# fonts
#   firefox default serif + sans-serif: ttf-liberation
#   east asian: adobe-source-han-sans-otc-fonts

# other stuff i use that requires more manual/involved installs
#   - localepurge
#   - dnscrypt-proxy
#   - joshuarli-spacefm
#   - tlp + powertop
