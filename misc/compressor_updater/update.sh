#!/bin/bash

# Define all the PoP servers.
declare -a PoPs=(
        #"user@host"
        #"me@127.0.0.1"
)

# Loop through each PoP.
for i in "${PoPs[@]}"
do
        if [ "$1" = "UPDATE" ]; then
                echo "Updating $i..."

                # Copy compressor config to remote PoP.
                scp compressor.conf $i:/tmp/compressor.conf.temp

                # Move the file to appropriate location.
                ssh -t $i 'sudo mv /tmp/compressor.conf.temp /etc/compressor/compressor.conf'

                # Clear the RAM cache before restarting so there's a less chance it'll cause Compressor to die.
                ssh -t $i 'sudo su -c "sync; echo 3 > /proc/sys/vm/drop_caches"'

                # Restart Compressor.
                ssh -t $i 'sudo systemctl restart compressor --no-pager'

                # Grab the status.
                ssh -t $i 'sudo systemctl status compressor --no-pager'

                echo "Done updating..."

        elif [ "$1" = "UPDATENORESTART" ]; then
                echo "Updating $i without Compressor restart..."

                # Copy compressor config to remote PoP.
                scp compressor.conf $i:/tmp/compressor.conf.temp

                # Move the file to appropriate location.
                ssh -t $i 'sudo mv /tmp/compressor.conf.temp /etc/compressor/compressor.conf'

                echo "Done updating..."
        elif [ "$1" = "CLEARCACHE" ]; then
                echo "Clearing $i RAM cache..."

                # Clear the RAM cache.
                ssh -t $i 'sudo su -c "sync; echo 3 > /proc/sys/vm/drop_caches"'

                # Done clearing cache.

        elif [ "$1" = "STATUS" ]; then
                echo "Status for $i"

                # Grab the status.
                ssh -t $i 'sudo systemctl status compressor --no-pager'
        elif [ "$1" = "RESTART" ]; then
                echo "Restarting compressor for $i"

                # Clear the RAM cache so there's a less chance of Compressor dying.
                ssh -t $i 'sudo su -c "sync; echo 3 > /proc/sys/vm/drop_caches"'

                # Restart Compressor.
                ssh -t $i 'sudo systemctl restart compressor --no-pager'

                # Grab the status.
                ssh -t $i 'sudo systemctl status compressor --no-pager'

                echo "Done restarting..."

        elif [ "$1" = "CUSTOM" ]; then
                echo "Running custom command"

                # Running custom command.
                ssh -t $i $2
        fi
done
