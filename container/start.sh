#!/bin/bash

cd /usr/local/nginx/conf/

cp nginx.conf.in nginx.conf
sed -i -e "s/__FB_KEY__/${FB_KEY}/" -e "s/__YOUTUBE_KEY__/${YOUTUBE_KEY}/" -e "s/__PASSWORD__/${PASSWORD}/" nginx.conf

echo "======>>>> BEGIN CONF <<<<========="
cat nginx.conf
echo "======>>>> END CONF <<<<========="

echo "About to start nginx"
exec /usr/local/nginx/sbin/nginx
