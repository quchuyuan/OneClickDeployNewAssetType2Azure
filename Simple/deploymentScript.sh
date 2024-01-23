#!/bin/bash

# Acquire an Azure access token
accessToken=$(az account get-access-token --query accessToken -o tsv)

# Define the Azure ML REST API endpoint for fetching component info
apiUrl="https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.MachineLearningServices/workspaces/$workspaceName/components/$componentName?api-version=2023-10-01"
jq -n --arg apiUrl "$apiUrl" '{"apiUrl": $apiUrl}' > $AZ_SCRIPTS_OUTPUT_PATH

# Use curl to make the HTTP GET request
# apiResponse=$(curl -X GET $apiUrl -H "Authorization: Bearer $accessToken" -H "Content-Type: application/json")

# Format the response as JSON and write to the output path
# jq -n --arg response "$apiResponse" '{"results": $response}' > $AZ_SCRIPTS_OUTPUT_PATH