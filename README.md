# hypriot/rpi-kitematic

Put Kitematic into a Docker Container Image and run it locally on your Raspberry Pi.


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

