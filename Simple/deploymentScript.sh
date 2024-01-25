#!/bin/bash

# Log in to Azure with the managed identity
azLoginRes=$(az login --identity -u $userAssignedIdentities)
azLoginResClientId=$(az login --identity -u $userAssignedIdentitiesClientId)
azLoginResObjectId=$(az login --identity -u $userAssignedIdentitiesObjectId)

# Acquire an Azure access token
#accessToken=$(az account get-access-token)
accessToken=$(az account get-access-token --query accessToken -o tsv)
# Define the Azure ML REST API endpoint for fetching component info
apiUrl="https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.MachineLearningServices/workspaces/$workspaceName/components/$componentName?api-version=2023-10-01"

# Use curl to make the HTTP GET request
apiResponse=$(curl -X GET $apiUrl -H "Authorization: Bearer $accessToken" -H "Content-Type: application/json")

# Format the response as JSON and write to the output path
jq -n \
  --arg userAssignedIdentities "$userAssignedIdentities" \
  --arg azLoginResClientId "$azLoginResClientId" \
  --arg azLoginResObjectId "$azLoginResObjectId" \
  --arg azLogin "$azLoginRes" \
  --arg token "$accessToken" \
  --arg response "$apiResponse" \
  '{"azLogin": $azLogin, "token": $token, "results": $response, "userAssignedIdentities": $userAssignedIdentities, "azLoginResClientId": $azLoginResClientId, "azLoginResObjectId": $azLoginResObjectId}' > $AZ_SCRIPTS_OUTPUT_PATH