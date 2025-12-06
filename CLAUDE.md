This file provides guidance to coding agent when working with code in this repository.

## Project Overview

This repository contains Docker images with systemd enabled, designed for Molecule testing of Ansible roles. Images are published to GitHub Container Registry (ghcr.io/miarec/).

## Building and Testing Images

Build a single image:
```bash
docker build -t ghcr.io/miarec/<image-name>:latest <image-name>/
```

Test an image (verify systemd works):
```bash
docker run -d --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:rw ghcr.io/miarec/<image-name>:latest systemctl status
```

Available image directories: `ubuntu2404-systemd`, `ubuntu2204-systemd`, `ubuntu2004-systemd`, `rockylinux9-systemd`, `rockylinux8-systemd`, `rhel9-systemd`, `rhel8-systemd`, `rhel7-systemd`, `centos7-systemd`

## CI/CD

GitHub Actions builds and publishes multi-arch images (amd64/arm64) on push to master. The workflow:
1. Builds each image on both `ubuntu-24.04` and `ubuntu-24.04-arm` runners
2. Pushes architecture-specific tags
3. Creates multi-arch manifests with `:latest` tag

## Image Architecture Notes

- **Ubuntu images**: Based on official Ubuntu images, install systemd packages
- **Rocky Linux images**: Based on official Rocky Linux images, clean up systemd wants
- **RHEL images**: Based on Red Hat UBI images, add Rocky Linux repos to supplement UBI package availability
- **CentOS 7/RHEL 7**: Use vault.centos.org mirrors (EOL workaround)

All images mount `/sys/fs/cgroup` and run systemd as PID 1.
