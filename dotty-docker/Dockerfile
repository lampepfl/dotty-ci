FROM ubuntu:18.04

# The default locale is "POSIX" which is just ASCII.
ENV LANG C.UTF-8

# Add packages to image, set default JDK version
RUN apt-get update && \
    apt-get upgrade -y && \
    # Enable pre-release openjdk 11, remove the next line once openjdk 11 has been released and Ubuntu updates its package.
    apt-get install -y software-properties-common && add-apt-repository ppa:openjdk-r/ppa && \
    apt-get install -y bash curl git ssh htop openjdk-8-jdk-headless openjdk-11-jdk-headless nano vim-tiny zile nodejs && \
    update-java-alternatives --set java-1.8.0-openjdk-amd64

# Set sbt env variables
ENV SBT_VERSION 1.2.1
ENV SBT_HOME /usr/local/sbt
ENV PATH ${SBT_HOME}/bin:${PATH}

# Install sbt
RUN curl -sL "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
    echo "sbt: $SBT_VERSION" >> /root/.versions

WORKDIR /var/cache/drone

# Add ivy2 cache
RUN git clone -b master --recursive https://github.com/lampepfl/dotty.git && \
    (cd dotty && \
     sbt ";test:update ;dotty-bootstrapped/test:update ;sbt-dotty/scripted:update" && \
     echo "dotty: $(git rev-parse HEAD)" >> /root/.versions) && \
    rm -rf dotty && \
    mv ~/.ivy2 /var/cache/drone/ivy2 && \
    # Make cache rw by all users (drone adds user 'drone', doesn't exist yet)
    chmod -R 0777 /var/cache/drone/ivy2
