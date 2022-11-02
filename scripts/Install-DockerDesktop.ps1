# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

$env:chocolateyUseWindowsCompression = 'false'

Write-Host "Downloading Chocolatey ..."
(new-object net.webclient).DownloadFile('https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe', 'C:\Windows\Temp\DockerDesktopInstaller.ps1')

Write-Host "Installing Docker Desktop ..."
& C:/Windows/Temp/DockerDesktopInstaller.ps1

Add-LocalGroupMember -Group "docker-users" -Member "Administrators"
