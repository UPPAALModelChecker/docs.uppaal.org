---
title: Docker
weight: 50
---

Docker provides a convenient containerization, allowing to run UPPAAL under an environment different from the main operating system.

The instructions below show how to setup UPPAAL engine inside latest Ubuntu container.

1. Install Docker desktop from [docker.com](//www.docker.com). Most Linux distributions already have Docker in their repositories, so consult your Linux distribution on how to install it. For example, on Debian and Ubuntu:
```sh
sudo apt install docker.io
```

2. Download and extract/install UPPAAL for Linux.

3. Inside UPPAAL installation create `uppaal-X.Y.Z/res/Dockerfile` file with the following content:
```docker
FROM ubuntu:latest

RUN useradd -ms /bin/bash uppaal
RUN apt-get -qq update && apt-get -qq upgrade
USER uppaal
ENV USER=uppaal
WORKDIR /home/uppaal
ADD . uppaal
ENV PATH="/home/uppaal/uppaal/bin:$PATH"
ARG KEY=""
ARG LEASE="1"
RUN verifyta.sh --key ${KEY} --lease ${LEASE}
RUN verifyta.sh --version

EXPOSE 2350
CMD /home/uppaal/uppaal/bin/socketserver.sh /home/uppaal/uppaal/bin/server.sh
```

4. On a terminal, change the directory to UPPAAL installation and create a docker image by running the following command:
```sh
cd uppaal-X.Y.Z
docker image build --build-arg KEY=$UPPAAL_LICENSE_KEY --tag uppaal-X.Y.Z -f res/Dockerfile .
```
where `$UPPAAL_LICENSE_KEY` is your UPPAAL license key from [uppaal.veriaal.dk](https://uppaal.veriaal.dk).

4. Start the docker container in a detached state with port 2350 mapped to 2350:
```sh
docker run --rm -d -p 2350:2350 uppaal-X.Y.Z
```
where:
- `--rm` tells docker to delete the container (not the image) when the container is stopped.
- `-d` dettaches the docker process from the current terminal.
- `-p 2350:2350` maps the container's port 2350 onto the host's port 2350.

5. Start Uppaal GUI (it will try connecting to port 2350 by default)
   by double-clicking on `uppaal.exe` or `uppaal.jar`, or on command line:
```sh
java -jar uppaal.jar
```

Select the remote engine: `Edit` > `Engine` > `Remote`, then reload the connection: `View` > `Reload`.

The engine version is printed in `Verifier` tab, `Status` section at the bottom.

If the docker is running on a different than current machine, or the port number is different, then the `Remote` engine can be configured accordingly in the `Edit` > `Engines` dialog.

UPPAAL engine exits (and releases the resources) when the UPPAAL GUI is closed or the engine connection is closed/reloaded (`View` > `Reload`), but the Docker container remains running in the background and ready for other connections.

## Diagnostics

If docker commands give permission errors on Linux, you may need to add your account to `docker` group to be able to create docker images, so try the following:
```sh
sudo adduser $USER docker
```
then logout-login or reboot for the account changes to take effect.


If UPPAAL cannot connect to the remote engine, or docker container does not work, then start an interactive shell to investigate:
```sh
docker run --rm -it --entrypoint /bin/bash uppaal-5.0.0
```

For example:
- Normally the newer LIBC versions are backward compatible with older versions, so older UPPAAL should be running fine on newer Linux releases, but if UPPAAL is newer than the Linux release, then the older library versions might be incompatible with what UPPAAL has been compiled with (e.g. running `verifyta` crashes right away).
- Check UPPAAL version information:
```sh
verifyta --version
```
- Check standard C library version used by UPPAAL:
```sh
verifyta --stdc-version
```
- Check the host's C library version:
```sh
dpkg -l libc6
dpkg -S libc.so.6
/usr/lib/x86_64-linux-gnu/libc.so.6 --version
```
- If `verifyta --version` crashes right away, then try using the wrapper script `verifyta.sh` which forces to use the libraries shipped with UPPAAL instead of the host's libraries.

To stop the container, first find its identifier and then issue `stop` or `kill` command, for example:
```sh
docker ps

CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                    NAMES
345c8263c4a8        uppaal-5.0.0        "./socketserver"    6 seconds ago       Up 5 seconds        0.0.0.0:2350->2350/tcp   modest_kare
```
```sh
docker stop modest_kare
```

Examine any remaining containers:
```sh
docker ps -a
```

The remaining stopped containers can be removed by:
```sh
docker rm modest_kare
```
(unnecessary when `--rm` argument is used to start the container).

## Uninstall
Remove the docker image:
```sh
docker rmi uppaal-X.Y.Z
```
Check the installed images:
```sh
docker images
```
