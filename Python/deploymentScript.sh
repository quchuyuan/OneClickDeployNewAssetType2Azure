#!/bin/bash
# Download and run the Python script
curl -o script.py https://raw.githubusercontent.com/quchuyuan/OneClickDeployNewAssetType2Azure/main/Python/script.py
pythonOutput=$(python script.py)
jq -n --arg pyOut "$pythonOutput" '{"results": $pyOut}' > $AZ_SCRIPTS_OUTPUT_PATH
