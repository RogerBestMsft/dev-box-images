# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# $env:chocolateyUseWindowsCompression = 'false'

Write-Host "Downloading Docker Desktop ..."
(new-object net.webclient).DownloadFile('https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe', 'C:\Windows\Temp\DockerDesktopInstaller.exe')

Write-Host "Installing Docker Desktop ..."
& C:/Windows/Temp/DockerDesktopInstaller.exe

Add-LocalGroupMember -Group "docker-users" -Member "Administrators"
