#!/bin/bash

echo "Listening for route changes indicating attacks..."

# Initialize starting variables.
timestamps=()
i=1

# Make an infinite loop (but we sleep every 60 seconds or so to avoid high CPU consumption).
while [ "$i" -ne 0 ]; do
    # Verbose.
    echo "Scanning..."

    # Get contents of BGP routes from BIRD.
    contents=$(birdc show route)

    # Loop through each new line.
    while IFS= read -r; do
        # Try to find a match on the IP with a /32 prefix since GTT offloads are only for single IPs (/32) at the moment.
        ip=$(echo "$REPLY" | grep -P -o "([0-9]{1,3}\.)+([0-9]{1,3})(?=/32)")

        # Check size of $ip variable (if it's above 1, it matched).
        if [[ ${#ip} > 1 ]]; then
            # Get timestamp.
            ts=$(echo "$REPLY" | grep -P -o "[0-9]{2}:[0-9]{2}")

            echo "$ip => $ts"

            # Check if timestamp is a part of $timestamps array.
            if [[ ! " ${timestamps[@]} " =~ " $ip-$ts " ]]; then
                # Logging.
                echo "Detected attack against $ip with $ts as the timestamp. Adding timestamp to array and going forward."

                # Add timestamp to timestamps array.
                timestamps+=("$ip-$ts")

                # Construct cURL request.
                msg="<@%26xxxxxxxxxxxxx> Attack detected on $ip. GTT offload is enabled on this IP for an hour on GSK's behalf."

                curl -s -d "content=$msg" -X POST https://discordapp.com/api/webhooks/xxxxxxxxxxxx/yyyyyyyyyyyyyyyyyyyyyyyyyy
            fi
        fi
    done <<< "$contents"

    sleep 60
done