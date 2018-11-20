# Start timer
$ScriptStart = (Get-Date)

# Define common variables
$rgName = "templatestorage-test"
$location = "westeurope"
$deploymentName = "deployment" + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm')

$workFolder = $PSScriptRoot
$parentFolder = Split-Path -Path $PSScriptRoot -Parent

$deploymentTemplateFile = $workFolder + "\util-cicdstorage.json"
$deploymentParametersFile = $workFolder + "\util-cicdstorage.parameters.json"

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

# Stop timer
$ScriptEnd = (Get-Date)
Write-Host "This script took $($ScriptEnd - $ScriptStart) seconds to run"