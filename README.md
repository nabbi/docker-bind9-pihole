# Docker :: Pi-Hole and Bind9

Docker Compose integrating [Pi-Hole](https://pi-hole.net/), [ISC Bind9](https://www.isc.org/bind/), and [BIND ad blocker (forked from Trellmor)](https://github.com/nabbi/bind-adblock)

usually, you do not need both RPZ and PiHole filtering, this deployment allows for migration strategies or other complex deployments.

## Overview

The Pi-Hole container forwards to Bind9 container which performs recursions, authoritative, forwarding, rpz, etc.

## Usage

### Pi-Hole WebUI Password

Define your default password for Pi-Hole in file 'secret_webpw.txt'


### Local Configurations

The containers need to be started to populate the volumes with initial system configurations.

```
docker-compose pull
docker-compose up -d
```

Modify the local configurations tailored to your deployment, then run the script to copy those files into the volumes.
This creates a temporary container to interact with the docker volumes.

```
cd local
./update-configs.sh
```


Restart the containers to force loading with your updated configurations.

```
docker-compose restart
```

### Cron

An example crontab is provided to be installed on the docker host, it starts the adblock container which writes its updated zone file into the docker volume, then restarts the bind9 container.


## More info
* [Pi-Hole Docker (github)](https://github.com/pi-hole/docker-pi-hole/)
* [Pi-Hole Docker (hub)](https://hub.docker.com/r/pihole/pihole)
* [Bind9 Docker (github)](https://gitlab.isc.org/isc-projects/bind9-docker)
* [Bind9 Docker (hub)](https://hub.docker.com/r/internetsystemsconsortium/bind9)
* [Bind AdBlock RPZ](https://github.com/Trellmor/bind-adblock)
