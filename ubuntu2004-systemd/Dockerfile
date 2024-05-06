FROM ubuntu:20.04
LABEL maintainer="MiaRec, Inc."

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       systemd \
       systemd-cron \
       sudo \
       iproute2 \
       ca-certificates \
    && apt-get clean

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]
