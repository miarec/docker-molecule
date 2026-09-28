# docker-molecule

Collection of docker images with systemd used for molecule testing of ansible roles.

Multi-architecture images (amd64 and arm64) are available.

## Available Images

- `ghcr.io/miarec/ubuntu2604-systemd:latest`
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

## sudo fails in the EL8 and EL9 images on Ubuntu 24.04 hosts

On an Ubuntu 24.04 host, including the `ubuntu-24.04` GitHub Actions runner, `sudo` fails as root in the `rhel8`, `rhel9`, `rockylinux8`, and `rockylinux9` images. Molecule shows it at the first task with `become: true`, because Ansible runs every such task through `sudo`:

```text
sudo: PAM account management error: Authentication service cannot retrieve authentication info
sudo: a password is required
```

The cause is on the host, not in the images:

- Since the CVE-2024-10041 fix (`pam-1.3.1-35.el8`, `pam-1.5.1-22.el9`), `pam_unix` always runs the helper `/usr/sbin/unix_chkpwd` to check the account, even for root.
- Ubuntu's AppArmor profile `unix-chkpwd` attaches to that helper by path, also inside a privileged container. In Ubuntu 24.04 (apparmor 4.0.1), the profile lacks `capability dac_read_search`, which the helper needs to read `/etc/shadow`, mode `0000` in the EL images. The kernel log shows `apparmor="DENIED" operation="capable" profile="unix-chkpwd" ... capname="dac_read_search"`.

Ubuntu 22.04 has no such profile, and the Ubuntu 26.04 profile already has the rule. The EL7 and Ubuntu images are not affected.

Use one of these fixes:

- **Run on Ubuntu 26.04.** In GitHub Actions, set `runs-on: ubuntu-26.04`. The `ubuntu-latest` label moves to Ubuntu 26.04 between October 19 and November 19, 2026.
- **Add the rule to the host's profile.** The profile includes `local/unix-chkpwd`, so the rule applies to the helper only. This GitHub Actions step adds it only where the profile lacks it:

  ```yaml
  - name: Let unix_chkpwd in containers read /etc/shadow
    run: |
      profile=/etc/apparmor.d/unix-chkpwd
      if [ -f "$profile" ] && ! grep -q 'capability dac_read_search' "$profile"; then
        echo 'capability dac_read_search,' | sudo tee -a /etc/apparmor.d/local/unix-chkpwd
        sudo apparmor_parser -r "$profile"
      fi
  ```

To check a host, run `docker exec <container> sudo -n true` in a running container of an EL8 or EL9 image.
