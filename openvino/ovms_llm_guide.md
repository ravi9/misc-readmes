## OpenVINO Model Server (OVMS) LLM Deployment Guide

*   [What is OpenVINO Model Server](https://docs.openvino.ai/2025/model-server/ovms_what_is_openvino_model_server.html)

### Getting Started

*   [OpenVINO™ Model Server - LLM QuickStart guide](https://docs.openvino.ai/2025/model-server/ovms_docs_llm_quickstart.html).
*   [Full list of OVMS Demos](https://docs.openvino.ai/2025/model-server/ovms_docs_demos.html)
*   [OVMS GenAI Demos](https://docs.openvino.ai/2025/model-server/ovms_docs_demos.html#check-out-new-generative-ai-demos)
*   [Efficient LLM Serving](https://docs.openvino.ai/2025/model-server/ovms_docs_llm_reference.html#caching-settings)


### Model Preparation

OVMS-specific preparation uses tools like `export_model.py` which generate `graph.pbtxt` files, `config.json` server configurations, and organize models in the required repository structure. The `export_model.py` script acts as a wrapper around `optimum-intel` that adds OVMS-specific orchestration on top of the standard OpenVINO model preparation workflow.

#### For General OpenVINO Runtime  
* [Generic GenAI Model Prep for OpenVINO](https://docs.openvino.ai/2025/openvino-workflow-generative/genai-model-preparation.html)

#### For OpenVINO Model Server (OVMS)  
* [Exporting GenAI Models for OVMS](https://docs.openvino.ai/2025/model-server/ovms_docs_prepare_genai.html)  
* [Prepare models using export_model.py script for OVMS](https://docs.openvino.ai/2025/model-server/ovms_demos_common_export.html)  

#### Optimum-intel Configs and Docs
* [Default OpenVINO INT4 quantization configs](https://github.com/helena-intel/readmes/blob/main/default_openvino_int4_configs.md#default-openvino-quantization-configs-for-int4-quantization)
* [Configs Source Code](https://github.com/huggingface/optimum-intel/blob/main/optimum/intel/openvino/configuration.py#L54)
* [`optimum-cli export openvino` Documentation](https://huggingface.co/docs/optimum/main/en/intel/openvino/export)
* [Export Hugging Face models for OpenVINO NPU inference](https://github.com/helena-intel/readmes/blob/main/openvino_llm_model_export_npu.md)

#### Using Pre-converted Models
In case you have an existing OpenVINO model, you can use it like this:

```bash
# Download the model locally
huggingface download OpenVINO/Phi-3.5-mini-instruct-int4-ov --local-dir /opt/OpenVINO/Phi-3.5-mini-instruct-int4-ov
# Then run the script
python export_model.py text_generation \
--source_model /opt/OpenVINO/Phi-3.5-mini-instruct-int4-ov \
--model_name OpenVINO/Phi-3.5-mini-instruct-int4-ov \
--model_repository_path models \
--target_device GPU \
--cache 2
```
* When you specify a `--source_model path` that contains existing OpenVINO model files, the script detects this and skips the optimum-cli conversion/export process.
* If `--model_name` is not specified, it defaults to the `--source_model` value.. 
* It will create the `graph.pbtxt` in `model_repository + model_name` path. The `graph.pbtxt` will reference the `source_model` path. 

### Deployment Methods

*   [OpenVINO Model Server Deployment Options ](https://docs.openvino.ai/2025/model-server/ovms_docs_deploying_server.html)

### API Documentation

* OVMS provides endpoints compatible with OpenAI API and Cohere API for generative use cases. See the [completions endpoint documentation](https://docs.openvino.ai/2025/model-server/ovms_docs_clients_genai.html#) and [GenAI Endpoints](https://docs.openvino.ai/2025/model-server/ovms_docs_genai.html)
* [Model Server Parameters](https://docs.openvino.ai/2025/model-server/ovms_docs_parameters.html)

### Performance Tuning
*  [Performance tuning guide](https://docs.openvino.ai/2025/model-server/ovms_docs_performance_tuning.html)
*  [Efficient LLM Serving](https://docs.openvino.ai/2025/model-server/ovms_docs_llm_reference.html#caching-settings)
*  [Using AI accelerators (GPU, NPU)](https://docs.openvino.ai/2025/model-server/ovms_docs_target_devices.html).

### Quick Start

* [test-ovms-openai-client.py](https://github.com/ravi9/misc-scripts/blob/main/openvino/test-ovms-openai-client.py)
```bash
python3 -m venv omvs-env
source omvs-env/bin/activate

# Version v2025.2.1
wget https://raw.githubusercontent.com/openvinotoolkit/model_server/refs/tags/v2025.2.1/demos/common/export_models/export_model.py
wget https://raw.githubusercontent.com/openvinotoolkit/model_server/refs/tags/v2025.2.1/demos/common/export_models/requirements.txt

pip install -r requirements.txt

#Qwen3 Example:
# Option1: download OV int8 model directly
python export_model.py text_generation \
    --source_model OpenVINO/Qwen3-4B-int8-ov \
    --model_name OpenVINO/Qwen3-4B-int8-ov \
    --model_repository_path models \
    --target_device GPU \
    --cache 2 \
    --kv_cache_precision u8 \
    --tools_model_type qwen3 \
    --config_file_path models/config.json

# Option 2: download source model from HF and convert to OV int8
python export_model.py text_generation \
    --source_model Qwen/Qwen3-4B \
    --model_name Qwen/Qwen3-4B-int8-ov \
    --weight-format int8 \
    --model_repository_path models \
    --target_device GPU \
    --cache 2 \
    --kv_cache_precision u8 \
    --tools_model_type qwen3 \
    --config_file_path models/config.json

# Deploy using docker on GPU, for CPU use openvino/model_server:latest, :
docker run --rm -p 8000:8000 \
    --device /dev/dri \
    --group-add=$(stat -c "%g" /dev/dri/render* | head -n 1) \
    -v $(pwd)/models:/workspace:ro \
    openvino/model_server:latest-gpu \
    --port 9000 --rest_port 8000 \
    --config_path /workspace/config.json    

# Verify Model status:
curl http://localhost:8000/v1/config

# Test by sending a request
curl -s http://localhost:8000/v3/chat/completions \
-H "Content-Type: application/json" \
-d '{
  "model": "Qwen/Qwen3-4B-int8-ov",
  "max_tokens": 100,
  "temperature": 0,
  "stream": false,
  "messages": [
    { "role": "user", "content": "The story of AI is " }
  ]
}' | jq .


# Test using OpenAI Python Script
from openai import OpenAI

client = OpenAI(
  base_url="http://localhost:8000/v3",
  api_key="unused"
)

model_name = "Qwen/Qwen3-4B-int8-ov"

stream = client.chat.completions.create(
    model=model_name,
    messages=[
              {"role": "user", "content": "The story of AI is "}
    ],
    max_tokens=100,
    stream=True
)
for chunk in stream:
    if chunk.choices[0].delta.content is not None:
        print(chunk.choices[0].delta.content, end="", flush=True)

```
