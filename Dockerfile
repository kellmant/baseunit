FROM alpine:latest
MAINTAINER kellman
WORKDIR /root
COPY dict /usr/local/share/dict 
COPY bin /usr/local/bin
RUN \
	chmod -R a+x /usr/local/bin && \
	apk -Uuv add --no-cache tzdata bash sudo rsync ca-certificates && \
	addgroup -g 253 fleet && \
	addgroup -g 500 core && \
	addgroup -g 600 units && \
	addgroup -g 700 boss && \
	adduser -D ctrl -u 500 -g 500 -G fleet -s /bin/bash -h /ctrl && \
	echo "ctrl ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
	echo "Gateway In The Sky Project" > /etc/motd && \
	echo "Ironman Release" >> /etc/motd && \
	echo " " >> /etc/motd && \
	rm -rf /root/.cache && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*
COPY certs/ /usr/local/share/ca-certificates/
RUN update-ca-certificates
USER root
ENV PATH=/ctrl/bin:/efs/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
