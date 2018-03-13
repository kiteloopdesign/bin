#!/bin/bash
################################################################################
#
# Parses ssh logs looking for a breach. Sends a mail if the system 
# has been compromised
#
################################################################################

SSHUSER=$1
USERMAIL=$2

# Who has accessed the ssh server?
parsed_text=$(grep -i sshd.\*accepted\ publickey /var/log/auth.log)
parsed_text+=$'\n'
parsed_text+=$(grep -i sshd.\*session\ opened /var/log/auth.log)
hacked=$(printf "${parsed_text}" | grep -v "${SSHUSER}")
retval=$?

# printf "${parsed_text}" | grep  -v $SSHUSER
# printf 'retval value is %s\n' ${retval}
# exit

# Si otro usuario que no es SSHUSER ... MALRO !
if [ $retval -eq 0 ]; then
  printf "Subject : ***** SSH Server COMPROMISED !!! ***** \n\n ${hacked}" | ssmtp "${USERMAIL}"
  # printf "Subject : ***** SSH Server COMPROMISED !!! ***** \n\n ${hacked}" 
else
# IMPORTANT! : The \n IS needed before the mail body !!!
  # printf '\n%s' "${parsed_text}" | ssmtp -v "${USERMAIL}"
  # printf 'Subject : SSH Server OK \n\n%s' "${parsed_text}" | ssmtp -v "${USERMAIL}"
  printf 'Subject : SSH Server OK \n\n%s' "${parsed_text}" | ssmtp "${USERMAIL}"
fi






