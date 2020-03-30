# nginx-multistream

Multiplex a rtmp stream to both YouTube and Facebook Live using nginx in a container. This makes use of (NGINX)[https://www.nginx.com/], the (NGINX RTMP module)[https://github.com/arut/nginx-rtmp-module], and [FFmpeg](https://www.ffmpeg.org/).

This was cobbled together from instructions on the (OBS project forum)[https://obsproject.com/forum/resources/how-to-set-up-your-own-private-rtmp-server-using-nginx.50/] as well as a guide on (Vultr)[https://www.vultr.com/docs/setup-nginx-rtmp-on-ubuntu-14-04]. I have Dockerized the installation of nginx, ffmpeg, and the rtmp modules using an Ubuntu Xenial (18.04) base, nginx 1.17.9, and ffmpeg4.

## Notes

This was testing on macOS with Docker desktop

## Running

Edit `nginx.conf` and put in your own YouTube and Facebook stream keys

Build and run:

```
make docker-build
make docker-run
```

## Streaming to the multiplexer

In OBS choose a custom stream and use `rtmp://localhost/live` as the destination. No key is needed.

**Performance notes**

The Facebook Live stream is re-encoded using `ffmpeg`. If you're running into performance limitations on the computer running the multiplexer the Facebook stream may lag or fail.
