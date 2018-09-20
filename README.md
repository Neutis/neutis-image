# Neutis Image

For Emlid Neutis N5 board based on allwinner H5 SoC.

## Building

- Init with: `bash init.sh` && `source poky/oe-init-build-env build`
- `bitbake neutis-minimal-image` or `bitbake neutis-image`
- You will find your image file here: build/tmp/deploy/images/neutis/
