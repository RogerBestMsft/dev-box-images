# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

Write-Host "Downloading WSL2 ..."
(new-object net.webclient).DownloadFile('https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi', 'C:\Windows\Temp\wsl_update_x64.msi')

Write-Host "Installing Docker Desktop ..."
Start-Process -FilePath "C:/Windows/Temp/wsl_update_x64.msi" -ArgumentList "/qn /norestart" -Wait
