#!/bin/bash

touch /home/kitesutra/anacron_test.deleteme

while true
do
  echo 'running anacron'
  echo "anacron" >> /home/kitesutra/anacron_test.deleteme
  sleep 1
done

