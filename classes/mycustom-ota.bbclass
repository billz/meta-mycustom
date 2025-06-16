# enable OTA support with post-update + reboot hooks

SRC_URI += " \
    file://update-pre.service \
    file://update-post.service \
    file://update-reboot.service \
    file://update-post.sh \
    file://update-reboot.sh \
"

do_install:append() {
    # Install systemd service units
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/update-pre.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/update-post.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/update-reboot.service ${D}${systemd_system_unitdir}

    # Install OTA hook scripts
    install -d ${D}${bindir}/ota-hooks
    install -m 0755 ${WORKDIR}/update-post.sh ${D}${bindir}/ota-hooks/update-post.sh
    install -m 0755 ${WORKDIR}/update-reboot.sh ${D}${bindir}/ota-hooks/update-reboot.sh
}

FILES:${PN} += " \
    ${systemd_system_unitdir}/update-pre.service \
    ${systemd_system_unitdir}/update-post.service \
    ${systemd_system_unitdir}/update-reboot.service \
    ${bindir}/ota-hooks/update-post.sh \
    ${bindir}/ota-hooks/update-reboot.sh \
"
