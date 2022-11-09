# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-NoProfile -WindowStyle hidden -ExecutionPolicy bypass -File C:\Windows\Temp\Set-DockerUsers.ps1'

$trigger = @(
    $(New-ScheduledTaskTrigger  -AtLogOn)
)

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "ElevPsScript" -Description "Elevated Powershell script." -RunLevel Highest