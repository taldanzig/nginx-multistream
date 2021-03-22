#!/bin/bash

cd /usr/local/nginx/conf/ || exit

cp nginx.conf.in nginx.conf
YOUTUBE_KEY="$(printf '%s\n' "$YOUTUBE_KEY" | sed -e 's/[\/&]/\\&/g')"
FB_KEY="$(printf '%s\n' "$FB_KEY" | sed -e 's/[\/&]/\\&/g')"
PASSWORD="$(printf '%s\n' "$PASSWORD" | sed -e 's/[\/&]/\\&/g')"
sed -i -e "s/__FB_KEY__/${FB_KEY}/" -e "s/__YOUTUBE_KEY__/${YOUTUBE_KEY}/" -e "s/__PASSWORD__/${PASSWORD}/" nginx.conf

echo "======>>>> BEGIN CONF <<<<========="
cat nginx.conf
echo "======>>>> END CONF <<<<========="

echo "About to start nginx"
exec /usr/local/nginx/sbin/nginx
