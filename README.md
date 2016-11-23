Dotty Drone Testing
===================
This repo contains the necessary infrastructure for testing Dotty using Drone.

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

Dotty Docker Image
------------------
This docker image is set up in order to run the tests for Dotty. It is
currently pushed to `felixmulder/dotty` on Docker hub. But this should in due
time be changed to a `lampepfl` organization.

To update the image, simply:

```
$ tar -zxvf ivy2.tar.gz
$ sudo su
# docker build -t felixmulder/dotty .
<some-tag-hash-here>
# docker push felixmulder/dotty:latest
# docker tag <some-tag-hash-here> felixmulder/dotty:0.1
# docker push felixmulder/dotty:0.1
```

Currently the cache is r/w by all users of the image - which should be defined
since the container is destroyed between tests. The ivy2 archive is a clean cache
from running compile on all subprojects in the Dotty repo. It is maintained using
`git lfs` which should be installed to handle updating of the archive.
