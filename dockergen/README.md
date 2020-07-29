# Docker Gen Configuration
## Description
This directory includes our Docker Gen configuration.

## Installation
Firstly, install Docker Gen. A guide on this can be found [here](https://gitlab.com/-/snippets/1836688).

Secondly, copy `dockergen.conf` and `update-netns.sh.tmpl` to `/etc/netns-dockergen/`.

Lastly, start/restart the Docker Gen service via `systemctl restart netns-dockergen`.

## Credits
* [Dreae](https://github.com/Dreae) - Created base configuration.
* [Christian Deacon](https://www.linkedin.com/in/christian-deacon-902042186/) - Modified configuration to suit GFL's needs.