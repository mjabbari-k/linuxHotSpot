#!/usr/bin/env bash
# hotspot - control Wi-Fi hotspot via NetworkManager (nmcli)
# Usage: hotspot on | off

DEVICE="wlp9s0"     # change if your interface differs
CON_NAME="Hotspot"  # default connection name

# Check dependencies
command -v nmcli >/dev/null 2>&1 || { echo "nmcli not found."; exit 1; }

case "$1" in
  on)
    # Check if the hotspot connection exists
    if ! nmcli connection show "$CON_NAME" &>/dev/null; then
      echo "Hotspot not initialized."
      read -rp "Enter SSID: " SSID
      read -rsp "Enter password (8+ chars): " PASS; echo
      nmcli dev wifi hotspot ifname "$DEVICE" ssid "$SSID" password "$PASS" || exit 1
      nmcli connection modify "$CON_NAME" ipv4.method shared
      echo "Hotspot '$SSID' created and active."
    else
      nmcli connection up "$CON_NAME" || exit 1
      echo "Hotspot activated."
    fi
    ;;
  off)
    if nmcli connection show --active | grep -q "$CON_NAME"; then
      nmcli connection down "$CON_NAME"
      echo "Hotspot deactivated."
    else
      echo "Hotspot is not active."
    fi
    ;;
  *)
    echo "Usage: hotspot {on|off}"
    exit 1
    ;;
esac
