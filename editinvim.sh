#!/bin/bash

#!/bin/bash
tmpfile=$(mktemp)

urxvt -name floating -e gvim -v +startinsert "$tmpfile"
head -c -1 $tmpfile | xdotool type --clearmodifiers --delay 0 --file -

rm $tmpfile

# function setclip {
#   xclip -selection c
# }

# function getclip {
#   xclip -selection clipboard -o
# }

# filename=$(mktemp)
# # gnome-terminal -e gvim "${filename}"
# gnome-terminal -x sh -c 'vim ${filename}'
# urxvt -e gvim -v "${filename}" # replace with your favorite terminal

# cat ${filename} | setclip
# rm ${filename}

# xdotool key ctrl+v

