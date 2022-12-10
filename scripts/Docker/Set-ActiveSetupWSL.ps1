# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

# Set registry key for active setup
Write-Host "Adding Active Setup for WSL"
$guid = New-Guid
New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components' -Name $guid.Guid -Value "Set WSL"
New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\$($guid.Guid)" -Name StubPath -Value 'Powershell.exe -WindowStyle hidden -ExecutionPolicy bypass -File C:/users/public/desktop/Set-WSLUbuntuDistro.ps1"'

