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

# Acquire an Azure access token
accessToken=$(az account get-access-token --query accessToken -o tsv)

# Define the Azure ML REST API endpoint for fetching component info
apiUrl="https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.MachineLearningServices/workspaces/$workspaceName/components/$componentName?api-version=2021-03-01-preview"

# Use curl to make the HTTP GET request
curl -X GET $apiUrl -H "Authorization: Bearer $accessToken" -H "Content-Type: application/json"
