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

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]