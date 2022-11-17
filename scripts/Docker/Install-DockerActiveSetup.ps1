# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

$cmd = "powershell -executionPolicy bypass -File C:\Windows\Temp\Install-DockerDesktop.ps1 -Wait"

# Set registry key for active setup
Write-Host "Adding Active Setup for Docker Desktop"
$key = [System.Guid]::NewGuid().ToString()

New-Item -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components" -Name "$key" -Force
Set-Item -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\$key" -Value "Docker Desktop"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\$key" -Name 'StubPath' -Value "$cmd"