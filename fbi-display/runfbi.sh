#!/bin/sh -x

fbi --noverbose -a -t 5 -T 1 -d /dev/fb0 *.png

while [ ! -z "$(ps aux | grep fbi)" ]; do
  echo "fbi is still running"
  sleep 1s
done
