FROM centos:7

RUN mkdir /rpms

COPY rpms/*.rpm /rpms/

RUN yum -y install /rpms/*.rpm && \
    rm /rpms/*.rpm

### TODO: Remove this.
RUN yum -y install vim

COPY hindsight_admin_server.xml /etc/wt/hindsight_admin_server.xml

VOLUME /hindsight

EXPOSE 2020

#CMD /bin/bash -c "sleep 1000"
CMD /usr/share/hindsight_admin/run.sh