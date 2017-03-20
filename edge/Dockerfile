FROM centos:7

RUN mkdir /rpms

COPY rpms/95/*.rpm /rpms/
COPY rpms/trink/*.rpm /rpms/
COPY rpms/whd/*.rpm /rpms/

RUN yum -y install /rpms/*.rpm && \
    rm /rpms/*.rpm && \
    ln -s /opt/openresty/nginx/sbin/nginx /usr/sbin/nginx && \
    mkdir -p /data/landfill && \
    chown nginx /data/landfill

COPY nginx.conf /opt/openresty/nginx/conf/nginx.conf
COPY gzip.conf /opt/openresty/nginx/conf/includes/gzip.conf

# VOLUME /app/output /app/load /app/run /app/input

### TODO: Remove this.
RUN yum -y install vim

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
#CMD /bin/bash -c "sleep 1000"
