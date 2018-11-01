#!/bin/bash
################################################################################
#
# see /etc/rsnapshot.conf for rsnapshot options
#
################################################################################

# TODO: check for arguments, make sure theres one 
rsnapshot $1 > /home/kitesutra/rsnapshot_$(date +%d%m%Y)_$1.log

# Do a rsnapshot diff ... TODO
# rsnapshot-diff -Hvi 
