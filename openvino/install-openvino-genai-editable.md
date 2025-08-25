# OpenVINO GenAI Setup for Development

Quick guide for OpenVINO GenAI development environment.

## Prerequisites (Linux)
For detailed instructions: [Documentation](https://github.com/openvinotoolkit/openvino.genai/blob/master/src/docs/BUILD.md)

**Software Requirements:**
- CMake 3.23 or higher
- GCC 7.5 or higher  
- Python 3.9 or higher
- Git



## Installation

```
python3 -m venv ov-dev-env
source ov-dev-env/bin/activate
```

```bash
pip install openvino
```

```bash
git clone https://github.com/openvinotoolkit/openvino.genai.git
cd openvino.genai
git checkout 2025.2.0.0  # Match OpenVINO version
git submodule update --init --recursive
```

## Development Setup

### Python Development (Editable Install)
Changes to Python source code in `openvino.genai` are reflected immediately without reinstalling.
```bash
python -m pip install -e .
```

### C++ Development
Rebuild after modifying C++ files.
```bash
cmake -DCMAKE_BUILD_TYPE=Release -S ./ -B ./build/
cmake --build ./build/ --config Release -j

cd ..
python -m pip install -e .
```

## Notes
- Ensure OpenVINO and GenAI versions match for compatibility
- Use editable install (`-e`) for active Python development
- C++ changes require a manual rebuild
