#!/bin/bash

# Install Azure Machine Learning CLI extension
az extension add -n azure-cli-ml

# Parsing arguments passed from the ARM template
while [ "$1" != "" ]; do
    case $1 in
        --registryName )   shift
                            registryName=$1
                            ;;
        --componentName )   shift
                            componentName=$1
                            ;;
    esac
    shift
done

# Using Azure ML CLI command to retrieve component information
az ml component show --registry-name $registryName --name $componentName