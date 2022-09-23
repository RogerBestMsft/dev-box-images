# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

Param(
    [Parameter(Mandatory=$true)]
    [string]$Vm_Path= "C:\HyperVms",
    [Parameter(Mandatory=$true)]
    [string]$Vm_Name= "UbuntuVM",
    [Parameter(Mandatory=$false)]
    [string]$Vm_Vhd
)


$ProgressPreference = 'SilentlyContinue'	# hide any progress output

New-Item -Path $Vm_Path -Name $Vm_Name -ItemType Directory

$fullpath = Join-Path -Path $Vm_Path -ChildPath $Vm_Name

# Create vm
New-VM -Name $Vm_Name -MemoryStartupBytes 1024MB -Path $fullpath

if ($Vm_Vhd) {}
else {
    # Create new vhd
    New-VHD -Path $($fullpath + "\localdisk.vhdx") -SizeBytes 60GB -Dynamic
}

Add-VMHardDiskDrive -VMName $Vm_Name -Path $($fullpath + "\localdisk.vhdx")