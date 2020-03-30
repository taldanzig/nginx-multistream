# nginx-multistream

Multiplex a livestream to both YouTube and Facebook Live using nginx in a container

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
