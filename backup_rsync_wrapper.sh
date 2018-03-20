#!/bin/bash

logfile="/home/${USER}/rsync_backup_$(date +%d%m%Y%H%M).log"
tmpfile=$(mktemp /tmp/rsync-script.XXXXXX)

printf 'Script called with options "%s" and "%s" \n' "${1}" "${2}"
read
# printf 'Script called with options "%s" and "%s" \n' "$1" "$2"

rsync \
  -avv \
  --stats \
  --delete \
  --itemize-changes \
  --dry-run \
  --compress \
  -e \
  ssh \
  "${1}" \
  "${2}" \
  > $tmpfile

# Hay un bug en el que en el log NO aparece el "deleting"!!
# por eso que hay que grepear en la std out y no el el logfile

del_files=$(grep deleting "${tmpfile}")
retcode=$?

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

rm -f "$tmpfile"

rsync \
  -avv \
  --stats \
  --delete \
  --itemize-changes \
  --log-file="${logfile}" \
  --compress \
  -e \
  ssh \
  "${1}" \
  "${2}"

exit
--max-delete=20 \
