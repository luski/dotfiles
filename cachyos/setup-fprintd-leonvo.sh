#!/bin/bash

paru -Sy python-validity
fprintd-enroll
# enable after waking up from suspend
sudo systemctl enable open-fprintd-resume open-fprintd-suspend
