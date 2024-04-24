#!/bin/sh
# start-clipman() {
#     while true; do
#         # Check if xfce4-clipman is running
#         if ! pgrep "xfce4-clipman" > /dev/null; then
#             xfce4-clipman &
#         fi
#         sleep 1s
#     done
# }
# start-clipman &

copyq &

# Start xfce4-power-manager in the background
xfce4-power-manager &

# Start dunst & picom in the background
dunst &
picom &

# Start discord & signal on tray if the battery is not discharging
if ! grep -q "Discharging" /sys/class/power_supply/BAT0/status > /dev/null; then
    signal-desktop --start-in-tray &
    discord --start-minimized &
fi

# Disable the built-in keyboard if my RK keyboard is detected
if xinput list | grep -qE "Compx 2.4G Wireless Receiver Keyboard|SINO WEALTH RK Bluetooth Keyboard"> /dev/null; then
    xinput disable "AT Translated Set 2 keyboard"
fi

# Turn off system beep
xset b off
