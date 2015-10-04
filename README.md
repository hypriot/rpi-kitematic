# hypriot/rpi-kitematic

Put Kitematic into a Docker Container Image and run it locally on your Raspberry Pi.

## Build the Docker image

Login to your Raspberry Pi and clone this repo and run the build script to buidl the Docker image.

```
./build.sh
```

The container image is about 800 MByte because all the build tools are inside it. But at least you do not have to pollute your Raspberry Pi with all development tools to build Kitematic from source.

## Connecting to your Mac

On your Mac you need `socat` and X11 installed.
First start `socat` with following command:

```
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```

Then start X11.

Then switch to your Raspberry Pi and run the rpi-kitematic Image with the IP address of your Mac:

```
docker run --privileged -v /var/run/docker.sock:/var/run/docker.sock -e DISPLAY=192.168.1.xx:0.0 hypriot/rpi-kitematic
```

You have to wait some minutes until Kitematic shows on your Mac.

## Running on your Raspberry Pi 7" display

If your are one of the lucky with the new 7" display you may try the following steps (I haven't done it myself):
Login to your Raspberry Pi and install X11:

``
curl -sSL https://github.com/hypriot/x11-on-HypriotOS/raw/master/install-x11-basics.sh | bash
reboot
```

Then run the Kitematic container with:

```
docker run --privileged -v /var/run/docker.sock:/var/run/docker.sock -e DISPLAY=172.17.42.1:0.0 hypriot/rpi-kitematic
```

Hope that works.

