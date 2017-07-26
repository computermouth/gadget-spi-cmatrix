
FROM armhf/alpine

# Install kmod tools (for modprobe)
RUN apk update && apk add kmod && rm -rf /var/cache/apk/*

ADD probe.sh /
