#!/bin/bash

promptuser() {
  printf "\e[1;32m %s \e[0m " "$*"
  old_stty_cfg=$(stty -g)
  stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg # Careful playing with stty
  if [ "$answer" != "${answer#[Yy]}" ];then
    echo Yes
  else
    echo "" && exit
  fi
}

print-help (){ 
cat << EOF 1>&2
  Usage: $ $0 anyo

EOF
}

if [[ $# -ne 1 ]] ; then
  echo "[ERROR]:" "Debes pasar un anyo" 1>&2
  print-help
  exit 1
fi

year=$1

jpegs=( $(find ./ -maxdepth 1 -name "*.jpeg") )
if [ ${#jpegs[@]} -gt 0 ]; then 
  for f in "${jpegs[@]}"; do
    echo "Moving $f to "${f%.jpeg}.jpg""
    mv -- "$f" "${f%.jpeg}.jpg"
  done
else 
  read -rsn1 -p"No hay jpgs. Continuando con creacion de meses"; echo
fi

meses=("enero" "febrero" "marzo" "abril" "mayo" "junio" "julio" "agosto" "septiembre" "octubre" "noviembre" "diciembre")
k=0
for mes in "${meses[@]}"; do
  m=$(printf "%02d" "$k")
  pics=( $(find ./ -maxdepth 1 -name "IMG-${year}${m}*.jpg") )
  if [ ${#pics[@]} -gt 0 ]; then 
    printf 'Pics son: %s\n' "${pics[@]}"
    promptuser "Continuar?"
    mkdir "$mes"
    mv IMG-${year}${m}*.jpg $mes
  else 
    read -rsn1 -p"No hay fotos para el mes de $mes. Continuando"; echo
  fi
  ((k++))
done

k=0
for mes in "${meses[@]}"; do
  m=$(printf "%02d" "$k")
  pics=( $(find ./ -maxdepth 1 -name "VID-${year}${m}*.mp4") )
  if [ ${#pics[@]} -gt 0 ]; then 
    printf 'Pics son: %s\n' "${pics[@]}"
    promptuser "Continuar?"
    mkdir "$mes"
    mv VID-${year}${m}*.mp4 $mes
  else 
    read -rsn1 -p"No hay fotos para el mes de $mes. Continuando"; echo
  fi
  ((k++))
done

