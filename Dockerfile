FROM hypriot/rpi-node:0.12.0
MAINTAINER Stefan Scherer <stefan@hypriot.com>

RUN apt-get update
RUN apt-get install -y make build-essential libnotify-bin libgconf-2-4 libnss3
RUN apt-get install -y git
WORKDIR /
RUN git clone -b linux-support https://github.com/zedtux/kitematic
WORKDIR /kitematic
RUN npm install boom
RUN sed -i 's/"electron-version": "0.27.2",/"electron-version": "0.29.0",/' package.json
RUN sed -i 's/"electron-prebuilt": "^0.27.3",/"electron-prebuilt": "^0.29.0",/' package.json
RUN make

RUN apt-get install -y libgtk2.0-0
RUN apt-get install -y libxtst6

CMD ["npm", "start"]
