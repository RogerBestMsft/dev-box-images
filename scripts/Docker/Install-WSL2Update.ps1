# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

# Download wsl
Write-Host "Downloading WSL ..."
(new-object net.webclient).DownloadFile('https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi', 'C:\Windows\Temp\wsl_update_x64.msi')

# Install WSL
Write-Host "Set WSL"
Start-Process -FilePath "C:/Windows/System32/msiexec.exe" -ArgumentList "/I C:\Windows\Temp\wsl_update_x64.msi /quiet" -Wait

Write-Host "WSL is enabled. Setting it to WSL2"
wsl --set-default-version 2
