# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

# param([switch]$Elevated)

# function Test-Admin {
#     $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
#     $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
# }

# if ((Test-Admin) -eq $false)  {
#     if ($elevated) {
#         # tried to elevate, did not work, aborting
#     } else {
#         Start-Process powershell.exe -Verb RunAs -ArgumentList ('-windowstyle hidden -noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#     }
#     exit
# }

Start-Transcript
#'running with full privileges'
$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

#Start-Process powershell -verb runas -ArgumentList "-command {net localgroup docker-users $user /add}"
net localgroup docker-users $user /add

#Restart-Computer
net stop docker
net stop com.docker.service
taskkill /IM "dockerd.exe" /F
taskkill /IM "Docker for Desktop.exe" /F
net start docker
net start com.docker.service
"c:\program files\docker\docker\Docker for Windows.exe"