#!/bin/bash
################################################################################
# Parses ssh logs and sends digest with accesses
#
################################################################################

SSHUSER=$1
USERMAIL=$2

# Who has accessed the ssh server?
parsed_text=$(grep -i sshd.\*accepted\ publickey /var/log/auth.log)
parsed_text+=$'\n'
parsed_text+=$(grep -i sshd.\*session\ opened /var/log/auth.log)

# IMPORTANT! : The \n IS needed before the mail body !!!
printf 'Subject : SSH Access Digest \n\n%s' "${parsed_text}" | ssmtp "${USERMAIL}"






