#!/bin/bash
sleep 5

# Allow for the creation of coredumps
ulimit -c unlimited

cd /home/container

# Update or validate server.
if [ "$SERVERUPDATE" = "1" ]; then
        ./steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container +app_update 4020 -beta x86-64 +quit
elif [ "$SERVERUPDATE" = "2" ]; then
        ./steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container +app_update 4020 validate -beta x86-64 +quit
fi

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}

if [ $? -ne 0 ]; then
    echo "PTDL_CONTAINER_ERR: There was an error while attempting to run the start command."
    exit 1
fi
