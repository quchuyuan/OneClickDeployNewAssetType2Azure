#!/bin/bash
# Download and run the Python script
curl -o script.py https://raw.githubusercontent.com/quchuyuan/OneClickDeployNewAssetType2Azure/main/Python/script.py
python script.py > $AZ_SCRIPTS_OUTPUT_PATH