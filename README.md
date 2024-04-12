
> ⚠️ The following repository is no longer maintained. ⚠️
> 
> Pull Request https://github.com/scala/scala3/pull/19697 added all the necessary material related to the CI to the `scala/scala3` repository.


# Drone Testing

This repo contains the definition of the infrastructure used for dotty's CI,
based [Drone](https://drone.io/) >= 1.0.0.

## Prerequisites
[Docker](https://docs.docker.com/engine/installation/) version 17.06 or higher and

## GH Actions Self-Hosted Runners Setup
We host [self-hosted GH Actions Runners](https://help.github.com/en/actions/hosting-your-own-runners) on EPFL machines, lampsrv9 and lampsrv26. Each machine hosts 5 runners currently. They reside under `/home/drone/github-actions-runners` directory of the two servers, each has a separate subdirectory of the format `runner-*`.

Each runner is installed as a service at the server. Starting/restarting is done via `runner-*/svc.sh` script, e.g. `sudo ./svc.sh start` or `sudo ./svc.sh restart`. This is a standard script that comes with GH Actions Self-Hosted Runner software.

Otherwise the setup is standard for GH Actions Self-Hosted Runner. For more information on how to perform various actions with runners, see [runners documentation](https://help.github.com/en/actions/hosting-your-own-runners).

## Monitoring

Agents:
  * lamprv9: [CPU](http://tresormon.epfl.ch/munin/epfl.ch/lampsrv9.epfl.ch/cpu.html) [Memory](http://tresormon.epfl.ch/munin/epfl.ch/lampsrv9.epfl.ch/memory.html)
  * lampsrv26: [CPU](http://tresormon.epfl.ch/munin/epfl.ch/lampsrv26.epfl.ch/cpu.html) [Memory](http://tresormon.epfl.ch/munin/epfl.ch/lampsrv26.epfl.ch/memory.html)

## Dotty Docker Image
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
the docker image in [ci.yaml](https://github.com/lampepfl/dotty/blob/master/.github/workflows/ci.yaml).
