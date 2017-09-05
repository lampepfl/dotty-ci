Drone Testing
===================

This repo contains the necessary infrastructure for testing using Drone.

Prerequisites
-------------
[Docker](https://docs.docker.com/engine/installation/) version 17.06 or higher and
[Docker Compose](https://docs.docker.com/compose/install/) must be installed.

Docker Compose is a tool for defining and running multi-container Docker applications.
To learn more about Compose refer to the [documentation](https://docs.docker.com/compose/).

Setting up Drone
----------------

The [docker-compose.yml](drone/docker-compose.yml) file defines the docker configuration for our Drone application. The
[docker-compose](https://docs.docker.com/compose/reference/overview/) CLI lets you manage your
application life-cycle.

### Starting / Restarting Drone ###

```bash
$ ssh drone@lampsrv9.epfl.ch
$ cd dotty-drone/drone/
$ docker-compose up --force-recreate -d
```

`force-recreate` recreates containers even if their configuration and image haven't changed.
`d` runs containers in the background and prints new container names.

### Monitoring ###
http://tresormon.epfl.ch/munin/epfl.ch/lampsrv9.epfl.ch/cpu.html

### Repo Installation ###
The Dotty repo contains a
[.drone.yml](https://github.com/lampepfl/dotty/blob/master/.drone.yml) file
that contains the necessary settings for drone to run the CI.

The repo is then activated via the UI on http://dotty-ci.epfl.ch or from the
commandline using:

```bash
$ drone repo add lampepfl/dotty
```

Installation instructions for the
[drone](http://readme.drone.io/usage/getting-started-cli/) command.

### Secrets Management ###
Drone provides the ability to store sensitive information such as passwords.
Secrets are loaded as environment variables. For example the secret named `sonatype_user` can be
accessed via `"$SONATYPE_USER"`. Use lower case to name your secrets and upper case to access their
value.

You can add secrets to a build via the UI on http://dotty-ci.epfl.ch or
from the command line using:

```bash
$ drone secert add --repository=lampepfl/dotty --name=<name> --value=<value>
```

Dotty Docker Image
------------------
This docker image is set up in order to run the tests for Dotty. It is
currently pushed to [lampepfl/dotty](https://hub.docker.com/r/lampepfl/dotty/)
on Docker hub.

To build the image, simply:

```bash
$ cd dotty-docker
$ sudo su
$ docker build --no-cache -t lampepfl/dotty .
<some-tag-hash-here>
$ docker tag <some-tag-hash-here> lampepfl/dotty:$(date +%F)
$ docker login
$ docker push lampepfl/dotty:$(date +%F)
```

The new image should now appear in <https://hub.docker.com/r/lampepfl/dotty/tags/>.
The next step is to open a PR againts <https://github.com/lampepfl/dotty> to change the tag of
the docker image in [.drone.yml](https://github.com/lampepfl/dotty/blob/master/.drone.yml).
