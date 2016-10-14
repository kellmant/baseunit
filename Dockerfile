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
	adduser -D ctrl -u 500 -g controller -G core -s /bin/bash -h /ctrl && \
	echo "ctrl ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
	addgroup ctrl fleet && \
	addgroup ctrl units && \
	addgroup ctrl boss && \
	addgroup ctrl media && \
	addgroup ctrl web && \
	adduser -S -u 601 -G units -H git && \
	adduser -S -u 602 -G units -H irc && \
	adduser -S -u 603 -G units -H db && \
	adduser -S -u 800 -G media -H plex && \
	adduser -S -u 802 -G media -H shows && \
	adduser -S -u 803 -G media -H movies && \
	adduser -S -u 804 -G media -H music && \
	adduser -S -u 805 -G media -H sab && \
	adduser -S -u 806 -G media -H torrent && \
	adduser -S -u 901 -G web -H hexo && \
	adduser -S -u 902 -G web -H blog && \
	adduser -S -u 903 -G web -H wordpress && \
	adduser -S -u 904 -G web -H node && \
	echo "Gateway In The Sky Project" > /etc/motd && \
	echo "Ironman Lives Again Release" >> /etc/motd && \
	echo " " >> /etc/motd && \
	rm -rf /root/.cache && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*
COPY certs/ /usr/local/share/ca-certificates/
RUN update-ca-certificates
USER root
