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
	addgroup -g 800 media && \
	addgroup -g 900 web && \
	adduser -D ctrl -u 500 -g 500 -G fleet -s /bin/bash -h /ctrl && \
	echo "ctrl ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
	adduser -r -g units git && \
	adduser -r -g units irc && \
	adduser -r -g units db && \
	adduser -r -g media plex && \
	adduser -r -g media shows && \
	adduser -r -g media movies && \
	adduser -r -g media music && \
	adduser -r -g media sab && \
	adduser -r -g media torrent && \
	adduser -r -g web hexo && \
	adduser -r -g web blog && \
	adduser -r -g web wordpress && \
	echo "Gateway In The Sky Project" > /etc/motd && \
	echo "Ironman Lives Again Release" >> /etc/motd && \
	echo " " >> /etc/motd && \
	rm -rf /root/.cache && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*
COPY certs/ /usr/local/share/ca-certificates/
RUN update-ca-certificates
USER root
