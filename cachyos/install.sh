#!/bin/bash

# Install Dank Linux
curl -fsSL https://install.danklinux.com | sh

# Several utility packages
paru -S --noconfirm github-cli
paru -S --noconfirm chezmoi
paru -S --noconfirm zoxide
paru -S --noconfirm neovim
paru -S --noconfirm lazygit
paru -S --noconfirm zen-browser
paru -S --noconfirm keepassxc
# paru -S --noconfirm gdm
paru -S --noconfirm dropbox

paru -S --noconfirm xremap # to make single META button work

paru -S --noconfirm walker elephant elephant-desktopapplications elephant-websearch
elephant service enable

chezmoi init luski --branch cachyos --apply
