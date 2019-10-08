#!/bin/sh

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    exit 1
fi

USERNAME=${1}
ADMIN=${2}


echo "Running bootstrap script for user ${USERNAME}"
useradd -m -g users ${USERNAME}

if [ "${ADMIN}" = True ] ; then
    echo "Setting user ${USERNAME} in group staff"
    usermod -a -G staff ${USERNAME}
fi

echo "Saving user information"
# username uid admin
# echo ${USERNAME} $(id -u ${USERNAME}) ${ADMIN} > /home/${USERNAME}/.uinfo
printf "${USERNAME}\n$(id -u ${USERNAME})\n${ADMIN}" > /home/${USERNAME}/.uinfo

exit 0
