FROM lsiobase/alpine.python3:latest

# set version label
ARG BUILD_DATE
ARG VERSION
ARG TAUTULLI_RELEASE
LABEL build_version="Digitalhigh version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Digitalhigh"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	make \
	python-dev && \
 apk add --no-cache \
        jq && \
 echo "**** install app ****" && \
 mkdir -p /app/flextv && \
 curl -o \
 /tmp/flextv.tar.gz -L \
	"https://github.com/d8ahazard/FlexConnect/archive/master.tar.gz" && \
 tar xf \
 /tmp/flextv.tar.gz -C \
	/app/flextv --strip-components=1 && \
 chmod -R 777 /app/flextv && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /plex
EXPOSE 5667
