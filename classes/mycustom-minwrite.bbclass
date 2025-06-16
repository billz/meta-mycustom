# Configure minimal filesystem write features
# Set MINWRITE_ENABLED = 1 to enable
# Adapted from https://docs.raspap.com/minwrite/

FILESEXTRAPATHS:prepend := "${LAYERDIR}/files:"
SRC_URI += "file://var-log.mount"

# prevent recommended packages that cause unnecessary writes
BAD_RECOMMENDATIONS += " \
    dphys-swapfile \
    logrotate \
    rsyslog \
    systemd-timesyncd \
    systemd-journal-gatewayd \
"

do_install:append() {
    if [ "${MINWRITE_ENABLED}" = "1" ]; then
        bbnote "Applying minimal write mode"

        # disable journaling
        install -d ${D}${sysconfdir}/systemd/journald.conf.d
        echo -e "[Journal]\nStorage=volatile\nRuntimeMaxUse=10M" > ${D}${sysconfdir}/systemd/journald.conf.d/volatile.conf

        # redirect /var/log to tmpfs
        install -D -m 0644 ${WORKDIR}/var-log.mount ${D}${systemd_system_unitdir}/var-log.mount

        # disable write-heavy services
        mkdir -p ${D}${systemd_system_unitdir}
        ln -sf /dev/null ${D}${systemd_system_unitdir}/systemd-timesyncd.service
        ln -sf /dev/null ${D}${systemd_system_unitdir}/rsyslog.service

        # disable logrotate timer
        ln -sf /dev/null ${D}${systemd_system_unitdir}/logrotate.timer

    fi

}

FILES:${PN} += " \
    ${systemd_system_unitdir}/var-log.mount \
    ${systemd_system_unitdir}/rsyslog.service \
    ${systemd_system_unitdir}/systemd-timesyncd.service \
    ${systemd_system_unitdir}/logrotate.timer \
    ${sysconfdir}/systemd/journald.conf.d/volatile.conf \
"
