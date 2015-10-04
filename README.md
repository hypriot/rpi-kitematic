# hypriot/rpi-kitematic

Put Kitematic into a Docker Container Image and run it locally on your Raspberry Pi.

## Build the Docker image

Login to your Raspberry Pi and clone this repo and run the build script to build the Docker Image.

```
./build.sh
```

The Docker Image is about 800 MByte because all the build tools are inside it.
But at least you do not have to pollute your Raspberry Pi with all development tools
to build Kitematic from source.

## Connecting to your Mac

On your Mac you need `socat` and X11 installed.
First start `socat` with the following command:

```
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```

Then start X11.

Now switch to your Raspberry Pi and run the `hypriot/rpi-kitematic` Image with
the IP address of your Mac:

```
docker run --privileged -v /var/run/docker.sock:/var/run/docker.sock -e DISPLAY=192.168.1.xx:0.0 hypriot/rpi-kitematic
```

You have to wait some minutes until Kitematic shows up on your Mac.

## Running on your Raspberry 7" touch screen display

If you are one of the lucky guys with the new Raspberry 7" touch screen display, 
you may try the following steps:
Login to your Raspberry Pi and install X11:

```
curl -sSL https://github.com/hypriot/x11-on-HypriotOS/raw/master/install-x11-basics.sh | bash
reboot
```

First you have to enable the X11 server to listen on a TCP socket (port 6000). Just insert the line `xserver-allow-tcp=true` in file `/etc/lightdm/lightdm.conf` and reboot your Pi:
```
cat /etc/lightdm/lightdm.conf
[SeatDefaults]
autologin-user=pi
autologin-user-timeout=0
xserver-allow-tcp=true
```

Second you have to enable X11 server to accept external TCP access from inside of a Docker container. 
This is a network connection coming from another TCP/IP address because the container is running
in it's own network name space:

```
DISPLAY=:0.0 xhost +
```
If it works you see a message like
```
access control disabled, clients can connect from any host
```

Then run the Kitematic container with:
```
docker run --privileged -v /var/run/docker.sock:/var/run/docker.sock -e DISPLAY=172.17.42.1:0.0 hypriot/rpi-kitematic
```

Hope that works.

