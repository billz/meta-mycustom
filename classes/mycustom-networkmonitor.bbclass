FILESEXTRAPATHS:prepend := "${LAYERDIR}/files:"

do_install:append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/network-activity@.service ${D}${systemd_system_unitdir}/network-activity@.service
}

SYSTEMD_SERVICE:${PN} = "network-activity@.service"

FILES:${PN} += "${systemd_system_unitdir}/network-activity@.service"

