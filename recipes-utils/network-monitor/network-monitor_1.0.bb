# Adapted from: https://raspap.medium.com/building-a-realtime-network-traffic-led-indicator-in-linux-1156cab84b87
SUMMARY = "Lightweight network activity monitor for embedded systems"
LICENSE = "MIT"
SECTION = "base"
PV = "1.0"

inherit mycustom-license mycustom-networkmonitor

SRC_URI += " \
    file://network-monitor.c \
    file://network-activity@.service \
"

S = "${WORKDIR}"

do_compile() {
    ${CC} ${CFLAGS} ${LDFLAGS} -o network-monitor network-monitor.c
}

do_install:append() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/network-monitor ${D}${bindir}
}

