FROM registry.access.redhat.com/ubi7/ubi:7.9
LABEL maintainer="MiaRec, Inc."

# # Install requirements.
RUN yum makecache fast \
 && yum -y update \
 && yum -y install \
      sudo \
      iproute \
      which \
      wget \
      python3 \
 && yum clean all

# Add CentOS repositories to cover shortfall in UBI repositories.
# Use the kernel.org mirror of vault.centos.org: vault.centos.org (CloudFront)
# returns 403 to the EL7 TLS client for large repodata files.
RUN curl -fsSL -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 https://archive.kernel.org/centos-vault/RPM-GPG-KEY-CentOS-7 \
  && echo -e "[centos-baseos]\nname=CentOS7-BaseOS\nbaseurl=https://archive.kernel.org/centos-vault/7.9.2009/os/\$basearch/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7" > /etc/yum.repos.d/centos-baseos.repo \
  && echo -e "[centos-extras]\nname=CentOS7-Extras\nbaseurl=https://archive.kernel.org/centos-vault/7.9.2009/extras/\$basearch/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7" > /etc/yum.repos.d/centos-extras.repo \
  && echo -e "[centos-updates]\nname=Centos7-Updates\nbaseurl=https://archive.kernel.org/centos-vault/7.9.2009/updates/\$basearch/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7" > /etc/yum.repos.d/centos-updates.repo

# UBI has httpd but not httpd-devel. CentOS rebrands httpd (el7.centos), and yum
# prefers the UBI build (el7_9), which breaks CentOS httpd-devel dependencies.
# Install the whole httpd stack from CentOS.
RUN sed -i '/^\[ubi-7\]$/a exclude=httpd* mod_*' /etc/yum.repos.d/ubi.repo

# Add Software Collections (SCLo rh) repository for devtoolset packages.
# The package installs the repo file and GPG key; point its baseurl to the vault mirror.
RUN yum -y install centos-release-scl-rh \
 && sed -i 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo \
 && sed -i 's|^#\s*baseurl=http://mirror.centos.org/centos/7/|baseurl=https://archive.kernel.org/centos-vault/7.9.2009/|g' /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo \
 && yum clean all

# systemd 219 supports only cgroup v1. On cgroup v2 hosts, mount a cgroup v1
# "name=systemd" hierarchy before systemd starts.
COPY init-cgroup.sh /usr/local/sbin/init-cgroup.sh

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/local/sbin/init-cgroup.sh"]
