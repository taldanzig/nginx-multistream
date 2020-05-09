# Based on instructions here: https://www.vultr.com/docs/setup-nginx-rtmp-on-ubuntu-14-04
# Using Ubuntu 18.04 (bionic)

FROM ubuntu:bionic

RUN apt-get update

# https://launchpad.net/~savoury1/+archive/ubuntu/ffmpeg4
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:savoury1/graphics
RUN add-apt-repository ppa:savoury1/multimedia
RUN add-apt-repository ppa:savoury1/ffmpeg4
RUN add-apt-repository ppa:savoury1/build-tools
RUN add-apt-repository ppa:savoury1/backports

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install build-essential \
	libpcre3 \
	libpcre3-dev \
	libssl-dev \
	zlib1g-dev \
	unzip

RUN apt-get -y install ffmpeg

WORKDIR /build

ENV NGINX_VERSION 1.17.9

COPY nginx.tar.gz .
COPY nginx-rtmp-module.zip .

RUN tar -xf nginx.tar.gz
RUN unzip nginx-rtmp-module.zip

RUN cd nginx-${NGINX_VERSION} && ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
RUN cd nginx-${NGINX_VERSION} && make
RUN cd nginx-${NGINX_VERSION} && make install

COPY stat.xsl /opt/multistream/stat.xsl/stat.xsl
RUN chmod -R a+r /opt/multistream

WORKDIR /opt/multistream

RUN apt-get clean
RUN rm -rf /build

COPY nginx.conf /usr/local/nginx/conf/

EXPOSE 1935 8080
CMD ["/usr/local/nginx/sbin/nginx"]
