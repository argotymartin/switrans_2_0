FROM ubuntu:22.04

#RUN which bash file mkdir rm
RUN apt update -y && apt upgrade -y &&  \
    apt install -y curl git unzip openjdk-8-jdk wget clang cmake ninja-build pkg-config libgtk-3-dev \
    xz-utils zip libglu1-mesa iputils-ping vim

ARG USER=root
USER $USER
WORKDIR /home/$USER

RUN git clone -b 3.22.0 https://github.com/flutter/flutter.git

ENV PATH="/home/root/flutter/bin:${PATH}"
COPY /web /app/web

COPY pubspec.yaml /app/pubspec.yaml
WORKDIR /app

RUN flutter pub get

CMD ["tail", "-f", "/dev/null"]
