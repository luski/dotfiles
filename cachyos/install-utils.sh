#!/bin/bash

paru -S --noconfirm github-cli
paru -S --noconfirm chezmoi
paru -S --noconfirm zoxide
paru -S --noconfirm neovim
paru -S --noconfirm lazygit
paru -S --noconfirm zen-browser
paru -S --noconfirm libappindicator dropbox
paru -S --noconfirm fnm
paru -S --noconfirm obsidian
paru -S --noconfirm qt5-wayland keepassxc
curl -fsSL https://tailscale.com/install.sh | sh
paru -S --noconfirm uwsm

# niri specific
paru -S --noconfirm nwg-look adw-gtk-theme adwaita-color-schemes gnome-tweaks
