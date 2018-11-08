# Powershell testing script for deploying a Log Analytics workspace
# NOTE: Assumes that also a parameter file described in variable $deploymentParameters is provided

# Start timer
$ScriptStart = (Get-Date)

## Variable definitions
$rgName = "loganalyticstest"
$location = "westeurope" # North Europe GA estimated Q1 2019 
$deploymentName = "logAnalyticsDeploymentTest" + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm')
$parentFolder = Split-Path -Path $PSScriptRoot -Parent

$deploymentTemplateFile = $parentFolder + "\azure-common\common-loganalytics.json"
$deploymentParametersFile = $parentFolder + "\azure-common\common-loganalytics.parameters.json"

## Create resource group
New-AzureRmResourceGroup -Name $rgName -Location $location -Force

## Deployment parameters
$deploymentParams = @{
    "Name" = $deploymentName
    "ResourceGroupName" = $rgName
    "TemplateFile" = $deploymentTemplateFile
    "TemplateParameterFile" = $deploymentParametersFile
    "Mode" = "Complete"
    "Verbose" = $true
    "Force" = $true
}

## Run deployment script
New-AzureRmResourceGroupDeployment @deploymentParams

# Remove resource group
#Remove-AzureRmResourceGroup -Name $rgName -Force -Verbose

# Stop timer
$ScriptEnd = (Get-Date)
Write-Host "This script took $($ScriptEnd - $ScriptStart) seconds to run"
