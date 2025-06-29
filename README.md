# meta-mycustom

Custom Yocto layer for balenaOS builds, with example systemd services, license  and custom image extensions.

## Layer Contents

This layer provides:

- A `hello` service recipe (`hello_1.0.bb`) that inherits several .bbclass files
- Several kernel updates to `linux-raspberrypi`:
  - Enables USB-to-serial converter chips in `my-serial.cfg`
  - Enables UART on GPIO14/15 (`ttyAMA0`) in `my-kernel.cfg`
  - Patches the `ftdi_sio.c` USB-to-serial driver in `my-driver.*` (in-tree)
- A functional `network-monitor` service recipe in `network-monitor_1.0.bb` (adapted from [RaspAP](https://github.com/RaspAP/raspap-webgui/blob/master/installers/raspap-network-monitor.c))
- Shared systemd unit files (`hello.service`, `update-pre.service`, `network-activity@.service`)
- A centralized custom license file
- BitBake class extensions:
  - `mycustom-license.bbclass`: Declares a local license and checksum
  - `mycustom-minwite.bbclass`: Configure minimal filesystem write features (optional)
  - `mycustom-networkmonitor.bbclass`: A lightweight network activity monitor for embedded systems 
  - `mycustom-ota.bbclass`: Enables OTA support with update-pre, post + reboot hooks
  - `mycustom-security.bbclass`: Injects security best practices
  - `mycustom-systemd.bbclass`: Installs systemd unit files for recipes
- Image extension via `balena-image.bbappend`

## Layer Structure
```
├── bblayers.conf
├── classes
│   ├── mycustom-license.bbclass
│   ├── mycustom-minwrite.bbclass
│   ├── mycustom-networkmonitor.bbclass
│   ├── mycustom-ota.bbclass
│   ├── mycustom-security.bbclass
│   └── mycustom-systemd.bbclass
├── conf
│   └── layer.conf
├── files
│   ├── hello.service
│   ├── LICENSE
│   ├── sshd_config_append
│   ├── update-post.service
│   ├── update-post.sh
│   ├── update-pre.service
│   ├── update-reboot.service
│   ├── update-reboot.sh
│   └── var-log.mount
├── README.md
├── recipes-core
│   ├── hello
│   │   └── hello_1.0.bb
│   └── images
│       └── balena-image.bbappend
├── recipes-kernel
│   └── linux
│       ├── linux-raspberrypi_%.bbappend
│       ├── my-driver.cfg
│       ├── my-driver.patch
│       ├── my-kernel.cfg
│       └── my-serial.cfg
└── recipes-utils
    └── network-monitor
        ├── files
        │   ├── network-activity@.service
        │   └── network-monitor.c
        └── network-monitor_1.0.bb
```

## Usage
Add the layer to `bblayers.conf`:
```
BBLAYERS += "${TOPDIR}/../layers/meta-mycustom"
```

To disable minimal filsystem write mode, set `MINWRITE_ENABLED = "0"` in `conf/layer.conf`.
 
## Requirements
- A Yocto Project compatible environment
- balenaOS build system (eg., balena-raspberrypi)
- validated on `kirkstone`-based BSP

## Build configuration

```
Build Configuration:
BB_VERSION           = "2.0.0"
BUILD_SYS            = "x86_64-linux"
NATIVELSBSTRING      = "universal"
TARGET_SYS           = "aarch64-poky-linux"
MACHINE              = "raspberrypi3-64"
DISTRO               = "balena-os"
DISTRO_VERSION       = "6.5.24"
TUNE_FEATURES        = "aarch64 armv8a crc cortexa53"
TARGET_FPU           = ""
meta-balena-rust     
meta-balena-common   
meta-balena-kirkstone = "HEAD:c5b8f50a26c661b11806e943ffb4c09761e3b186"
meta-balena-raspberrypi = "master:2aa78414828a784d9ef863a5634576e225a1e104"
meta                 
meta-poky            = "HEAD:be48ef3d1bab50824c6678748bcfa897a2a6ca8a"
meta-oe              
meta-filesystems     
meta-networking      
meta-python          
meta-perl            = "HEAD:7b3fdcdfaab2fc964bbf9eec2cce4e03001fa8cf"
meta-raspberrypi     = "HEAD:d7544f35756d87834e8b4bf3e3e733c771d380ae"
meta-mycustom        = "master:44ccfb82ffc782fd874b7991f0c96521d40ccf97"
```
