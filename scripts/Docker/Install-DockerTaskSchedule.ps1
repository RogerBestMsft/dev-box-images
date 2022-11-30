# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

# Set registry key for task scheduler
Write-Host "Adding Setup for Install both"

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-NoProfile -ExecutionPolicy bypass -File C:\Windows\Temp\Install-DockerDesktop.ps1" -Wait'

$trigger = New-ScheduledTaskTrigger -AtLogon

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "DeployDockerDesktop" -Description "Elevated Powershell script." -RunLevel Highest
