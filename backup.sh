#!/bin/bash

logfile="/home/${USER}/rsync_backup_$(date +%d%m%Y%H%M).log"
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

# Hay un bug en el que en el log NO aparece el "deleting"!!
# por eso que hay que grepear en la std out y no el el logfile

del_files=$(grep deleting "${tmpfile}")
retcode=$?
rm -f "$tmpfile"

if [ $retcode -eq 0 ]
then
  printf '%s\n\n' "${del_files}"
  read -p "There are deleted files! Do you want to continue? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function
  fi
fi

# No files to be deleted or its ok to delete them
rsync \
  -avv \
  --stats \
  --delete \
  --itemize-changes \
  --log-file="${logfile}" \
  --compress \
  -e \
  ssh \
  /backup/ \
  $1:/run/media/hdd_backup/

exit
--max-delete=20 \
