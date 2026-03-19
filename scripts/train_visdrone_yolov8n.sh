#!/bin/bash
set -e

PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd)
cd "$PROJECT_DIR"

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate yolorace310

python start_train.py \
  --model ultralytics/cfg/models/v8/yolov8n.yaml \
  --dataset_config ultralytics/cfg/datasets/VisDrone.yaml \
  --epochs 100 \
  --batch 16 \
  --output_dir runs/train \
  --run_name yolov8n_visdrone_100e