FROM ubuntu:22.04

#RUN which bash file mkdir rm
RUN apt update -y && apt upgrade -y &&  \
    apt install -y curl git unzip openjdk-8-jdk wget clang cmake ninja-build pkg-config libgtk-3-dev \
    xz-utils zip libglu1-mesa iputils-ping

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt install -y nodejs

ARG USER=root
USER $USER
WORKDIR /home/$USER

RUN git clone -b 3.22.0 https://github.com/flutter/flutter.git
#COPY flutter/ flutter/

ENV PATH="/home/root/flutter/bin:${PATH}"
COPY /web /app/web

WORKDIR /app/web
RUN npm install


WORKDIR /app

#RUN flutter pub get

#WORKDIR /app/web

CMD ["tail", "-f", "/dev/null"]
#CMD ["node", "web/app.js"]

