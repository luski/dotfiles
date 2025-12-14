#!/bin/bash

paru -S --noconfirm walker elephant elephant-all
chezmoi apply ~/.config/systemd/user
systemctl --user enable elephant --now
systemctl --user enable walker --now
