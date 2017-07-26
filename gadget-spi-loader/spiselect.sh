#!/bin/sh -x

CONFIG_BASE="/sys/kernel/config"
TARGET_DIR="${CONFIG_BASE}/device-tree/overlays/spi"
TARGET_DIR_DTBO="${TARGET_DIR}/dtbo"
TARGET_DIR_STATUS="${TARGET_DIR}/dtbo"
DTBO="/lib/firmware/nextthingco/chip/sample-spi-chippro.dtbo"

MOUNTS="$(mount | grep ${CONFIG_BASE})"

echo "Performing setup"

if [ -z "${MOUNTS}" ];then
	mount -t configfs none ${CONFIG_BASE}
	MOUNTS="$(mount | grep ${CONFIG_BASE})"
	if [ -z ${MOUNTS} ];then
		echo "Error: failed to mount configfs" && exit 1
	fi
fi

echo "Creating directory structure"

mkdir -p "${TARGET_DIR}"

echo "moving $dtbo_location to $target_location"

if [ -f "${DTBO}" ] && [ -f "${TARGET_DIR_DTBO}" ]; then
	cat "${DTBO}" > "${TARGET_DIR_DTBO}"
else
	echo "Error: either the .dtbo or target directory is missing" && exit 1
fi

if [ "$(cat ${TARGET_DIR_STATUS})" -eq "unapplied" ]; then
	echo "Error: failed to apply device tree overlay" && exit 1
fi


modprobe fbtft dma=1
modprobe fbtft_device txbuflen=32768 busnum=32766 custom name=fb_ili9340 speed=36000000 gpios=reset:133,dc:134,led:34 bgr=1 rotate=90
