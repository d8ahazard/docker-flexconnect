FROM lsiobase/alpine.python3:latest

# set version label
ARG BUILD_DATE
ARG VERSION
ARG TAUTULLI_RELEASE
LABEL build_version="Digitalhigh version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Digitalhigh"

# ports and volumes
VOLUME /app /plex

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
 mkdir -p /app/flexconnect && \
 curl -o \
 /tmp/flexconnect.tar.gz -L \
	"https://github.com/d8ahazard/FlexConnect/archive/master.tar.gz" && \
 tar xf \
 /tmp/flexconnect.tar.gz -C \
	/app/flexconnect --strip-components=1 && \
 chmod -R 777 /app/flexconnect && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*

# add local files
COPY root/ /