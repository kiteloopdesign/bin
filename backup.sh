#!/bin/bash

logfile="/home/${USER}/rsync_backup_$(date +%Y%m%d).log"
tmpfile=$(mktemp /tmp/rysnc-script.XXXXXX)

rsync \
  -avv \
  --stats \
  --delete \
  --itemize-changes \
  --dry-run \
  --compress \
  -e \
  ssh \
  /backup/ \
  $1:/run/media/hdd_backup/ \
  > $tmpfile

# THE -q is IMPORTANT !!!
if grep -q deleting $tmpfile
then
  echo "There are deleted files!"
  echo "Check deleted files and run again without the dry-run option!"
  rm -f "$tmpfile"
  exit
else
  # TODO : Hay un bug en el que en el log NO aparece el "deleting"!!
  rm -f "$tmpfile"

  rsync \
    -avv \
    --stats \
    --delete \
    --itemize-changes \
    --dry-run \
    --log-file="${logfile}" \
    --max-delete=20 \
    --compress \
    -e \
    ssh \
    /backup/ \
    $1:/run/media/hdd_backup/

fi
exit
