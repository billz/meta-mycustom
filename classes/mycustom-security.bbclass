# inject security best practices
SRC_URI += "file://sshd_config_append"

do_install:append() {
    # remove suid/sgid bits from installed binaries
    find ${D} -perm /6000 -type f -exec chmod a-s {} +

    # set ownership + permissions recursively
    chmod -R go-w ${D}

    # install SSH hardening fragment
    install -d ${D}${sysconfdir}/ssh/sshd_config.d
    install -m 0644 ${WORKDIR}/sshd_config_append ${D}${sysconfdir}/ssh/sshd_config.d/hardening.conf
}

RRECOMMENDS:${PN} += "audit"

# extra hardening for systemd
SYSTEMD_SERVICE:${PN} ?= ""
SYSTEMD_HARDENING_OPTS = "\
    ProtectSystem=full \
    ProtectHome=yes \
    NoNewPrivileges=yes \
    PrivateTmp=yes \
    CapabilityBoundingSet=~CAP_SYS_ADMIN \
"

# append hardening to declared systemd service units
python __anonymous() {
    import os
    srv = d.getVar('SYSTEMD_SERVICE:%s' % d.getVar('PN'), True)
    if not srv:
        return
    for s in srv.split():
        d.appendVarFlag('systemd_postinst', s, '\n' +
            'sed -i "/\\[Service\\]/a\\%s" ${D}${systemd_system_unitdir}/%s' % (
                d.getVar("SYSTEMD_HARDENING_OPTS").replace(' ', '\\n'), s
            )
        )
}
