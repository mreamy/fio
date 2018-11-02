#FROM registry.access.redhat.com/rhel7:latest
FROM centos

ENV fio_version=2.16

RUN set -x \
  && yum -y update \
  && yum -y --skip-broken install socat tar zlib-devel \
  && yum -y --skip-broken  groupinstall 'Development Tools' \
  && cd /tmp \
  && curl -LsSO https://github.com/axboe/fio/archive/fio-${fio_version}.tar.gz \
  && tar xfvz fio-${fio_version}.tar.gz  \
  && rm fio-${fio_version}.tar.gz\
  && cd fio-fio-${fio_version} \
  && ./configure \
  && make \
  && make install \
  && cd .. \
  && rm -rf fio-fio-${fio_version} \
  && mkdir -p /fio/{jobs,conf,logs,job-data} \
  && chmod -R 777 /fio \
  && yum -y groupremove 'Development Tools' \
  && yum -y erase zlib-devel \
  && yum -y clean all

USER 1001

#CMD ["/bin/sh"]
CMD ["/bin/sh","-c","while true; do echo hello world; sleep 30; done"]

