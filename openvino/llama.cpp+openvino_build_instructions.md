##### https://github.com/ravi9/llama.cpp/blob/dev_backend_openvino/docs/build.md#openvino
## OPENVINO

[OpenVINO](https://docs.openvino.ai/2025/index.html) is an open-source toolkit for optimizing and deploying high-performance AI inference, specifically designed for Intel hardware, including CPUs, GPUs, and NPUs, in the cloud, on-premises, and on the edge. 
The OpenVINO backend enhances performance by leveraging hardware-specific optimizations and can be enabled for use with llama.cpp.

Follow the instructions below to install OpenVINO runtime and build llama.cpp with OpenVINO support.

### Prerequisites

- Linux or Windows system with Intel hardware (CPU, GPU, or NPU)
- **For Intel GPU or NPU Usage**: Install the appropriate hardware drivers for your Intel GPU or NPU. For detailed instructions, see: [Additional Configurations for Hardware Acceleration](https://docs.openvino.ai/2025/get-started/install-openvino/configurations.html).
- Git, CMake, and Ninja software tools are needed for building
```bash
  sudo apt-get update
  sudo apt-get install -y build-essential libcurl4-openssl-dev libtbb12 cmake ninja-build python3-pip curl wget tar
```

### 1. Install OpenVINO Runtime

- Follow the guide to install OpenVINO Runtime from an archive file: **[Install OpenVINO™ Runtime on Linux from an Archive File.](https://docs.openvino.ai/2025/get-started/install-openvino/install-openvino-archive-linux.html)**

<details>
<summary>📦 Click to expand OpenVINO 2025.2 installation commands</summary>
<br>

```bash
export OPENVINO_VERSION_MAJOR=2025.2
export OPENVINO_VERSION_FULL=2025.2.0.19140.c01cd93e24d
sudo apt-get update
sudo apt-get install -y build-essential libcurl4-openssl-dev libtbb12 cmake ninja-build python3-pip curl wget tar
sudo mkdir -p /opt/intel
wget -O openvino_${OPENVINO_VERSION_MAJOR}.tgz https://storage.openvinotoolkit.org/repositories/openvino/packages/${OPENVINO_VERSION_MAJOR}/linux/openvino_toolkit_ubuntu24_${OPENVINO_VERSION_FULL}_x86_64.tgz
tar -xf openvino_${OPENVINO_VERSION_MAJOR}.tgz
sudo mv openvino_toolkit_ubuntu24_${OPENVINO_VERSION_FULL}_x86_64 /opt/intel/openvino_${OPENVINO_VERSION_MAJOR}
rm openvino_${OPENVINO_VERSION_MAJOR}.tgz
cd /opt/intel/openvino_${OPENVINO_VERSION_MAJOR}
echo "Y" | sudo -E ./install_dependencies/install_openvino_dependencies.sh && cd -
sudo ln -s /opt/intel/openvino_${OPENVINO_VERSION_MAJOR} /opt/intel/openvino
source /opt/intel/openvino/setupvars.sh
```
</details>

- Verify OpenVINO is initialized properly
```bash
echo $OpenVINO_DIR
```

### 2. Build llama.cpp with OpenVINO Backend

Clone the OpenVINO-enabled llama.cpp fork and build it:

```bash
git clone https://github.com/ravi9/llama.cpp.git
cd llama.cpp
git switch dev_backend_openvino

# Build with OpenVINO support
source /opt/intel/openvino/setupvars.sh
cmake -B build/ReleaseOV -G Ninja -DCMAKE_BUILD_TYPE=Release -DGGML_OPENVINO=ON
cmake --build build/ReleaseOV --config Release -j $(nproc)
```

### 3. Download Sample Model

Download models for testing:

```bash
# Create models directory
mkdir -p ~/models/

# Download model file: Llama-3.2-1B-Instruct.fp16.gguf
wget https://huggingface.co/MaziyarPanahi/Llama-3.2-1B-Instruct-GGUF/resolve/main/Llama-3.2-1B-Instruct.fp16.gguf \
     -O ~/models/Llama-3.2-1B-Instruct.fp16.gguf

# Download model file: Phi-3-mini-4k-instruct-fp16.gguf
wget https://huggingface.co/microsoft/Phi-3-mini-4k-instruct-gguf/resolve/main/Phi-3-mini-4k-instruct-fp16.gguf \
     -O ~/models/Phi-3-mini-4k-instruct-fp16.gguf
```

### 4. Run inference with OpenVINO backend:

When using the OpenVINO backend, the first inference token may have slightly higher latency due to on-the-fly conversion to the OpenVINO graph. Subsequent tokens and runs will be faster.

```bash
export GGML_OPENVINO_CACHE_DIR=/tmp/ov_cache
# Default device is GPU.
# If not set, automatically selects the first available device in priority order: GPU, CPU, NPU.
export GGML_OPENVINO_DEVICE=GPU

./build/ReleaseOV/bin/llama-simple -m ~/models/Llama-3.2-1B-Instruct.fp16.gguf -n 50 "The story of AI is "

```

To run in chat mode:
```bash
export GGML_OPENVINO_CACHE_DIR=/tmp/ov_cache

./build/ReleaseOV/bin/llama-cli -m ~/models/Llama-3.2-1B-Instruct.fp16.gguf -n 50 "The story of AI is "

```

### Configuration Options

Control OpenVINO behavior using these environment variables:

-   **`GGML_OPENVINO_DEVICE`**: Specify the target device for OpenVINO inference.  If not set, automatically selects the first available device in priority order: GPU, CPU, NPU. When set to `NPU` to use Intel NPUs, it enables static compilation mode for optimal performance. 
-   **`GGML_OPENVINO_CACHE_DIR`**: Directory for model caching (recommended: `/tmp/ov_cache`). If set, enables model caching in OpenVINO. Note: Not supported when using NPU devices yet.  
-   **`GGML_OPENVINO_WEIGHT_AS_INPUT`**: Pass the weights as input to the OpenVINO model instead of creating Constant nodes for them.
-   **`GGML_OPENVINO_PROFILING`**: Enable execution time profiling.
-   **`GGML_OPENVINO_DUMP_CGRAPH`**: Save compute graph to `cgraph.txt`.
-   **`GGML_OPENVINO_DUMP_IR`**: Export OpenVINO IR files with timestamps.
-   **`GGML_OPENVINO_DEBUG_INPUT`**: Enable input debugging.
-   **`GGML_OPENVINO_DEBUG_OUTPUT`**: Enable output debugging.

### Example with Profiling

```bash
export GGML_OPENVINO_CACHE_DIR=/tmp/ov_cache
export GGML_OPENVINO_PROFILING=1

./build/ReleaseOV/bin/llama-simple -m ~/models/Llama-3.2-1B-Instruct.fp16.gguf -n 50 "The story of AI is "
```

### Using Llama.cpp's Built-in CPU Backend (for Comparison)

To compare performance with the default CPU backend:

```bash
# Build CPU-only version
cmake --preset ReleaseCPU
cmake --build build/ReleaseCPU --parallel

# Run with the default CPU backend
./build/ReleaseCPU/bin/llama-simple -m ~/models/Llama-3.2-1B-Instruct.fp16.gguf -n 50 "The story of AI is "

```
