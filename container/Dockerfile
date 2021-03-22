# Based on instructions here: https://www.vultr.com/docs/setup-nginx-rtmp-on-ubuntu-14-04
# Using Ubuntu 20.04 (focal)

FROM ubuntu:focal AS build

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get -y dist-upgrade \
	&& apt-get -y install build-essential \
		libpcre3 \
		libpcre3-dev \
		libssl-dev \
		zlib1g-dev \
	unzip \
	ffmpeg \
	&& apt-get clean \
	&& rm -rf /var/cache/apt

WORKDIR /build

ENV NGINX_VERSION 1.17.9

COPY nginx.tar.gz .
COPY nginx-rtmp-module.zip .

RUN tar -xf nginx.tar.gz
RUN unzip nginx-rtmp-module.zip

RUN cd nginx-${NGINX_VERSION} \
	&& ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master \
	&& make \
	&& make install \
	&& rm -rf /build

COPY stat.xsl /opt/multistream/stat.xsl/stat.xsl
RUN chmod -R a+r /opt/multistream

FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get -y dist-upgrade \
	&& apt-get -y install \
	ffmpeg \
	&& apt-get clean \
	&& rm -rf /var/cache/apt /var/lib/apt/lists/*

COPY --from=build /usr/local/nginx/ /usr/local/nginx/

COPY nginx.conf.in /usr/local/nginx/conf/
COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 1935 8080
CMD ["/usr/local/bin/start.sh"]
