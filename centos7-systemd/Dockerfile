FROM centos/systemd:latest
LABEL maintainer="MiaRec, Inc."

# Install requirements.
RUN yum -y update \
 && yum -y install \
      sudo \
      iproute \
      which \
 && yum clean all

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]