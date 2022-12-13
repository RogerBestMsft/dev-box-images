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

$VhdToAttach = "UbuntuDevBox.vhdx"
$TargetFile = Join-Path -Path $fullpath -ChildPath $VhdToAttach

# Demo code needs cleanup
C:\azcopy\azcopy_windows_amd64_10.16.2\azcopy.exe copy 'https://hypervdiskstorage.file.core.windows.net/hypervhds/UbuntuDevBox.vhdx?sv=2021-10-04&st=2022-12-13T16%3A55%3A12Z&se=2022-12-14T16%3A55%3A12Z&sr=f&sp=r&sig=spkkMs4eHwZDp9i4pfOWQpzPS1UT92O0vDXjsZ7D608%3D' $TargetFile

# Create vm
Write-Host "Creating Hosted vm $Vm_Name"
New-VM -Name $Vm_Name -MemoryStartupBytes 4096MB -Path $fullpath | Out-Null

Write-Host "Attaching drive to hosted vm."
Add-VMHardDiskDrive -VMName $Vm_Name -Path $TargetFile

Write-Host "Connect default network"
Connect-VMNetworkAdapter -VMName $Vm_Name -SwitchName 'default switch'

Write-Host "Enable VM Integration"
Get-VMIntegrationService -VMName $vm_Name | ? Name -match 'Interface' | Enable-VMIntegrationService

Write-Host "Increase processors and Enable processor compatibility"
Set-VMProcessor -VMName $Vm_Name -CompatibilityForMigrationEnabled 1 -Count 2

Write-Host "Set auto start"
Set-VM -Name $Vm_Name -AutomaticStartAction Start