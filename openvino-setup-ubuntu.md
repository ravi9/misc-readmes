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

- 3.1 Download BiT model
```sh
wget https://tfhub.dev/google/bit/m-r50x1/1?tf-hub-format=compressed -O bit_m_r50x1_1.tar.gz
mkdir -p bit_m_r50x1_1 && tar -xvf bit_m_r50x1_1.tar.gz -C bit_m_r50x1_1
```
- 3.2 Run Model Optimizer

```sh
mo --framework tf \
 --data_type FP32 \
 --saved_model_dir ./bit_m_r50x1_1 \
 --output_dir ov_irs/bit_m_r50x1_1/ 
```

- Run [Benchmark APP](https://docs.openvino.ai/latest/openvino_inference_engine_tools_benchmark_tool_README.html)
```sh
benchmark_app \
 -m ov_irs/bit_m_r50x1_1/saved_model.xml \
 -d CPU \
 -shape [1,128,128,3] \
 -hint latency \
 -t 10
```
- To run on GPU, set `-d GPU`. If there are multiple GPU's then there will using either `GPU.0` or `GPU.1`
- The list of available devices can be seen at the end when you run `benchmark_app -h`.
```sh
 benchmark_app \
 -m ov_irs/bit_m_r50x1_1_FP16/saved_model.xml \
 -d GPU \
 -shape [1,128,128,3] \
 -hint latency \
 -t 10
 
 
