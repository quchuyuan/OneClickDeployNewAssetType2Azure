# Download the Python script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/quchuyuan/OneClickDeployNewAssetType2Azure/main/Python/script.py" -OutFile "script.py"

# Run the Python script and capture the output
$output = python script.py

# Write the output to the console
Write-Output $output

# Prepare output for ARM template
$DeploymentScriptOutputs = @{}
$DeploymentScriptOutputs['text'] = $output
