#!/bin/bash

# scanner gui
paru -S --noconfirm simple-scan
paru -S --noconfirm sane-airscan

# printer
paru -S --noconfirm cups brother-dcpj105
sudo systemctl enable cups --now
# ... and follow instructions
