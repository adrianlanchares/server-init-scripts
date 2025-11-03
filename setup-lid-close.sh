#!/bin/bash

# This script makes Linux ignore lid close events

CONF_FILE="/etc/systemd/logind.conf"

sudo cp "$CONF_FILE" "${CONF_FILE}.bak"

# delete existing lines, add lines with 'ignore'
sudo sed -i '/^HandleLidSwitch=/d' "$CONF_FILE"
sudo sed -i '/^HandleLidSwitchDocked=/d' "$CONF_FILE"

echo "HandleLidSwitch=ignore" | sudo tee -a "$CONF_FILE"
echo "HandleLidSwitchDocked=ignore" | sudo tee -a "$CONF_FILE"

sudo systemctl restart systemd-logind

echo "Lid close behavior set to ignore. Backup saved as ${CONF_FILE}.bak"
