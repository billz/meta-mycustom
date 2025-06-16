SUMMARY = "Hello systemd service"
LICENSE = "MIT"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
LIC_FILES_CHKSUM = "file://LICENSE;md5=57d76440fc5c9183c79d1747d18d2410"

SRC_URI += "file://LICENSE file://hello.service file://update-pre.service"

S = "${WORKDIR}"

inherit systemd

SYSTEMD_SERVICE:${PN} += "hello.service update-pre.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/hello.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/update-pre.service ${D}${systemd_system_unitdir}/update-pre.service
}

FILES:${PN} += "${systemd_system_unitdir}/hello.service"
FILES:${PN} += "${systemd_system_unitdir}/update-pre.service"
