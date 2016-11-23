#!/usr/bin/env bash

docker run \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --env-file dronerc \
    --restart=always \
    --detach=true \
    --name=drone-agent \
    drone/drone:0.5 agent
