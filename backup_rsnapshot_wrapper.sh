#!/bin/bash
################################################################################
#
# see /etc/rsnapshot.conf for rsnapshot options
#
################################################################################
echo "rsnapshot doing a $1 backup" 
rsnapshot $1

# Do a rsnapshot diff ... TODO
# rsnapshot-diff -Hvi 
