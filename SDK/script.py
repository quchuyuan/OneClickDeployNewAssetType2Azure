# script.py
print("Hello World")
from azure.identity import DefaultAzureCredential
from azure.mgmt.resource import ResourceManagementClient
import argparse
import requests

# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument('--subscriptionId')
parser.add_argument('--resourceGroupName')
parser.add_argument('--workspaceName')
parser.add_argument('--componentName')
args = parser.parse_args()

# Setup Azure authentication
credential = DefaultAzureCredential()
subscription_id = args.subscriptionId

# Construct the API request
api_url = f"https://management.azure.com/subscriptions/{args.subscriptionId}/resourceGroups/{args.resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{args.workspaceName}/components/{args.componentName}?api-version=2023-10-01"

# Make the HTTP GET request
response = requests.get(api_url, headers={"Authorization": f"Bearer {credential.get_token('https://management.azure.com/').token}"})
print(response.json())
