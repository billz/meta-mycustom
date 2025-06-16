# meta-mycustom

Custom Yocto layer for balenaOS builds, with example systemd services, license  and custom image extensions.

## Layer Contents

This layer provides:

- A sample `hello` service recipe (`hello_1.0.bb`)
- Shared systemd unit files (`hello.service`, `update-pre.service`)
- A centralized custom license file
- BitBake class extensions:
  - `mycustom-license.bbclass`: Declares a local license and checksum
  - `mycustom-systemd.bbclass`: Installs systemd unit files for recipes
- Image extension via `balena-image.bbappend`

## Layer Structure
```
├── classes
│   ├── mycustom-license.bbclass
│   └── mycustom-systemd.bbclass
├── conf
│   └── layer.conf
├── files
│   ├── hello.service
│   ├── LICENSE
│   └── update-pre.service
└── recipes-core
    ├── hello
    │   └── hello_1.0.bb
    └── images
        └── balena-image.bbappend
```

## Usage
Add the layer to `bblayers.conf`:
```
BBLAYERS += "${TOPDIR}/../layers/meta-mycustom"
```

## Requirements
- A Yocto Project compatible environment
- balenaOS build system (eg., balena-raspberrypi)
- validated on `kirkstone`-based BSP

