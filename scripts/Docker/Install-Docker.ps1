# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

# Download docker desktop
Write-Host "Downloading Docker Desktop ..."
(new-object net.webclient).DownloadFile('https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe', 'C:\Windows\Temp\DockerDesktopInstaller.exe')

# Install WSL
Write-Host "Install WSL"
Start-Process -FilePath "wsl" -ArgumentList "--install" -Wait

# Install Docker
Write-Host "Instal Docker Desktop"
Start-Process -FilePath "C:/Windows/Temp/DockerDesktopInstaller.exe" -ArgumentList "install --quiet --accept-license --backend=wsl-2" -Wait

# Disable scheduled task
Write-Host "Disable Task"
Disable-ScheduledTask -TaskName "DeployDockerDesktop"

#Write-Host "Reboot machine"
#Restart-Computer