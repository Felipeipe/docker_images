#!/bin/bash
RULES=~/Documents/docker_images/pioneer/config/udev_scripts/99-pioneer.rules

echo "Installing udev rules from $RULES"
sudo cp "$RULES" /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger

echo "Done!"
