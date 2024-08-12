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

# Add CentOS repositories to cover shortfall in UBI repositories
RUN wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7 \
  && echo -e "[centos-baseos]\nname=CentOS7-BaseOS\nbaseurl=http://vault.centos.org/centos/7/os/x86_64/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7" > /etc/yum.repos.d/centos-baseos.repo \
  && echo -e "[centos-extras]\nname=CentOS7-Extras\nbaseurl=http://vault.centos.org/centos/7/extras/x86_64/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7" > /etc/yum.repos.d/centos-extras.repo \
  && echo -e "[centos-updates]\nname=Centos7-Updates\nbaseurl=http://vault.centos.org/centos/7/updates/x86_64/\nenabled=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7" > /etc/yum.repos.d/centos-updates.repo

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]

