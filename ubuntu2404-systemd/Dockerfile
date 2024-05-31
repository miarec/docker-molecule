FROM ubuntu:24.04
LABEL maintainer="MiaRec, Inc."

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       systemd \
       systemd-cron \
       sudo \
       iproute2 \
       ca-certificates \
       python3 \
    && apt-get clean

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]