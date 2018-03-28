# Use alpine as base for Docker image
FROM alpine:3.7

# Add necessary packages to image:
RUN apk add --update git && \
    apk add curl && \
    apk add bash && \
    apk add openjdk8 && \
    apk add openjdk8-doc

# Set sbt and java env vars
ENV SBT_VERSION 1.1.2
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin
ENV PATH ${PATH}:/usr/lib/jvm/java-1.8-openjdk/bin

# Install sbt
RUN curl -sL "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built

WORKDIR /var/cache/drone

# Add ivy2 cache
RUN git clone -b master --recursive https://github.com/lampepfl/dotty.git dotty
RUN bash -c 'cd dotty; sbt ";test:update ;dotty-bootstrapped/test:update ;sbt-dotty/scripted:update"'
RUN rm -rf dotty
RUN mv ~/.ivy2 /var/cache/drone/ivy2

# Make cache rw by all users (drone adds user 'drone', doesn't exist yet)
RUN chmod -R 0777 /var/cache/drone/ivy2
