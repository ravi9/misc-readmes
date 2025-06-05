# Building OpenVINO Model Server Binary 

This readme summarizes the process for [building the OpenVINO Model Server](https://github.com/openvinotoolkit/model_server/blob/main/docs/build_from_source.md) (`ovms`) binary from source code, specifically for Ubuntu 24.04.

#### Prerequisites
- Docker Engine
- Ubuntu 22.04, Ubuntu 24.04 or RedHat 9.5 host
- make
- bash

### Optimized Binary Package Build 
```bash
make targz_package BASE_OS=ubuntu24 GPU=1 NPU=1

# Minimal package without Python/MediaPipe  
make targz_package BASE_OS=ubuntu24 GPU=0 PYTHON_DISABLE=1 MEDIAPIPE_DISABLE=1  
  
# Limit parallel jobs for systems with limited RAM  
make targz_package BASE_OS=ubuntu24 JOBS=4
```
The above command will:
- Build the `ovms` binary and required libraries
- Package everything into `ovms.tar.gz`
- Place the package in `dist/ubuntu24/` directory


#### Notes:
- GPU Support: The build includes Intel GPU drivers and OpenCL runtime libraries.
- NPU Support: For Ubuntu 24.04, the build automatically downloads and installs NPU drivers including the Intel NPU compiler, firmware, and Level Zero drivers
- The Makefile automatically enables NPU support for Ubuntu builds but disables it for RedHat.

## Usage After Build

```bash
# GPU inference
./ovms --model_path /models/my_model --target_device GPU --port 9000

# NPU inference  
./ovms --model_path /models/my_model --target_device NPU --port 9000 --batch_size 1

# Heterogeneous 
./ovms --model_path /models/my_model --target_device "HETERO:GPU,CPU" --port 9000
```
