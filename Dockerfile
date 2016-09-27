FROM alpine:latest
MAINTAINER kellman
RUN \
	apk -Uuv add --no-cache tzdata ca-certificates bash && \
	addgroup -g 500 core && \
	addgroup -g 600 units && \
	addgroup -g 700 boss && \
	adduser -D ctrl -u 500 -G core -s /bin/bash -h /ctrl && \
	rm -rf /root/.cache && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*
COPY certs/ /usr/local/share/ca-certificates/
RUN update-ca-certificates
ENTRYPOINT ["/bin/bash"]
