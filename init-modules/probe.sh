#!/bin/sh -ex

OVERLAY_DIR="/sys/kernel/config/device-tree/overlays/spi"
STATUS_FILE="${OVERLAY_DIR}/status"

echo " --> Verifying spidev has loaded"

COUNT=0
while [ -z "$(lsmod | grep spidev)" ]; do
  echo " --> spidev not ready, waiting..."
  sleep .5
  
  if [ ${COUNT} -eq 5 ]; then
	echo " --> spidev never came up, quitting"
	exit 1
  fi
  
  COUNT=$((COUNT+1))
done

echo " --> Probing modules"

modprobe fbtft dma=1
if [ "$(echo $?)" -ne 0 ]; then
	echo " --> modprobe fbtft failed with a non-zero error code"
	exit 1
fi

echo " --> fbtft loaded"

modprobe fbtft_device            \
 txbuflen=32768                  \
 busnum=32766                    \
 custom name=fb_ili9340          \
 speed=36000000                  \
 gpios=reset:133,dc:134,led:34   \
 bgr=1                           \
 rotate=90

if [ "$(echo $?)" -ne 0 ]; then
	echo " --> modprobe fbtft_device failed with a non-zero error code"
fi

echo " --> fbtft_device loaded"

modprobe fbcon
if [ "$(echo $?)" -ne 0 ]; then
	echo " --> modprobe fbcon failed with a non-zero error code"
fi

echo " --> fbcon loaded"

echo " --> Done"
