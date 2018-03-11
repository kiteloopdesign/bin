#!/bin/bash

for f in $(find . -type f -name "*[[:space:]]*")
do 
  echo "$f"
  echo "Desea Renombrar" "$f" ${f// /_};
  read -rsp $'Press any key to continue...\n' -n 1 key
  # mv "$f" ${f// /_};
done

