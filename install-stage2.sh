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
    dfc ncdu htop \
    editorconfig-core-c micro-bin nano \
    mpv-git
