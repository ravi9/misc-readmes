# Steps for building OVMS with NVIDIA Plugin on AWS DLAMI


### Hardware setup on AWS
 - Launch DL AMI: Deep Learning AMI GPU TensorFlow 2.9.1 (Ubuntu 20.04) 20220907 : `ami-06311527200713be0 (64-bit (x86))`
- AWS Instance: g4dn.4xlarge
```markdown
| Name                 | G4DN Quadruple Extra Large            |
|----------------------|---------------------------------------|
| API Name             | g4dn.4xlarge                          |
| Instance Memory      | 64.0 GiB                              |
| vCPUs                | 16 vCPUs                              |
| GPUs                 | 1                                     |
| GPU model            | NVIDIA T4 Tensor Core                 |
| GPU memory           | 16 GiB                                |
| Physical Processor   | Xeon(R) Platinum 8259CL CPU @ 2.50GHz |
| Instance Storage     | 225 GB NVMe SSD                       |
| Network Performance  | Up to 25 Gigabit                      |
| Linux On Demand cost | $1.204000 hourly                      |
```

```
ubuntu@ip-10-0-11-81:~$ nvidia-smi
Tue Sep 13 22:36:29 2022       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 510.47.03    Driver Version: 510.47.03    CUDA Version: 11.6     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Tesla T4            On   | 00000000:00:1E.0 Off |                    0 |
| N/A   46C    P8    14W /  70W |      0MiB / 15360MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+

$ nvcc --version
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2021 NVIDIA Corporation
Built on Sun_Feb_14_21:12:58_PST_2021
Cuda compilation tools, release 11.2, V11.2.152
Build cuda_11.2.r11.2/compiler.29618528_0
```

### Steps for building OVMS with NVIDIA Plugin 
1. Install OpenVINO from Source
2. Setup CUTENSOR
3. Setup OPENVINO_CONTRIB
4. Setup OPENVINO Model Server

#### 1. Install OpenVINO from Source
```
sudo apt-get install libusb-1.0-0-dev

git clone https://github.com/openvinotoolkit/openvino.git
cd openvino
git checkout 2022.1.0
git submodule update --init --recursive

mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make --jobs=10
```


#### 2. Setup CUTENSOR
```
sudo apt-get install libusb-1.0-0-dev

git clone https://github.com/openvinotoolkit/openvino.git
cd openvino
git checkout 2022.1.0
git submodule update --init --recursive

mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make --jobs=10
```

#### 3. Setup OPENVINO_CONTRIB
```
cd ~
git clone --recurse-submodules --single-branch --branch=fix/conv-backprop-data https://github.com/lohika-denis-kotov/openvino_contrib.git

export OPENVINO_HOME=/home/ubuntu/openvino/
export OPENVINO_BUILD_PATH=/home/ubuntu/openvino/build
export OPENVINO_CONTRIB=/home/ubuntu/openvino_contrib
export CUDACXX=/usr/local/cuda/bin/nvcc
export PATH=/usr/local/cuda/bin:$PATH
export CUDNN_PATH=/usr/local/cuda
export CUTENSOR_PATH=/home/ubuntu/cuda_packages/libcutensor

sudo pip3 install cython python-decouple

cd openvino_contrib/modules/nvidia_plugin
export NVIDIA_PLUGIN_SRC_ROOT_DIR=/home/ubuntu/openvino_contrib/modules/nvidia_plugin/
python3 ${NVIDIA_PLUGIN_SRC_ROOT_DIR}/wheel/setup.py build

## If it runs into errors, run the below line and rebuild with above cmd.
# sudo bash /home/ubuntu/openvino_contrib/modules/nvidia_plugin/build/temp.linux-x86_64-cpython-38/deps/openvino/install_build_dependencies.sh

```
#### 4. Setup OpenVINO Model Server

```
git clone https://github.com/openvinotoolkit/model_server.git
cd model_server
git checkout cuda-dockerfile

# COPY CUDA PLUGIN FILES.
cp ~/openvino/bin/intel64/Release/lib/libopenvino_nvidia_gpu_plugin.so release_files/
cp ~/openvino/bin/intel64/Release/lib/libopenvino_auto_plugin.so release_files/

make docker_build CUDA=1
```
