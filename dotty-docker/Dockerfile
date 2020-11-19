FROM ubuntu:20.04

# The default locale is "POSIX" which is just ASCII.
ENV LANG C.UTF-8
env DEBIAN_FRONTEND noninteractive
env TZ Europe/Zurich

# Add packages to image, set default JDK version
RUN apt-get update && \
    apt-get upgrade -y && \
    # Use a PPA to get Java 15
    apt-get install -y software-properties-common && add-apt-repository ppa:openjdk-r/ppa && \
    apt-get install -y bash curl git ssh htop openjdk-8-jdk-headless openjdk-15-jdk-headless \
                       nano vim-tiny zile nodejs && \
    update-java-alternatives --set java-1.8.0-openjdk-amd64


# Install sbt
ENV SBT_HOME /usr/local/sbt
ENV PATH ${SBT_HOME}/bin:${PATH}
ENV SBT_VERSION 1.4.3
RUN curl -sL "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local
