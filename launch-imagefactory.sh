#!/bin/bash

set -e

sed -i 's/\["Fedora", null, null],/["Fedora", null, null], ["FedoraCore", null, null],/' /usr/lib/python2.7/site-packages/imagefactory_plugins/TinMan/TinMan.info
sed -i "s/'type':'vnc'/'type':'vnc', 'listen': '0.0.0.0'/" /usr/lib/python2.7/site-packages/oz/Guest.py
libvirtd & virtlogd &

# Build image
cd /build
imagefactory --debug base_image --file-parameter install_script fedora-docker-base.ks fedoracore.tdl --parameter offline_icicle true

# Convert to docker rootfs
image_uuid=$(basename "$(ls -1t /var/lib/imagefactory/storage/*.body | head -n 1)" .body)
imagefactory --debug target_image --id  docker --parameter compress xz

# Move it to /build
rootfs_source="$(ls -1t /var/lib/imagefactory/storage/*.body | head -n 1)"
mv "${rootfs_source}" /build/rootfs.tar.xz

