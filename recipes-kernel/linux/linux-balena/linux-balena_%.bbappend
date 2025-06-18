FILESEXTRAPATHS:prepend := "${THISDIR}/linux-balena:"

SRC_URI += "file://my-kernel.cfg file://my-serial.cfg"
KERNEL_CONFIG_FRAGMENTS += "file://my-kernel.cfg file://my-serial.cfg"
