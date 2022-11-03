# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

Write-Host "Downloading Docker Desktop ..."
(new-object net.webclient).DownloadFile('https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe', 'C:\Windows\Temp\DockerDesktopInstaller.exe')

Write-Host "Installing Docker Desktop ..."
Start-Process -FilePath "C:/Windows/Temp/DockerDesktopInstaller.exe" -ArgumentList "install --quiet --accept-license --backend=wsl-2" -Wait

Write-Host "Set Administrator to docker-users"
Add-LocalGroupMember -Group "docker-users" -Member "Administrators"