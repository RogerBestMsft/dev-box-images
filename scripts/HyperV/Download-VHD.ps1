# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

Param(
    [Parameter(Mandatory=$false)]
    [string]$Vm_Path= "C:\HyperVms",
    [Parameter(Mandatory=$false)]
    [string]$Vm_Name= "UbuntuVM"
)

$ProgressPreference = 'SilentlyContinue'	# hide any progress output

$fullpath = Join-Path -Path $Vm_Path -ChildPath $Vm_Name

if (!(Test-Path -Path $fullpath )) {
    New-Item -Path $Vm_Path -Name $Vm_Name -ItemType Directory | Out-Null
}

$VhdToAttach = "UbuntuDevBox"
$Targetpath = Join-Path -Path $fullpath -ChildPath $VhdToAttach


C:\azcopy\azcopy_windows_amd64_10.16.2\azcopy.exe login --identity

C:\azcopy\azcopy_windows_amd64_10.16.2\azcopy.exe copy 'https://hypervdiskstorage.blob.core.windows.net/vhds/UbuntuDevBox.vhdx' $Targetpath

# Create vm
Write-Host "Creating Hosted vm $Vm_Name"
New-VM -Name $Vm_Name -MemoryStartupBytes 4096MB -Path $fullpath | Out-Null

Write-Host "Attaching drive to hosted vm."
Add-VMHardDiskDrive -VMName $Vm_Name -Path $Targetpath

Write-Host "Connect default network"
Connect-VMNetworkAdapter -VMName $Vm_Name -SwitchName 'default switch'

Write-Host "Enable VM Integration"
Get-VMIntegrationService -VMName $vm_Name | ? Name -match 'Interface' | Enable-VMIntegrationService

Write-Host "Increase processors and Enable processor compatibility"
Set-VMProcessor -VMName $Vm_Name -CompatibilityForMigrationEnabled 1 -Count 2