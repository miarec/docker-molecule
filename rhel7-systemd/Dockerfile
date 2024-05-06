FROM registry.access.redhat.com/ubi7/ubi:7.9
LABEL maintainer="MiaRec, Inc."

# # Install requirements.
RUN yum makecache fast \
 && yum -y update \
 && yum -y install \
      sudo \
      iproute \
      which \
 && yum clean all

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
