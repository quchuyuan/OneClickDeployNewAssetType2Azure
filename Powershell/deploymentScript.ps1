# Parsing arguments passed from the ARM template
param (
    [string] $subscriptionId,
    [string] $resourceGroupName,
    [string] $workspaceName,
    [string] $componentName
)

# Acquire an Azure access token
$accessToken = az account get-access-token --query accessToken -o tsv

# Define the Azure ML REST API endpoint for fetching component info
$apiUrl = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.MachineLearningServices/workspaces/$workspaceName/components/$componentName?api-version=2021-03-01-preview"

# Use Invoke-RestMethod to make the HTTP GET request
$response = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers @{Authorization=("Bearer " + $accessToken)} -ContentType "application/json"

# Prepare the output for the ARM template
$DeploymentScriptOutputs = @{'response' = $response}