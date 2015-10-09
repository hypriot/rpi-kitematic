FROM hypriot/rpi-node:0.12.0
MAINTAINER Stefan Scherer <stefan@hypriot.com>

RUN apt-get update
RUN apt-get install -y make build-essential libnotify-bin libgconf-2-4 libnss3
RUN apt-get install -y git
WORKDIR /
RUN git clone -b linux-support https://github.com/zedtux/kitematic
WORKDIR /kitematic
RUN npm install boom

# electron 0.29 or higher is available for ARM
RUN sed -i 's/"electron-version": "0.27.2",/"electron-version": "0.29.0",/' package.json
RUN sed -i 's/"electron-prebuilt": "^0.27.3",/"electron-prebuilt": "^0.29.0",/' package.json

# show some RPi images
RUN sed -i 's,https://kitematic.com/recommended.json,http://blog.hypriot.com/recommended.json,' src/utils/RegHubUtil.js

# enable web preview between containers
RUN sed -i 's/var port = value\[0\].HostPort;/var port = dockerPort; ip = container.NetworkSettings.IPAddress;/' src/utils/ContainerUtil.js

RUN npm install hoek
RUN npm install is-property
RUN make

RUN apt-get install -y libgtk2.0-0
RUN apt-get install -y libxtst6

CMD ["npm", "start"]
