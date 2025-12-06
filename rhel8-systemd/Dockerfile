FROM registry.access.redhat.com/ubi8/ubi-init:latest
LABEL maintainer="MiaRec, Inc."

# Install requirements.
RUN yum -y update \
 && yum -y install \
      sudo \
      iproute \
      which \
      wget \
      python3 \
 && yum clean all

# Add RockyLinux repositories to cover shortfall in UBI packages
RUN wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial \
  && echo -e "[rocky-baseos]\nname=Rocky8-BaseOS\nbaseurl=https://dl.rockylinux.org/pub/rocky/8/BaseOS/\$basearch/os/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial" > /etc/yum.repos.d/rocky-baseos.repo \
  && echo -e "[rocky-appstream]\nname=Rocky8-AppStream\nbaseurl=https://dl.rockylinux.org/pub/rocky/8/AppStream/\$basearch/os/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial" > /etc/yum.repos.d/rocky-appstream.repo \
  && echo -e "[rocky-extras]\nname=Rocky8-extras\nbaseurl=https://dl.rockylinux.org/pub/rocky/8/extras/\$basearch/os/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial" > /etc/yum.repos.d/rocky-extras.repo \
  && echo -e "[rocky-powertools]\nname=Rocky8-PowerTools\nbaseurl=https://dl.rockylinux.org/pub/rocky/8/PowerTools/\$basearch/os/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial" > /etc/yum.repos.d/rocky-powertools.repo

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
