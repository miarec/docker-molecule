#!/bin/bash
# systemd 219 (EL7) supports only cgroup v1 and hangs on cgroup v2 hosts.
# systemd needs only the "name=systemd" v1 hierarchy, which the kernel can
# mount alongside cgroup v2. Requires a privileged container.
set -e

if [ "$(stat -fc %T /sys/fs/cgroup)" = "cgroup2fs" ]; then
    mount -t tmpfs tmpfs /sys/fs/cgroup
    mkdir /sys/fs/cgroup/systemd
    mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd
fi

exec /sbin/init "$@"
