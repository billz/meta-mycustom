SRC_URI += " \
    file://hello.service \
    file://update-pre.service \
"

do_install:append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/hello.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/update-pre.service ${D}${systemd_system_unitdir}
}

FILES:${PN} += " \
    ${systemd_system_unitdir}/hello.service \
    ${systemd_system_unitdir}/update-pre.service \
"
