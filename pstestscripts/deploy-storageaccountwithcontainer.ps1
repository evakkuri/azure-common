# Start timer
$ScriptStart = (Get-Date)

# Define common variables
$rgName = "storagewithcontainertest"
$location = "westeurope"
$deploymentName = "deploymentTest" + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm')

$workFolder = $PSScriptRoot
$parentFolder = Split-Path -Path $PSScriptRoot -Parent

$deploymentTemplateFile = $workFolder + "\test-storageaccountwithcontainer.json"

# Create resource group
New-AzureRmResourceGroup -Name $rgName -Location $location -Force

# Define deployment parameters
$deploymentParams = @{
    "Name" = $deploymentName
    "ResourceGroupName" = $rgName
    "TemplateFile" = $deploymentTemplateFile
    "Mode" = "Complete"
    "Verbose" = $true
}

# Run deployment script
New-AzureRmResourceGroupDeployment @deploymentParams -Force

# Do any additional actions
#$storageAccountKey = (Get-AzureRmResourceGroupDeployment -ResourceGroupName $rgName -Name $deploymentName).Outputs.storageAccountKey.value

# Remove resource group
#Remove-AzureRmResourceGroup -Name $rgName -Force -Verbose

# Stop timer
$ScriptEnd = (Get-Date)
Write-Host "This script took $($ScriptEnd - $ScriptStart) seconds to run"