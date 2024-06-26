##
# Steps to create LLaVA-med model
#  https://github.com/microsoft/LLaVA-Med?tab=readme-ov-file#model-download
##

# Setup Env
sudo apt install git-lfs

LLAMA_WRKSP="/tmp/llama-wrksp/"
mkdir $LLAMA_WRKSP
cd $LLAMA_WRKSP/

# Create Python VENV or create conda env
python -m venv llama-env
source llama-env/bin/activate

# Download LLaVA-med model delta weights
cd $LLAMA_WRKSP
wget https://hanoverprod.z21.web.core.windows.net/med_llava/models/llava_med_in_text_60k_ckpt2_delta.zip
# Unzip
unzip llava_med_in_text_60k_ckpt2_delta.zip 

# Get original LLaVA-Med weights by applying delta weights
cd $LLAMA_WRKSP
git clone https://github.com/microsoft/LLaVA-Med.git
cd LLaVA-Med/
pip install -e .
pip install open_clip_torch

mkdir $LLAMA_WRKSP/llava_med_model

# Download the base model - luodian/llama-7b-hf
# git lfs install
# git clone https://huggingface.co/luodian/llama-7b-hf
# #git clone https://USER:TOKEN@huggingface.co/meta-llama/Llama-2-7b-hf 
# huggingface-cli login

huggingface-cli login

python3 -m llava.model.apply_delta \
    --base luodian/llama-7b-hf \
    --target $LLAMA_WRKSP/llava_med_model \
    --delta $LLAMA_WRKSP/llava_med_in_text_60k_ckpt2_delta/

