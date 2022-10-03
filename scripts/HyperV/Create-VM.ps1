# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

Param(
    [Parameter(Mandatory=$false)]
    [string]$Vm_Path= "C:\HyperVms",
    [Parameter(Mandatory=$false)]
    [string]$Vm_Name= "UbuntuVM",
    [Parameter(Mandatory=$false)]
    [string]$Vm_Vhd
)


$ProgressPreference = 'SilentlyContinue'	# hide any progress output

$fullpath = Join-Path -Path $Vm_Path -ChildPath $Vm_Name
#$ubuntuDownload = "http://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64-azure.vhd.zip"
$ubuntuDownload = "https://partner-images.canonical.com/hyper-v/desktop/focal/release/current/ubuntu-focal-hyperv-amd64-ubuntu-desktop-hyperv.vhdx.zip"
$ubuntuFile = "ubuntu.zip"
$fullUbuntuZip = Join-Path $fullpath -ChildPath $ubuntuFile

if (!(Test-Path -Path $fullpath )) {
    New-Item -Path $Vm_Path -Name $Vm_Name -ItemType Directory
}

# Download Ubuntu 18.04 LTS Bionic Beaver 20220926
Invoke-WebRequest $ubuntuDownload -UseBasicParsing -OutFile "$($fullUbuntuZip)"

# Unzip file
Expand-Archive -LiteralPath $fullUbuntuZip -DestinationPath $fullpath -Force

# Get the .vhd
$vhd = Get-ChildItem $fullpath -Include *.vhd -Recurse

# Create vm
New-VM -Name $Vm_Name -MemoryStartupBytes 1024MB -Path $fullpath

Add-VMHardDiskDrive -VMName $Vm_Name -Path $($vhd.FullName)