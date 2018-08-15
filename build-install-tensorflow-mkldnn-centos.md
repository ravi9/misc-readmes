### Build and install instructions for Tensorflow with MKLDNN on a clean Centos 7.x machine.

Docker setup if needed 
------
Docker install instructions: https://github.com/ravi9/misc-readmes/blob/master/install-docker-centos.md
```
docker pull centos/devtoolset-6-toolchain-centos7  

#Login into the docker with with USER 0 with sudo permissions.
docker run -it --user 0 centos/devtoolset-6-toolchain-centos7:latest /bin/bash
```

Install Prerequistes 
------
```
yum -y install epel-release

yum -y install which pkg-config zip zlib1g-dev unzip cmake gcc-c++ java-1.8.0-openjdk-devel \
htop git make automake autoconf swig libtool binutils patch python-pip python-devel

pip install --upgrade pip
pip install numpy enum34 mock wheel
```

Install Bazel
------
```
wget https://github.com/bazelbuild/bazel/releases/download/0.16.0/bazel-0.16.0-installer-linux-x86_64.sh
chmod +x bazel-0.16.0-installer-linux-x86_64.sh
./bazel-0.16.0-installer-linux-x86_64.sh
source /usr/local/lib/bazel/bin/bazel-complete.bash
```

Git clone tensorflow, configure, build and install 
------
```
git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
./configure
```
Build pip package
```
bazel build --config=mkl -c opt //tensorflow/tools/pip_package:build_pip_package
mkdir ../tf_whls
bazel-bin/tensorflow/tools/pip_package/build_pip_package ../tf_whls/
pip install --upgrade --user ../tf_whls/tensorflow-<version_of_the_created_whl_>.whl
```
If you want to build with AVX2 enabled by default
```
bazel build --config=mkl  --copt="-mfma" --copt="-mavx2" --copt="-O3" -s -c opt //tensorflow/tools/pip_package:build_pip_package
```

Build instructions for C++ API
```
bazel build --config mkl --copt="-mfma" --copt="-mavx2" --copt="-O3" -c opt //tensorflow:libtensorflow_cc.so
```

Error Resolution 
------
---
If get an issue like below while building the wheel, follow the steps below to resolve
```
...libmklml_intel.so: error: undefined reference to 'dlopen'
...libmklml_intel.so: error: undefined reference to 'dlerror'
...libmklml_intel.so: error: undefined reference to 'dlsym'
...libmklml_intel.so: error: undefined reference to 'dladdr'
collect2: error: ld returned 1 exit status
```
The linker is unable to find `libdl.so`. For a work around, you need a private copy of MKL with the missing library included in. Follow the steps below.

1. Download the version of MKL used by the version of Tensorflow you are compiling, you can get the URL from the file `tensorflow/workspace.bzl`, search for `mkl_repository`.

```
wget https://github.com/intel/mkl-dnn/releases/download/v0.14/mklml_lnx_2018.0.3.20180406.tgz
tar -xf mklml_lnx_2018.0.3.20180406.tgz
```

2. Find the shared library libdl.so on your system ( it is usually in /usr/lib/) and copy over to the lib folder of the copy of MKL that you downloaded.
```
#If you donot have locate, install locate tool and update the database for mlocate
yum install -y mlocate
updatedb

#Find the location of libdl.so
locate libdl.so
# output would look like below
# /usr/lib64/libdl.so
# /usr/lib64/libdl.so.2

#Usually libdl.so is a sym link, find the actual file.
ll /usr/lib64/libdl.so.2 
#lrwxrwxrwx. 1 root root 10 Apr  7 11:38 /usr/lib64/libdl.so.2 -> libdl-2.17.so

#Copy the libdl-2.17.so file to the downloaded MKL lib folder as libdl.so
cp /usr/lib64/libdl-2.17.so <path_to_mklml_lnx_2018.0.3.20180406>/lib/libdl.so 
```
3. Set the environment variable TF_MKL_ROOT to point to the copy of MKL from step above.
```
export TF_MKL_ROOT=<path_to_mklml_lnx_2018.0.3.20180406>/
```

4. Modify the file `tensorflow/third_party/mkl/BUILD` to add the line `linkopts = ["-ldl",],` after the line  `name = "intel_binary_blob",`. It should look like below
```
cc_library(
    name = "intel_binary_blob",
    linkopts = ["-ldl",],
    visibility = ["//visibility:public"],
    deps = select({
```

5. Modify the file `tensorflow/third_party/mkl/mkl.BUILD` to add the line `"lib/libdl.so"`, after the line `name = "mkl_libs_linux", srcs = [`. It should look like below
```
cc_library(
    name = "mkl_libs_linux",
    srcs = [
        "lib/libdl.so",
        "lib/libiomp5.so",
        "lib/libmklml_intel.so",
    ],
    visibility = ["//visibility:public"],
)
```

6. run configure and build
