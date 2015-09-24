#FROM rhel7
FROM fedora

MAINTAINER Avesh Agarwal <avagarwa@redhat.com>

ENV container=docker

LABEL Vendor="Red Hat" \
      BZComponent="etcd-docker" \
      Name="rhel7/etcd" \
      Version="2.1.1" \
      Release="1" \
      Architecture="x86_64" \
      Summary="A highly-available key value store for shared configuration"

#RUN yum -y --enablerepo rhel-7-server-extras-rpms install etcd hostname && \
RUN dnf -y install etcd hostname && \
    dnf clean all

LABEL INSTALL /usr/bin/docker run --rm \$OPT1 --privileged -v /:/host -e HOST=/host -e NAME=\$NAME -e IMAGE=\$IMAGE \$IMAGE \$OPT2 /usr/bin/install.sh  \$OPT3
LABEL UNINSTALL /usr/bin/docker run --rm \$OPT1 --privileged -v /:/host -e HOST=/host -e NAME=\$NAME -e IMAGE=\$IMAGE \$IMAGE \$OPT2 /usr/bin/uninstall.sh \$OPT3
LABEL RUN /usr/bin/docker run -d \$OPT1 -p 4001:4001 -p 7001:7001 -p 2379:2379 -p 2380:2380 --name \$NAME \$IMAGE \$OPT2 \$OPT3

ADD etcd_container_template.service /etc/systemd/system/etcd_container_template.service
ADD etcd-env.sh /usr/bin/etcd-env.sh
ADD install.sh  /usr/bin/install.sh
ADD uninstall.sh /usr/bin/uninstall.sh

EXPOSE 4001 7001 2379 2380

CMD ["/usr/bin/etcd-env.sh", "/usr/bin/etcd"]
