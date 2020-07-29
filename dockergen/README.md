# Docker Gen Configuration
## Description
This directory includes our Docker Gen configuration.

## Installation
Firstly, install Docker Gen. A guide on this can be found [here](https://gitlab.com/-/snippets/1836688).

Secondly, copy `dockergen.conf` and `update-netns.sh.tmpl` to `/etc/netns-dockergen/`.

Lastly, start/restart the Docker Gen service via `systemctl restart netns-dockergen`.

## Notes
If you're using Pterodactyl, make sure to create variables `ANYCAST_ADDR` and `INTERNAL_IP`. The `ANYCAST_ADDR` should be set to the public IP address from the Anycast network associated with the container/game server (e.g. 92.118.149.4). The `INTERNAL_IP` variable should be set to the IPIP tunnel's IP (`internal_ip` in Compressor's configuration) for the specific container/game server (e.g. `172.20.0.2`). The internal IP should be a part of a private IP range (LAN). 

## Credits
* [Dreae](https://github.com/Dreae) - Created base configuration.
* [Christian Deacon](https://www.linkedin.com/in/christian-deacon-902042186/) - Modified configuration to suit GFL's needs.