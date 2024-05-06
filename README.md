# docker-molecule
Collection of docker images with systemd used for molecule testing of ansible roles



## How to Use container

  1. [Install Docker](https://docs.docker.com/engine/installation/).
  2. Pull this image from Github Container Registry Hub: `docker pull ghcr.io/miarec/centos7-systemd:latest`.
  3. Run a container from the image: `docker run --name instance -d --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:rw ghcr.io/miarec/centos7-systemd`
  4. Use the container:
        - `docker exec -it instance /bin/bash`
        - `docker exec instance systemctl status`

