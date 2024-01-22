#!/bin/bash

# Parsing arguments passed from the ARM template
while [ "$1" != "" ]; do
    case $1 in
        --subscriptionId )   shift
                             subscriptionId=$1
                             ;;
        --resourceGroupName ) shift
                              resourceGroupName=$1
                              ;;
        --workspaceName )   shift
                           workspaceName=$1
                           ;;
        --componentName )  shift
                           componentName=$1
                           ;;
    esac
    shift
done

# Install Python and necessary packages
apt-get update && apt-get install -y python3-pip
pip3 install azure-identity azure-mgmt-resource requests

# Download the Python script
curl -o script.py https://raw.githubusercontent.com/quchuyuan/OneClickDeployNewAssetType2Azure/main/SDK/script.py

# Run the Python script and capture the output
pythonOutput=$(python3 script.py --subscriptionId $subscriptionId --resourceGroupName $resourceGroupName --workspaceName $workspaceName --componentName $componentName)

# Format the output as JSON and write to the deployment script output path
jq -n --arg pyOut "$pythonOutput" '{"results": $pyOut}' > $AZ_SCRIPTS_OUTPUT_PATH
