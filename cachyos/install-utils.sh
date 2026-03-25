#!/bin/bash

paru -S --needed --noconfirm github-cli
paru -S --needed --noconfirm chezmoi
paru -S --needed --noconfirm zoxide
paru -S --needed --noconfirm neovim
paru -S --needed --noconfirm lazygit
paru -S --needed --noconfirm zen-browser
paru -S --needed --noconfirm libappindicator dropbox
paru -S --needed --noconfirm fnm
paru -S --needed --noconfirm obsidian
paru -S --needed --noconfirm qt5-wayland keepassxc
paru -S --needed --noconfirm uwsm
curl -fsSL https://tailscale.com/install.sh | sh

# niri specific
packages=(
	nwg-look
	adw-gtk-theme
	adwaita-color-schemes
	gnome-tweaks
	# Screenshot tools:
	slurp
	gradia
	grim
	loupe  # Image viewer
	evince # PDF viewer
	dialect
	wlr-which-key
)

paru -S --needed --noconfirm "${packages[@]}"
