Using this image with pterodactyl is easy:

1) Swap out the default container image for your GMOD server. You can build the image yourself or you can use quay.io/xytime/gmod64
2) Add 64-Bit Linux versions of any binary modules you're using to lua/bin.
3) Change the binary invoked by the startup line from srcds_run to srcds_run_x64
