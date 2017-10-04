# Fedora Core 5 i386

## Usage
```
docker run -it --rm clook/fedoracore-i386:5 bash
```

## Build
This image was built thanks to imagefactory tool on Fedora:25 image.

Use [[https://github.com/clook/fedoracore5]] for build:
```
git clone https://github.com/clook/fedoracore5
cd fedoracore5
./build-fedoracore-image.sh
```

It will result in clook/imagefactory image and clook/fedoracore-i386:5 image.
