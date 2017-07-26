# ALPINE LINUX ARM WOOO!
FROM armhf/alpine

RUN apk update && apk add fbida-fbi && apk add ttf-dejavu
ADD ntc.png /
ADD ntc1.png /
ADD gr8.png /

ADD runfbi.sh /

CMD ["/bin/sh", "-x", "/runfbi.sh"]
#CMD ["fbi", "--noverbose", "-a", "-t", "5", "-T", "1", "-d", "/dev/fb0", "gr8.png"]
