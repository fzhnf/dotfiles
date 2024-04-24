#!/bin/sh

# You can call this script like this:
# $ ./volume-control.sh up
# $ ./volume-control.sh down
# $ ./volume-control.sh mute

# Script modified from these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_volume {
  pamixer --get-volume
}


function get_mic_volume {
  mic_source=$(pamixer --list-sources | awk '/alsa_input/ {print $1}')
  pamixer --source "$mic_source" --get-volume
}

function send_notification {
  if [ "$(pamixer --get-mute)" = true ]; then
    dunstify  -i "󰖁" -r 2593 -u normal "mute"
  else
    dunstify -i " " -r 2593 -u normal -h int:value:"$1" "Volume: $1%"
  fi
}

function send_mic_notification {
  mic_source=$(pamixer --list-sources | awk '/alsa_input/ {print $1}')
  if [ "$(pamixer --source "$mic_source" --get-mute)" = true ]; then
    dunstify  -i " " -r 2594 -u normal "Mic muted"
  else
    dunstify -i "" -r 2594 -u normal -h int:value:"$1" "Mic Volume: $1%"
  fi
}

function step {
  # if [ "$(get_volume)" -lt 30 ]; then
  if [ "$1" -lt 30 ]; then
    echo 2
  else
    echo 5
  fi
}

case $1 in
  up)
    pamixer --unmute
    # if [ "$(get_volume)" -lt 30 ]; then
    #   pamixer --increase 2
    # else
    #   pamixer --increase 5
    # fi
    pamixer --increase "$(step "$(get_volume)")"
    send_notification "$(get_volume)"
    ;;
  down)
    pamixer --unmute
    # if [ "$(get_volume)" -lt 30 ]; then
    #   pamixer --decrease 2
    # else
    #   pamixer --decrease 5
    # fi
    pamixer --decrease "$(step "$(get_volume)")"
    send_notification "$(get_volume)"
    ;;
  mute)
    pamixer --toggle-mute
    send_notification "$(get_volume)"
    ;;
  mic-up)
    mic_source=$(pamixer --list-sources | awk '/alsa_input/ {print $1}')
    pamixer --source "$mic_source" --unmute --increase "$(step "$(get_mic_volume)")"
    send_mic_notification "$(get_mic_volume)"
    ;;
  mic-down)
    mic_source=$(pamixer --list-sources | awk '/alsa_input/ {print $1}')
    pamixer --source "$mic_source" --unmute --decrease "$(step "$(get_mic_volume)")"
    send_mic_notification "$(get_mic_volume)"
    ;;
  mic-mute)
    mic_source=$(pamixer --list-sources | awk '/alsa_input/ {print $1}')
    pamixer --source "$mic_source" --toggle-mute
    send_mic_notification "$(get_mic_volume)"
    ;;
esac

