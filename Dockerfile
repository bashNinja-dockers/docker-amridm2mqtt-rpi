FROM lsiobase/alpine.python3.armhf:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Mike Weaver"

# environment settings
#ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV EDITOR="nano"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	python-dev \
	musl-dev \
	make \
	cmake \
	pkgconf \
	git && \
 echo "**** install depends ****" && \
 apk add --no-cache \
	go \
	libusb-dev && \
 echo "**** install pip packages & app ****" && \
 pip install --no-cache-dir -U \
	paho-mqtt

## INSTALL
RUN \
 mkdir -p /opt/rtl-sdr && \
 git clone git://git.osmocom.org/rtl-sdr.git /opt/rtl-sdr && \
 mkdir /opt/rtl-sdr/build && \
 cd /opt/rtl-sdr/build && \
 cmake ../ -DDETACH_KERNEL_DRIVER=ON && \
 make && \
 make install

RUN \
 mkdir -p /opt/amridm2mqtt && \
 git clone https://github.com/ragingcomputer/amridm2mqtt.git /opt/amridm2mqtt

RUN \
 go get github.com/bemasher/rtlamr && \
 cp ~/go/bin/rtlamr /usr/local/bin/rtlamr

RUN \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache

# add local files
COPY root/ /

# ports and volumes
VOLUME /config
