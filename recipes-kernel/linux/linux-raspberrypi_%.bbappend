FILESEXTRAPATHS:prepend := "${THISDIR}:"

SRC_URI += " \
        file://my-kernel.cfg \
        file://my-serial.cfg \
        file://my-driver.patch \
        file://my-driver.cfg \
"

KERNEL_CONFIG_FRAGMENTS += " \
        file://my-kernel.cfg \
        file://my-serial.cfg \
        file://my-driver.cfg \
"
