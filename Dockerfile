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
	addgroup -g 797 plex && \
	addgroup -g 800 media && \
	addgroup -g 900 web && \
	adduser -D ctrl -u 500 -g 500 -G fleet -s /bin/bash -h /ctrl && \
	echo "ctrl ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
	adduser -S -u 601 -g units -H git && \
	adduser -S -u 602 -g units -H irc && \
	adduser -S -u 603 -g units -H db && \
	adduser -S -u 797 -g plex -H plex && \
	adduser -S -u 802 -g media -H shows && \
	adduser -S -u 803 -g media -H movies && \
	adduser -S -u 804 -g media -H music && \
	adduser -S -u 805 -g media -H sab && \
	adduser -S -u 806 -g media -H torrent && \
	adduser -S -u 901 -g web -H hexo && \
	adduser -S -u 902 -g web -H blog && \
	adduser -S -u 903 -g web -H wordpress && \
	adduser -S -u 904 -g web -H node && \
	echo "Gateway In The Sky Project" > /etc/motd && \
	echo "Ironman Lives Again Release" >> /etc/motd && \
	echo " " >> /etc/motd && \
	rm -rf /root/.cache && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*
COPY certs/ /usr/local/share/ca-certificates/
RUN update-ca-certificates
USER root
