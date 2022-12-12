# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Reference: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-powershell

$ProgressPreference = 'SilentlyContinue'    # hide any progress output

$installerName = 'azcopy_windows_amd64_10.16.2.zip'
$installerPath = Join-Path -Path $env:TEMP -ChildPath $installerName
$destinationPath = 'C:\AzCopy'

Write-Host "[${env:username}] Downloading AzCopy ..."
(new-object net.webclient).DownloadFile('https://aka.ms/downloadazcopy-v10-windows', $installerPath)

New-Item -Path $destinationPath -ItemType Directory -Force

Write-Host "Extract AzCopy..."
Expand-Archive -Path $installerPath -DestinationPath $destinationPath