FROM registry.access.redhat.com/ubi9/ubi-init:latest
LABEL maintainer="MiaRec, Inc."

# Install requirements.
RUN yum -y update \
 && yum -y install \
      sudo \
      iproute \
      which \
      wget \
 && yum clean all

# Add RockyLinux repositories to cover shortfall in UBI packages
RUN wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-9 https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-Rocky-9 \
  && echo -e "[rocky-baseos]\nname=Rocky9-BaseOS\nbaseurl=https://dl.rockylinux.org/pub/rocky/9/BaseOS/\$basearch/os/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-9" > /etc/yum.repos.d/rocky-baseos.repo \
  && echo -e "[rocky-appstream]\nname=Rocky9-AppStream\nbaseurl=https://dl.rockylinux.org/pub/rocky/9/AppStream/\$basearch/os/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-9" > /etc/yum.repos.d/rocky-appstream.repo \
  && echo -e "[rocky-extras]\nname=Rocky9-extras\nbaseurl=https://dl.rockylinux.org/pub/rocky/9/extras/\$basearch/os/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-9" > /etc/yum.repos.d/rocky-extras.repo \
  && echo -e "[rocky-crb]\nname=Rocky9-CRB\nbaseurl=https://dl.rockylinux.org/pub/rocky/9/CRB/\$basearch/os/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-9" > /etc/yum.repos.d/rocky-crb.repo


VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
