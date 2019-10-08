#!/bin/bash

# configure users
echo "Configuring users"
echo ""

# user_array=$(`ls /home`)
for user in `ls /home`; do
  # check if user exists on system
  # id -u name
  if id "${user}" >/dev/null 2>&1; then
        echo "User ${user} exists"
        continue
  fi



  mapfile -t arr < /home/${user}/.uinfo
  echo "> ${arr[@]}"
  # TODO check that usernames match

  uid=${arr[1]}
  admin=${arr[2]}

  echo "  Creating user ${user} with uid ${uid}"
  useradd -m --uid ${uid} -g users ${user}

  if [ "${admin}" = True ] ; then
      echo "  Setting user ${user} in group staff"
      usermod -a -G staff ${user}
  fi

done

echo ""
echo "Running jupyterhub"
jupyterhub
exit 0
