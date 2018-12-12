# Testing script for running test-master template locally
# NOT WORKING YET

# Start timer
$ScriptStart = (Get-Date)

# Create storage account and blob container for reference templates
# TO BE ADDED 

# Copy reference templates to storage account
# TO BE ADDED

# Deploy test-master template using copied templates

# Define common variables
# templateStorageAccountUri TO BE ADDED
# templateStorageAccountToken TO BE ADDED
$rgName = "test-sqlserver-sqldb-keyvault"
$location = "westeurope"
$deploymentName = "deploymentTest" + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm')
$workFolder = $PSScriptRoot
$parentFolder = Split-Path -Path $PSScriptRoot -Parent
$deploymentTemplateFile = $workFolder + "\test-sqlserver-sqldb-keyvault.jsonc"
$deploymentParametersFile = $workFolder + "\test-sqlserver-sqldb-keyvault.parameters.jsonc"

# Create resource group
New-AzureRmResourceGroup -Name $rgName -Location $location -Force

# Define deployment parameters
$deploymentParams = @{
    "Name" = $deploymentName
    "ResourceGroupName" = $rgName
    "TemplateFile" = $deploymentTemplateFile
    "TemplateParameterFile" = $deploymentParametersFile
    "Mode" = "Complete"
    "Verbose" = $true
}

# Run deployment script
New-AzureRmResourceGroupDeployment @deploymentParams -Force

# Remove resource group
Remove-AzureRmResourceGroup -Name $rgName -Force -Verbose

# Stop timer
$ScriptEnd = (Get-Date)
Write-Host "This script took $($ScriptEnd - $ScriptStart) seconds to run"