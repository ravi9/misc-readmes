# OpenVINO GenAI Setup for Development

Quick setup guide for OpenVINO GenAI development environment.

## Prerequisites (Linux)
For detailed instrcutions: [Documentation](https://github.com/openvinotoolkit/openvino.genai/blob/master/src/docs/BUILD.md)
**Software Requirements:**
- CMake 3.23 or higher
- GCC 7.5 or higher  
- Python 3.9 or higher
- Git

```bash
pip install openvino
```

## Installation

```bash
git clone https://github.com/openvinotoolkit/openvino.genai.git
cd openvino.genai
git checkout 2025.2.0.0  # Match OpenVINO version
git submodule update --init --recursive
```

## Development Setup

### Python Development (Editable Install)
Changes to Python source code in openvino.genai are reflected immediately without reinstalling.
```bash
python -m pip install -e .
```

### C++ Development
Rebuild after modifying C++ files.
```bash
mkdir build && cd build
cmake --build . --config Release --verbose --parallel
make -j

cd ..
python -m pip install -e .
```

## Notes
- Ensure OpenVINO and GenAI versions match for compatibility
- Use editable install (`-e`) for active Python development
- C++ changes require manual rebuild
