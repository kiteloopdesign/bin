#!/bin/bash

function setclip {
  xclip -selection c
}

function getclip {
  xclip -selection clipboard -o
}

filename=$(mktemp)
# gnome-terminal -e gvim "${filename}"
gnome-terminal -x sh -c 'vim ${filename}'
urxvt -e gvim "${filename}" # replace with your favorite terminal

cat ${filename} | setclip
rm ${filename}

xdotool key ctrl+v

