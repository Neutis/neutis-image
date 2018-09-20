#!/bin/bash

IMAGE_DISTRO="poky-neutis"

while (( "$#" )); do
  case "$1" in
    -d|--distro)
      IMAGE_DISTRO=$2
      shift 2
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      shift
      ;;
  esac
done

# Update submodules
git submodule update --init --recursive

# Init enviroment and cd to build dir
cd poky
source ./oe-init-build-env ../build

# Add all required layers
meta_layers=(
	'meta-sunxi'
	'meta-openembedded/meta-oe'
	'meta-openembedded/meta-python'
	'meta-openembedded/meta-networking'
	'meta-openembedded/meta-webserver'
	'meta-emlid-neutis/meta-neutis-bsp'
	'meta-emlid-neutis/meta-neutis-distro'
	'meta-emlid-neutis-manufacturing'
	'meta-qt5'
	'meta-emlid-neutis-examples'
)

if [ $IMAGE_DISTRO == "poky-neutis-mender" ]; then
    meta_layers=(
        ${meta_layers[@]}
        'meta-mender/meta-mender-core'
        'meta-mender/meta-mender-neutis'
    )
fi

for i in ${meta_layers[@]}; do
	bitbake-layers add-layer ../meta-layers/${i}
done

# Copy conf file
cp ../conf/local.conf conf/local.conf

if [ $IMAGE_DISTRO == "poky-neutis-mender" ]; then
    sed -i '/DISTRO ?=/c\DISTRO ?= "'$IMAGE_DISTRO\" conf/local.conf
fi

