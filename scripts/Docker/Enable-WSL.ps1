# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

Write-Output "Enable WSL ."
# Use the -NoRestart, the restart will happen in the packer file.  Having the feature restart the machine leads to inconsistent behavior.

& cmd /c 'dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart'
& cmd /c 'dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart'
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

Write-Output "Restart for WSL required in Packer file."
