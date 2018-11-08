# Start timer
$ScriptStart = (Get-Date)

# Define common variables
$rgName = "sqlserverwithdbtest"
$location = "northeurope"
$deploymentName = "deploymentTest" + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm')

$workFolder = $PSScriptRoot
$parentFolder = Split-Path -Path $PSScriptRoot -Parent

$deploymentTemplateFile = $workFolder + "\test-sqlserverwithdb.json"
$deploymentParametersFile = $workFolder + "\test-sqlserverwithdb.parameters.json"

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
#Remove-AzureRmResourceGroup -Name $rgName -Force -Verbose

# Stop timer
$ScriptEnd = (Get-Date)
Write-Host "This script took $($ScriptEnd - $ScriptStart) seconds to run"