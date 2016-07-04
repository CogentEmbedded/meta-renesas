SUMMARY = "UIM tool for WL18xx module"
SECTION = "misc"

LICENSE = "CLOSED"

inherit update-rc.d
INITSCRIPT_NAME="uim-sysfs"
INITSCRIPT_PARAMS = "start 20 2 3 4 5 ."

PR = "0+gitr${SRCPV}"
PV = "0.1"

SRC_URI = "git://git.ti.com/ti-bt/uim.git;protocol=git \
    file://0001-fix-poll-restart-after-fail.patch \
    file://uim-sysfs"
SRCREV = "a75f45be2d5c74fc1dd913d08afc30f09a230aa9"

S = "${WORKDIR}/git"

do_install() {
    install -d ${D}${bindir}
    install -d ${D}${sysconfdir}/init.d

    install -m 0755 uim ${D}${bindir}/
    install -m 0755 ${WORKDIR}/uim-sysfs ${D}${sysconfdir}/init.d

    # Blacklist st_drv and btwilink to prevent modules autoload
    # /etc/init.d/uim-sysfs will do the work with the proper parameters
    install -d ${D}/${sysconfdir}/modprobe.d
    echo "blacklist st_drv" > ${D}/${sysconfdir}/modprobe.d/ti_bt.conf
    echo "blacklist btwilink" >> ${D}/${sysconfdir}/modprobe.d/ti_bt.conf
}