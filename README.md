Drone Testing
===================
This repo contains the necessary infrastructure for testing using Drone.

Restarting Drone
----------------
First kill the agent:
```
$ ssh drone@lampsrv9.epfl.ch # this is the agent
$ docker kill drone-agent && docker rm drone-agent
```

Then restart the drone server:
```
$ ssh drone@lampsrv43.epfl.ch # this is master
$ ./drone.sh restart
```

Then start the agent again:
```
$ ssh drone@lampsrv9.epfl.ch
$ ./drone-agent.sh
$ docker logs drone-agent
```

The last command should tell you that it connected to its master, now all
should be well again in the world.

Setting up Drone
----------------

### Broker Installation ###
```
docker pull drone/drone:0.5
```

then use the script from [server](drone/server/drone.sh) to start drone with:

```
./drone.sh start
```

To the script also accepts the arguments `stop` and `restart`.

### Agent Installation ###
```
docker pull drone/drone:0.5
```

then use the script from [agent](drone/agent/drone-agent.sh) to start drone
with:

```
./drone-agent.sh
```

Depending on which server the agent is running on, it should have a different
setting for the amount of jobs that it can accept. The main server
`lampsrv9.epfl.ch` can currently accept 20 jobs at once.

### Repo Installation ###
The Dotty repo contains a
[.drone.yml](https://github.com/lampepfl/dotty/blob/master/.drone.yml)-file
that contains the necessary settings for drone to run the CI.

The repo is then activated via the UI on http://dotty-ci.epfl.ch or from the
commandline using:

```
$ drone repo add lampepfl/dotty
```

Installation instructions for the
[drone](http://readme.drone.io/0.5/install/cli/) command

Dotty Docker Image
------------------
This docker image is set up in order to run the tests for Dotty. It is
currently pushed to [lampepfl/dotty](https://hub.docker.com/r/lampepfl/dotty/)
on Docker hub.

To build the image, simply:

```
$ cd docker
$ sudo su
# docker build --no-cache -t lampepfl/dotty .
<some-tag-hash-here>
# docker tag <some-tag-hash-here> lampepfl/dotty:01-01-2020
# docker push lampepfl/dotty:01-01-2020
```

Currently the cache is r/w by all users of the image - which should be defined
since the container is destroyed between tests. The ivy2 archive is a clean cache
from running compile on all subprojects in the Dotty repo. It is maintained using
`git lfs` which should be installed to handle updating of the archive.

### Creating the docker image on macOS ###
Installing docker is a bit more involved, easiest way is to:

```
$ brew install docker docker-machine
```

Then to start the docker machine VM using virtualbox:

```
$ docker-machine create --driver virtualbox dev
$ eval $(docker-machine env dev)
```

Now you can run docker commands from [above](#dotty-docker-image) ignoring the
call to `su`.
