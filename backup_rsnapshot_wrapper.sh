#!/bin/bash
################################################################################
#
# see /etc/rsnapshot.conf for rsnapshot options
#
################################################################################

# TODO: check for arguments, make sure theres one 

echo "rsnapshot doing a $1 backup" 
rsnapshot $1

# Do a rsnapshot diff ... TODO
# rsnapshot-diff -Hvi 
