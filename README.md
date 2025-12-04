# docker-molecule

Collection of docker images with systemd used for molecule testing of ansible roles.

Multi-architecture images (amd64 and arm64) are available.

## Available Images

- `ghcr.io/miarec/ubuntu2404-systemd:latest`
- `ghcr.io/miarec/ubuntu2204-systemd:latest`
- `ghcr.io/miarec/ubuntu2004-systemd:latest`
- `ghcr.io/miarec/rockylinux9-systemd:latest`
- `ghcr.io/miarec/rockylinux8-systemd:latest`
- `ghcr.io/miarec/rhel9-systemd:latest`
- `ghcr.io/miarec/rhel8-systemd:latest`

## How to Use

1. [Install Docker](https://docs.docker.com/engine/installation/).
2. Pull an image from GitHub Container Registry: `docker pull ghcr.io/miarec/ubuntu2404-systemd:latest`
3. Run a container from the image: `docker run --name instance -d --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:rw ghcr.io/miarec/ubuntu2404-systemd`
4. Use the container:
   - `docker exec -it instance /bin/bash`
   - `docker exec instance systemctl status`
