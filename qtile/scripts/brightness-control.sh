#!/bin/sh

# You can call this script like this:
# $ ./brightness-control.sh up
# $ ./brightness-control.sh down

# Script inspired by these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

# Icon path: /usr/share/icons/Papirus/16x16/apps
icon="display-brightness"

# Define the list of brightness levels
brightness_list=("0.059" "1" "2" "3" "5" "8" "13" "21" "34" "55" "89" "100")


function get_brightness {
  xbacklight -get | cut -d '.' -f 1
}


function send_notification {
  dunstify -i "$icon" -r 5555 -u normal -h int:value:"$1" "Brightness: $1%"
}

function get_index {
  if (( $1 < 1 )); then
    echo 0
  elif (( $1 < 2 )); then
    echo 1
  elif (( $1 < 3 )); then
    echo 2
  elif (( $1 < 5 )); then
    echo 3
  elif (( $1 < 8 )); then
    echo 4
  elif (( $1 < 13 )); then
    echo 5
  elif (( $1 < 21 )); then
    echo 6
  elif (( $1 < 34 )); then
    echo 7
  elif (( $1 < 55 )); then
    echo 8
  elif (( $1 < 89 )); then
    echo 9
  elif (( $1 < 100 )); then
    echo 10
  else
    echo 11
  fi
}



case $1 in
  up)
    index=$(get_index $(get_brightness))
    if (( $index == 11 )); then
      exit 0
    fi
    xbacklight -set "${brightness_list[$index+1]}"
    send_notification "$(get_brightness)"
    ;;
  down)
    index=$(get_index $(get_brightness))
    if (( $index == 0 )); then
      exit 0
    fi
    xbacklight -set "${brightness_list[$index-1]}"
    send_notification "$(get_brightness)"
    ;;
esac
