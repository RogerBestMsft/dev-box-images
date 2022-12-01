
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

 if ((Test-Admin) -eq $false)  {
     if ($elevated) {
         # tried to elevate, did not work, aborting
     } else {
         Start-Process powershell.exe -Verb RunAs -ArgumentList ('-windowstyle hidden -noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
     }
     exit
 }


# Download docker desktop
Write-Host "Downloading Docker Desktop ..."
(new-object net.webclient).DownloadFile('https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe', 'C:\Windows\Temp\DockerDesktopInstaller.exe')

# Install Docker
Write-Host "Instal Docker Desktop"
Start-Process -FilePath "C:/Windows/Temp/DockerDesktopInstaller.exe" -ArgumentList "install --quiet --accept-license --backend=wsl-2" -Wait

# Disable Task
Disable-ScheduledTask -TaskName "DeployDockerDesktop"

Write-Host "Reboot machine"
Restart-Computer
