require ../../include/gles-control.inc
require ../../include/multimedia-control.inc

PACKAGECONFIG_rcar-gen2 := "${@'${PACKAGECONFIG}'.replace('x11', '')}"

PACKAGECONFIG_append_rcar-gen2 = " \
    ${@base_conditional('USE_GLES', '1', '', 'fbdev', d)}"
DEPENDS_append_rcar-gen2 = " \
    ${@base_conditional('USE_GLES', '1', 'gles-user-module', '', d)} \
    ${@base_conditional('USE_GLES_MULTIMEDIA', '1', 'libmediactl-v4l2', '', d)}"
EXTRA_OECONF_append_rcar-gen2 = " \
    ${@base_conditional('USE_GLES', '1', '--enable-v4l2', \
    '--disable-xwayland-test WESTON_NATIVE_BACKEND=fbdev-backend.so', d)}"

SRCREV_rcar-gen2 = "${@'e9bb380affc8eaaf2fb9e52d04f128978d1aec8f' \
    if '1' in '${USE_GLES}' else '00781bcf518f6bab0d08e6962630b0994e8bf632'}"
SRC_URI_rcar-gen2 = " \
    git://github.com/renesas-devel/weston.git;protocol=git;branch=RCAR-GEN2/1.5.0/gl-fallback \
    file://weston.desktop \
    file://weston.png \
    file://disable-wayland-scanner-pkg-check.patch \
    file://make-lcms-explicitly-configurable.patch \
    file://make-libwebp-explicitly-configurable.patch \
"
SRC_URI_append_rcar-gen2 = " \
    file://0001-media-ctl-Separate-libmediactl-code-from-weston.patch \
    file://0002-Revert-V4L2-renderer-workaround-for-a-bulid-error.patch \
    ${@base_conditional("USE_GLES_MULTIMEDIA", "1", \
        "file://vsp-renderer-Change-VSP-device-from-VSP1-to-VSP2.patch", "", d)} \
"
S = "${WORKDIR}/git"

RDEPENDS_${PN}_append_rcar-gen2 = " \
    ${@base_conditional('USE_GLES_MULTIMEDIA', '1', 'vsp2-kernel-module', '', d)} \
"
