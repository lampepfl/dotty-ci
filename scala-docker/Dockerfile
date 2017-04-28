# Use alpine as base for Docker image
FROM alpine:3.4

# Add necessary packages to image:
RUN apk add --update git && \
    apk add curl && \
    apk add bash && \
    apk add openjdk8 && \
    apk add openjdk8-doc && \
    apk add apache-ant

# Set java env vars
ENV PATH ${PATH}:/usr/lib/jvm/java-1.8-openjdk/bin
