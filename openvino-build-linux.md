# Build OpenVINO™ for Linux systems

See complete instructions [HERE](https://github.com/openvinotoolkit/openvino/blob/master/docs/dev/build_linux.md)

- Create a conda env with the specific Python version you want to create OpenVINO Python wheels for.
- Below in this example, I'm creating Python 3.8 env so that OpenVINO  wheels will be built for Python 3.8.
- Alternatively, you can pass additional args to specify the Python version as shown [HERE](https://github.com/openvinotoolkit/openvino/blob/master/docs/dev/build_linux.md#additional-build-options)

```bash

conda create -n ov-build-env python=3.8 -y
conda activate ov-build-env

git clone https://github.com/openvinotoolkit/openvino.git
cd openvino
git submodule update --init --recursive

chmod +x install_build_dependencies.sh
sudo ./install_build_dependencies.sh

pip install -r src/bindings/python/src/compatibility/openvino/requirements-dev.txt
pip install -r src/bindings/python/wheel/requirements-dev.txt

mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_PYTHON=ON -DENABLE_WHEEL=ON
make -j22 # Do not specify all cores if you don't have sufficient memory.
cd wheels
pip install openvino*
```

There will be two wheel files : 
- `openvino-20*` : This is OpenVINO runtime
- `openvino_dev-20*`: This is OpenVINO devtools.

```bash
~/installers/openvino/build/wheels$ ls
openvino-2023.1.0-12028-cp38-cp38-manylinux_2_35_x86_64.whl
openvino_dev-2023.1.0-12028-py3-none-any.whl
```
