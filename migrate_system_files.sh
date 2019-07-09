#!/bin/bash
################################################################################
#
# copies over some system files to /home
# this is useful when backing up system
#
################################################################################

sudo dnf history > ~/dnf_history.log
cp /etc/crontab ~
cp /etc/anacrontab ~
cp /etc/fstab ~
cp /etc/sudoers ~

