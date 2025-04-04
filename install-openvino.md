# OpenVINO Installation

### Official documentation: 
- [Install OpenVINO™](https://docs.openvino.ai/2025/get-started/install-openvino.html?PACKAGE=OPENVINO_GENAI&VERSION=v_2025_0_0&OP_SYSTEM=WINDOWS&DISTRIBUTION=PIP)

### Install OpenVINO Pre-Release Packages
 
```bash
pip install \
--upgrade \
--pre openvino openvino-tokenizers openvino-genai \
--extra-index-url https://storage.openvinotoolkit.org/simple/wheels/pre-release 
```

### Install OpenVINO Nightly Packages
 
```bash
pip install \
--upgrade \
openvino openvino-tokenizers openvino-genai \
--extra-index-url https://storage.openvinotoolkit.org/simple/wheels/nightly 
```


### Install Optimum-Intel

- [Optimum-Intel Github](https://github.com/huggingface/optimum-intel)
- [HuggingFace Optimum Intel Docs](https://huggingface.co/docs/optimum/en/intel/openvino/export)
- [HuggingFace Optimum Installation](https://huggingface.co/docs/optimum/main/intel/installation)


```bash
pip install --upgrade --upgrade-strategy eager "optimum[openvino,nncf]"
```

```bash
# install from source to get the latest.
python -m pip install "optimum-intel[openvino,nncf]"@git+https://github.com/huggingface/optimum-intel.git
```