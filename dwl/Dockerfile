FROM centos:7

RUN mkdir /rpms

COPY rpms/*.rpm /rpms/

RUN yum -y install /rpms/*.rpm && \
    rm /rpms/*.rpm && \
    mkdir -p /hindsight/input \
             /hindsight/output/input \
             /hindsight/load \
             /hindsight/run/input \
             /hindsight/run/analysis \
             /hindsight/run/output && \

    yum -y install git && \
    cd /opt && \
    git clone https://github.com/mozilla-services/mozilla-pipeline-schemas.git

COPY hindsight.cfg /hindsight/hindsight.cfg
COPY run/input/kafka_telemetry.cfg /hindsight/run/input/kafka_telemetry.cfg

### TODO: Remove this.
RUN yum -y install vim

VOLUME /hindsight

WORKDIR /hindsight

CMD /usr/bin/hindsight /hindsight/hindsight.cfg
#CMD sleep 1000