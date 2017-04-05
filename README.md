# Simplified Telemetry Ingestion stack

Run the Telemetry Ingestion stack via docker-compose.

Test ping submission, schema changes, realtime analysis plugins, parquet outputs, etc.

### To launch the stack:

- Fetch the required pipeline RPMs: `cd edge; bash get_rpms.sh`
- Remove extraneous / outdated RPM versions from the `rpms` dirs. The ones that remain should include some version of the following:
```
    rpms/95/data-pipeline
    rpms/95/GeoIP
    rpms/95/GeoIP-GeoLite-data
    rpms/95/GeoIP-GeoLite-data-extra
    rpms/95/geoipupdate
    rpms/95/librdkafka1
    rpms/95/nginx-moz-ingest
    rpms/trink/hindsight
    rpms/trink/hindsight-admin
    rpms/trink/luasandbox
    rpms/trink/luasandbox-bloom-filter
    rpms/trink/luasandbox-circular-buffer
    rpms/trink/luasandbox-cjson
    rpms/trink/luasandbox-compat
    rpms/trink/luasandbox-cuckoo-filter
    rpms/trink/luasandbox-elasticsearch
    rpms/trink/luasandbox-geoip
    rpms/trink/luasandbox-heka
    rpms/trink/luasandbox-hyperloglog
    rpms/trink/luasandbox-kafka
    rpms/trink/luasandbox-lfs
    rpms/trink/luasandbox-lpeg
    rpms/trink/luasandbox-lsb
    rpms/trink/luasandbox-moz-telemetry
    rpms/trink/luasandbox-openssl
    rpms/trink/luasandbox-parquet
    rpms/trink/luasandbox-postgres
    rpms/trink/luasandbox-rjson
    rpms/trink/luasandbox-sax
    rpms/trink/luasandbox-snappy
    rpms/trink/luasandbox-socket
    rpms/trink/luasandbox-ssl
    rpms/trink/luasandbox-struct
    rpms/trink/luasandbox-syslog
    rpms/trink/luasandbox-systemd
    rpms/trink/luasandbox-zlib
    rpms/whd/parquet-cpp
```
- Build the edge docker container: `docker build --tag moz_ingest .`
- Copy the needed rpms to `dwl/rpms/`. This includes the GeoIP packages, hindsight, librdkafka, luasandbox, and parquet-cpp libs.
- Build the dwl container: `cd ../dwl; docker build --tag dwl .`
- Copy the needed rpms to `hsadmin/rpms/`. This includes the hindsight-admin, luasandbox, luasandbox-cjson and luasandbox-heka libs.
- Build the hsadmin container: `cd ../hsadmin; docker build --tag hsadmin .`
- Launch the stack: `docker-compose up`

### Using the stack:

The [edge](https://wiki.mozilla.org/CloudServices/DataPipeline/HTTPEdgeServerSpecification) service listens on port 8080, and you can submit example telemetry payloads using something like:

`curl -X POST http://$(docker-machine ip default):8080/submit/telemetry/foo/main/Firefox/52.0/release/20170316213829 --data-binary @/path/to/test_submission.gz -H "Content-Encoding: gzip"`

The `dwl` container runs hindsight and by default consumes messages produced by the `edge`.

An instance of [hindsight_admin](https://github.com/mozilla-services/hindsight_admin) listens on port 8081, you can use this to interact with hindsight, inspect messages, and deploy test plugins.
