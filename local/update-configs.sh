#!/usr/bin/env bash

PREFIX="$(basename $(dirname $(dirname $(readlink -f $0))))"
C="${PREFIX}_local"

# check if config volumes were initialized
docker inspect ${PREFIX}_bind9-config > /dev/null
if [ $? -eq 1 ]; then
    echo "please initialize bind9 container to populate config volume first"
    exit 1
fi

docker inspect ${PREFIX}_pihole-config > /dev/null
if [ $? -eq 1 ]; then
    echo "please initialize pihole container to populate config volume first"
    exit 1
fi

docker run \
    -v ${PREFIX}_bind9-config:/bind9-config \
    -v ${PREFIX}_bind9-zones:/bind9-zones \
    -v ${PREFIX}_pihole-config:/pihole-config \
    -v ${PREFIX}_pihole-dnsmasq:/pihole-dnsmasq \
    --name ${C} busybox true

docker cp ./bind9-config/. ${C}:/bind9-config/
docker cp ./bind9-zones/. ${C}:/bind9-zones/
docker cp ./pihole-config/. ${C}:/pihole-config/
docker cp ./pihole-dnsmasq/. ${C}:/pihole-dnsmasq/

docker rm -f ${C} > /dev/null 
