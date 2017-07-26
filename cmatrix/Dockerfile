
FROM arm32v7/debian:stretch-slim

RUN apt-get update &&\
 apt-get install -y --no-install-recommends cmatrix &&\
 apt-get clean -y &&\
 rm -rf /var/lib/apt/lists

ADD cmatrix.sh /
