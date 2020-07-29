# GFL Source Engine V3
## Description
A Docker image GFL is using for its servers hosted on its Anycast network.

## Notes
If using Pterodactyl, make sure to add a variable with the name `SERVERUPDATE`. If set to `1` or `2`, the IPIP tunnel will not attach allowing the server to bind to the Docker veth interface and all inbound traffic would go into the machine directly instead of through the tunnel (Anycast network).

If set to `1`, the server will update. If set to `2`, the server will update and also validate its installation.

You may also set a `MOUNT_DEST` which can be used after changes performed in [this](https://gflclan.com/forums/topic/48643-pterodactyl-mount-multiple-volumes-to-container/) thread.

## Building
You may build this image executing the following command as root (or using `sudo`):

```
docker build -t gflsev3:latest .
```