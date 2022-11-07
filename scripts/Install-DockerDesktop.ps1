# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

Write-Host "Downloading Docker Desktop ..."
(new-object net.webclient).DownloadFile('https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe', 'C:\Windows\Temp\DockerDesktopInstaller.exe')

Write-Host "Installing Docker Desktop ..."
Start-Process -FilePath "C:/Windows/Temp/DockerDesktopInstaller.exe" -ArgumentList "install --quiet --accept-license --backend=hyper-v" -Wait