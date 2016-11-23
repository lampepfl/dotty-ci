#!/usr/bin/env bash

DRONE_VERSION="0.5"
NAME="drone"

function startDrone {
    docker run \
        --volume /var/lib/drone:/var/lib/drone \
        --env-file dronerc \
        --restart=always \
        --publish=80:8000 \
        --detach=true \
        --name=$NAME \
        drone/drone:$DRONE_VERSION
}

function stopDrone {
    docker stop drone
    docker rm drone
}

if [ "$1" == "start" ]; then
    echo "starting drone..."
    startDrone
elif [ "$1" == "stop" ]; then
    echo "stopping drone..."
    stopDrone
elif [ "$1" == "restart" ]; then
    echo "restarting drone..."
    stopDrone
    startDrone
fi
