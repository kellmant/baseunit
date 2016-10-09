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
	adduser -r -u 601 -g units git && \
	adduser -r -u 602 -g units irc && \
	adduser -r -u 603 -g units db && \
	adduser -r -u 801 -g media plex && \
	adduser -r -u 802 -g media shows && \
	adduser -r -u 803 -g media movies && \
	adduser -r -u 804 -g media music && \
	adduser -r -u 805 -g media sab && \
	adduser -r -u 806 -g media torrent && \
	adduser -r -u 901 -g web hexo && \
	adduser -r -u 902 -g web blog && \
	adduser -r -u 903 -g web wordpress && \
	echo "Gateway In The Sky Project" > /etc/motd && \
	echo "Ironman Lives Again Release" >> /etc/motd && \
	echo " " >> /etc/motd && \
	rm -rf /root/.cache && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*
COPY certs/ /usr/local/share/ca-certificates/
RUN update-ca-certificates
USER root
