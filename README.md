Drone Testing
===================

This repo contains the definition of the infrastructure used for dotty's CI,
based [Drone](https://drone.io/) >= 1.0.0.

Prerequisites
-------------
[Docker](https://docs.docker.com/engine/installation/) version 17.06 or higher and
[Docker Compose](https://docs.docker.com/compose/install/) must be installed.

Docker Compose is a tool for defining and running multi-container Docker applications.
To learn more about Compose refer to the [documentation](https://docs.docker.com/compose/).

Setting up Drone
----------------

We use a [multi-machine drone
setup](https://docs.drone.io/installation/github/multi-machine/) where
[lampsrv43](http://lampsrv43.epfl.ch/) acts as master (= drone-server) and
lampsrv9 and lampsrv26 as runners (= drone-agent).

The environment is defined by the [drone-server](drone/drone-server.yml) and
[drone-agent](drone/drone-agent.yml)
[docker-compose](https://docs.docker.com/compose/reference/overview/)
definition files.

### Starting / Restarting Drone ###

On the central 'master' drone server:

```bash
$ docker-compose --file /etc/drone/drone-server.yml up --force-recreate -d
```

On any drone agent:

```bash
$ docker-compose --file /etc/drone/drone-agent.yml up --force-recreate -d
```

* `--file` sets the path of the docker-compose definition file.
* `--force-recreate` recreates containers even if their configuration and image haven't changed.
* `-d` runs containers in the background and prints new container names.

A [Makefile](drone/Makefile) is provided for your convenience.

### Monitoring ###

Agents:
  * lamprv9: [CPU](http://tresormon.epfl.ch/munin/epfl.ch/lampsrv9.epfl.ch/cpu.html) [Memory](http://tresormon.epfl.ch/munin/epfl.ch/lampsrv9.epfl.ch/memory.html)
  * lampsrv26: [CPU](http://tresormon.epfl.ch/munin/epfl.ch/lampsrv26.epfl.ch/cpu.html) [Memory](http://tresormon.epfl.ch/munin/epfl.ch/lampsrv26.epfl.ch/memory.html)


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
$ drone secret add --repository=lampepfl/dotty --name=<name> --value=<value>
```

Dotty Docker Image
------------------
This docker image is set up in order to run the tests for Dotty. It is
currently pushed to [lampepfl/dotty](https://hub.docker.com/r/lampepfl/dotty/)
on Docker hub.

To build the image, simply:

```bash
$ cd dotty-docker
$ docker build --no-cache -t lampepfl/dotty:$(date +%F) .
$ docker login
$ docker push lampepfl/dotty:$(date +%F)
```

The new image should now appear in <https://hub.docker.com/r/lampepfl/dotty/tags/>.
The next step is to open a PR againts <https://github.com/lampepfl/dotty> to change the tag of
the docker image in [.drone.yml](https://github.com/lampepfl/dotty/blob/master/.drone.yml).
