#!/bin/bash

set -e

docker build -t clook/imagefactory imagefactory/

mkdir -p ./build
\cp -af fedora/* ./launch-imagefactory.sh ./build
chmod +x ./build/launch-imagefactory.sh

modules_path=/lib/modules/$(uname -r)

docker run -it --rm -p 5900:5900 --privileged -v $(pwd)/build:/build -v $modules_path:$modules_path:ro clook/imagefactory /build/launch-imagefactory.sh

docker load ./build/rootfs.tar.xz

docker tag fedora5 clook/fedoracore-i386:5
docker build -t clook/fedoracore-i386:5 build/
docker_uuid=$(docker load -i ./build/fedoracore5_rootfs.tar.xz)
