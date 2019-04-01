#!/usr/bin/env bash

set -e

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

# fonts
#   firefox default serif + sans-serif: ttf-liberation
#   east asian: adobe-source-han-sans-otc-fonts

# other stuff i use that requires more manual/involved installs
#   - localepurge
#   - dnscrypt-proxy
#   - joshuarli-spacefm
#   - tlp + powertop
