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

for i in ${meta_layers[@]}; do
	bitbake-layers add-layer ../meta-layers/${i}
done

# Copy conf file
cp ../conf/local.conf conf/ 

