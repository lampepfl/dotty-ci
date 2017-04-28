# Use alpine as base for Docker image
FROM alpine:3.5

# Add necessary packages to image:
RUN apk add --update git && \
    apk add curl && \
    apk add bash && \
    apk add openjdk8 && \
    apk add openjdk8-doc && \
    apk add expect

# Set sbt and java env vars
ENV SBT_VERSION 0.13.15
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin
ENV PATH ${PATH}:/usr/lib/jvm/java-1.8-openjdk/bin

# Install sbt
RUN curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built

WORKDIR /var/cache/drone

# Clone the modified standard library for testing, then `ln` it via the .drone.yml file
RUN git clone --depth 1 -b dotty-library https://github.com/DarkDimius/scala.git scala-scala

# Add ivy2 cache
RUN git clone --recursive --depth 1 https://github.com/lampepfl/dotty.git dotty
RUN bash -c 'cd dotty; sbt ";compile ;test:compile"'
RUN rm -rf dotty
RUN mv ~/.ivy2 /var/cache/drone/ivy2

# Make cache rw by all users (drone adds user 'drone', doesn't exist yet)
RUN chmod -R 0777 /var/cache/drone/ivy2
