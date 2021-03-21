NGINX_VERSION = 1.17.9
DOWNLOAD_FILES = \
	nginx.tar.gz \
	nginx-rtmp-module.zip \
	stat.xsl

all:
	@echo "nothing by default"

downloads: $(DOWNLOAD_FILES)

docker-build: $(DOWNLOAD_FILES)
	docker build -t nginx-multistream .

nginx.tar.gz:
	wget -O $@ https://nginx.org/download/nginx-$(NGINX_VERSION).tar.gz

nginx-rtmp-module.zip:
	wget -O $@ https://github.com/arut/nginx-rtmp-module/archive/master.zip

stat.xsl:
	wget -O $@ https://raw.githubusercontent.com/arut/nginx-rtmp-module/master/stat.xsl

docker-run:
	docker run \
		-p 1935:1935 -p 8080:8080 -p 8888:8888 \
		--mount type=bind,source=$(CURDIR)/nginx.conf,target=/usr/local/nginx/conf/nginx.conf \
		-it \
		nginx-multistream:latest
