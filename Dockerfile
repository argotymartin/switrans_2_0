FROM ubuntu:22.04

# Installing necessary dependencies
RUN apt update
RUN apt install -y curl git unzip openjdk-8-jdk wget

# Intalaciones para linux
RUN apt install -y clang cmake ninja-build pkg-config libgtk-3-dev

# Configuring the working directory and user to use
ARG USER=root
USER $USER
WORKDIR /home/$USER

# Download Flutter SDK estable
# RUN git clone https://github.com/flutter/flutter.git

# Downoload Flutter SDK Tag Version
RUN git clone -b 3.22.0 https://github.com/flutter/flutter.git

# Entornos Virtuales
ENV PATH $PATH:/home/$USER/flutter/bin

WORKDIR /app

ADD pubspec.yaml ./

RUN flutter pub get

# Set base command (use ENTRYPOINT)
#ENTRYPOINT ["flutter", "analyze"]