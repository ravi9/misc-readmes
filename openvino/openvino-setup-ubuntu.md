OpenVINO Install on Ubuntu 20.04
------

## Step 1: Install NEO driver
Install the Intel Graphics Compute Runtime for oneAPI Level Zero and OpenCL™ Driver for running deep learning inference with OpenVINO in Intel iGPU/dGPU.

```sh
wget https://raw.githubusercontent.com/openvinotoolkit/openvino/master/scripts/install_dependencies/install_NEO_OCL_driver.sh

chmod +x ./install_NEO_OCL_driver.sh

sudo ./install_NEO_OCL_driver.sh

sudo usermod -aG video $USER
sudo usermod -aG render $USER

# Verify install by running:
clinfo
```

## Step 2: Install OpenVINO
- Instal OpenVINO in a python virtual environment. See official instructions [HERE.](https://docs.openvino.ai/latest/openvino_docs_install_guides_install_dev_tools.html)
- Python3.8 is recommended. 

```sh
python3 -m venv openvino_env
source openvino_env/bin/activate

python -m pip install --upgrade pip
pip install openvino-dev[onnx,tensorflow2,pytorch]
```

## Step 3: Benchmark Sample model

- Download `googlenet-v1-tf` model from OpenVINO Model Zoo (OMZ)
```sh
omz_downloader --name googlenet-v1-tf
```

- Convert googlenet-v1-tf model to OpenVINO IR
```sh
omz_converter --name googlenet-v1-tf
```

- Benchmark googlenet-v1-tf model with [OpenVINO Benchmark App](https://docs.openvino.ai/latest/openvino_inference_engine_tools_benchmark_tool_README.html)
```sh
benchmark_app \
-m public/googlenet-v1-tf/FP32/googlenet-v1-tf.xml \
-hint throughput 
```
