SUMMARY = "Yocto layer to extend balenaOS with custom services, hardened config, minimal disk writes + OTA"
LICENSE = "MIT"

inherit \
    mycustom-license \
    mycustom-systemd \
    mycustom-security \
    mycustom-minwrite \
    mycustom-ota
