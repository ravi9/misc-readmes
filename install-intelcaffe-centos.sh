#Based on the Dockerfile: https://github.com/intel/caffe/blob/master/docker/standalone/cpu-centos/Dockerfile

rpm -iUvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y \
        redhat-rpm-config \
        tar \
        findutils \
        make \
        gcc-c++ \
        cmake \
        git \
        wget \
        ssh \
        atlas-devel \
        boost-devel \
        gflags-devel \
        glog-devel \
        hdf5-devel \
        leveldb-devel \
        lmdb-devel \
        opencv-devel \
        protobuf-devel \
        snappy-devel \
        protobuf-compiler \
        freetype-devel \
        libpng-devel \
        python-devel \
        python-numpy \
        python-pip \
        python-scipy \
        gcc-gfortran \
        libjpeg-turbo-devel

yum clean all
export CAFFE_ROOT=/opt/caffe
cd $CAFFE_ROOT

export CLONE_TAG=master

git clone -b ${CLONE_TAG} --depth 1 https://github.com/intel/caffe.git . && \
    for req in $(cat python/requirements.txt) pydot; do pip --no-cache-dir install $req; done && \
    mkdir build && cd build && \
    cmake -DCPU_ONLY=1 -DCMAKE_BUILD_TYPE=Release .. && \
    make all -j"$(nproc)"

export PYCAFFE_ROOT=$CAFFE_ROOT/python
export PYTHONPATH=$PYCAFFE_ROOT:$PYTHONPATH
export PATH=$CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig
