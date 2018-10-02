# syntax = tonistiigi/dockerfile:secrets20180808
FROM ubuntu:18.04

# The default locale is "POSIX" which is just ASCII.
ENV LANG C.UTF-8

# Add packages to image, set default JDK version
RUN apt-get update && \
    apt-get upgrade -y && \
    # Enable pre-release openjdk 11, remove the next line once openjdk 11 has been released and Ubuntu updates its package.
    apt-get install -y software-properties-common && add-apt-repository ppa:openjdk-r/ppa && \
    apt-get install -y bash curl docker.io git ssh htop openjdk-8-jdk-headless openjdk-11-jdk-headless \
                       nano vim-tiny zile && \
    update-java-alternatives --set java-1.8.0-openjdk-amd64

# Set sbt and java env vars
ENV SBT_VERSION 1.2.3
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin
ENV PATH ${PATH}:/usr/lib/jvm/java-1.8-openjdk/bin

# Install sbt
RUN curl -sL "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built

WORKDIR /var/cache/drone

# Add ivy2 cache, this requires "sshkey" to be present in the current directory and be a key that can clone the repo
RUN --mount=type=secret,id=sshkey,dst=/root/.ssh/id_rsa GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=accept-new" git clone --depth=1 git@github.com:lampepfl-courses/moocs.git

# Used by script/ci-sbt to determine how to run sbt
ENV DRONE 1

RUN (cd moocs && \
     ./script/ci-sbt ";test:update" && ./script/ci-hook progfun2 \
     echo "moocs: $(git rev-parse HEAD)" >> /root/.versions) && \
    rm -rf moocs && \
    # Make cache rw by all users (drone adds user 'drone', doesn't exist yet)
    chmod -R 0777 /var/cache/drone/ivy2
