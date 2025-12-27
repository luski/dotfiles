#!/bin/bash

sudo pacman -Sy swaylock # possible conflicts with swaylock-effects-git - then don't install
sudo pacman -Sy swaylock swayidle

systemctl --user daemon-reload
systemctl --user enable --now swayidle.service
