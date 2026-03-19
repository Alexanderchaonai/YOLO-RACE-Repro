#!/bin/bash
set -e

PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd)
cd "$PROJECT_DIR"

if ! command -v conda >/dev/null 2>&1; then
  echo "conda not found. Please install Miniconda/Anaconda first."
  exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"

ENV_NAME="yolorace310"

if conda env list | grep -q "^${ENV_NAME} "; then
  echo "Conda env ${ENV_NAME} already exists."
else
  conda create -n ${ENV_NAME} python=3.10 -y
fi

conda activate ${ENV_NAME}

pip install --upgrade pip

pip install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cu121

pip install -r requirements.txt
pip install einops

echo "Environment setup finished."
python -c "import sys, torch; print(sys.version); print(torch.__version__); print(torch.cuda.is_available())"