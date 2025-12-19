#!/bin/bash

utils=(
	github-cli
	chezmoi
	zoxide
	neovim
	lazygit
	zen-browser
	libappindicator dropbox
	fnm
	obsidian
	qt5-wayland keepassxc
	uwsm
	try-cli
)

# niri specific
niriSpecific=(
	nwg-look
	adw-gtk-theme
	adwaita-color-schemes
	gnome-tweaks
	swappy # Screenshot tool
	loupe  # Image viewer
	evince # PDF viewer
	dialect
)

paru -S --needed noconfirm "${utils[@]}"
paru -S --needed --noconfirm "${niriSpecific[@]}"

curl -fsSL https://tailscale.com/install.sh | sh
