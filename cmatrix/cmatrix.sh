#!/bin/sh -ex

if [ ! -e "/dev/fb0" ]; then
	echo "Looks like the framebuffer was never allocated"
	exit 1
fi

echo cmatrix
