mkdir -p rpms/95
cd rpms/95
aws s3 sync s3://net-mozaws-prod-us-west-2-ops-rpmrepo-apps/Pipeline-Edge-BUILD/95/ ./
cd -

mkdir -p rpms/trink
cd rpms/trink
curl https://people-mozilla.org/~mtrinkala/packages/centos7/all.tgz | tar xz
cd -

mkdir -p rpms/whd
cd rpms/whd
wget https://people-mozilla.org/~wdawson/parquet-cpp-0.0.1-Linux.rpm
cd -
