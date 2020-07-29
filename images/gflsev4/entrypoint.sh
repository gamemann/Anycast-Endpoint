#!/bin/bash
sleep 3

# Set Ulimit
ulimit -c unlimited
echo "Set: ulimit -c unlimited"

# Set the default working directory.
workingDir=/home/container

# Check if the MOUNT_DEST variable exists. If so, set it to that.
if [ ! -z "$MOUNT_DEST" ]; then
        workingDir=$MOUNT_DEST
fi

echo "Changing working directory to ${workingDir}"

cd $workingDir

# Update or validate server.
if [ "$SERVERUPDATE" = "1" ]; then
        ./steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container +app_update ${CSRCDS_APPID} +quit
elif [ "$SERVERUPDATE" = "2" ]; then
        ./steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container +app_update ${CSRCDS_APPID} validate +quit
fi

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":${workingDir}$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}

if [ $? -ne 0 ]; then
    echo "PTDL_CONTAINER_ERR: There was an error while attempting to run the start command."
    exit 1
fi