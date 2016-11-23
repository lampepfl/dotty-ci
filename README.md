Dotty Docker Image
==================
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
