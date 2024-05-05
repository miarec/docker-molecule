FROM registry.access.redhat.com/ubi8/ubi-init:latest
LABEL maintainer="MiaRec, Inc."

# Install requirements.
RUN yum -y update \
 && yum -y install \
      sudo \
      iproute \
      which \
 && yum clean all

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
