FROM centos/systemd:latest
LABEL maintainer="MiaRec, Inc."

# Point to yum to vault.centos.org because mirror.centos.org is not available anymore (EOL)
RUN sed -i 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
   sed -i 's|^#\s*baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Install requirements.
RUN yum -y update \
 && yum -y install \
      sudo \
      iproute \
      which \
      python3 \
      centos-release-scl \
 && yum clean all

# Fix base url for CentOS-SCLo-scl-rh.repo and CentOS-SCLo-scl.repo (after installing centos-release-scl package)
RUN sed -i 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-SCLo-* && \
   sed -i 's|^#\s*baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-SCLo-*

# systemd 219 supports only cgroup v1. On cgroup v2 hosts, mount a cgroup v1
# "name=systemd" hierarchy before systemd starts.
COPY init-cgroup.sh /usr/local/sbin/init-cgroup.sh

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/local/sbin/init-cgroup.sh"]