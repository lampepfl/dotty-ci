FROM ubuntu:18.04

# The default locale is "POSIX" which is just ASCII.
ENV LANG C.UTF-8

# Add packages to image, set default JDK version
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y bash curl git ssh htop openjdk-8-jdk-headless openjdk-11-jdk-headless \
                       nano vim-tiny zile nodejs && \
    update-java-alternatives --set java-1.8.0-openjdk-amd64

# Set sbt env vars
ENV SBT_VERSION 1.2.7
ENV SBT_HOME /usr/local/sbt
ENV PATH ${SBT_HOME}/bin:${PATH}

# Install sbt
RUN curl -sL "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
    echo "sbt: $SBT_VERSION" >> /root/.versions

# Setup artifactory proxy used to cache requests to maven central
ADD ./repositories /root/.sbt/


# Add an initial local cache
RUN git clone -b master --recursive https://github.com/lampepfl/dotty.git && \
    (cd dotty && \
     sbt ";test:update ;dotty-bootstrapped/test:update ;sbt-dotty/scripted:update ;community-build/updateCommunityBuild" && \
     echo "dotty: $(git rev-parse HEAD)" >> /root/.versions) && \
    rm -rf dotty && \
    # Remove all locally published artifacts
    rm -rf /root/.ivy2/local
