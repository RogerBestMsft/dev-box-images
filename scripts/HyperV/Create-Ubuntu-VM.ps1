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

if (!(Test-Path -Path $fullpath )) {
    New-Item -Path $Vm_Path -Name $Vm_Name -ItemType Directory | Out-Null
}

$VhdToAttach = ""

# If the vm_vhd isn't passed in then download the ubuntu vhd 
if ($Vm_Vhd) {
    $VhdToAttach = $Vm_Vhd
}
else 
{

    $ubuntuDownload = "https://partner-images.canonical.com/hyper-v/desktop/focal/release/current/ubuntu-focal-hyperv-amd64-ubuntu-desktop-hyperv.vhdx.zip"
    $ubuntuFile = "ubuntu.zip"
    $fullUbuntuZip = Join-Path $fullpath -ChildPath $ubuntuFile

    # Download Ubuntu file
    Invoke-WebRequest $ubuntuDownload -UseBasicParsing -OutFile "$($fullUbuntuZip)"
    
    # Unzip file
    Expand-Archive -LiteralPath $fullUbuntuZip -DestinationPath $fullpath -Force

    # Get the .vhdx
    $vhd = Get-ChildItem $fullpath -Include *.vhdx -Recurse

    $VhdToAttach = $vhd.FullName

}

# Create vm
New-VM -Name $Vm_Name -MemoryStartupBytes 4096MB -Path $fullpath | Out-Null

Add-VMHardDiskDrive -VMName $Vm_Name -Path $VhdToAttach