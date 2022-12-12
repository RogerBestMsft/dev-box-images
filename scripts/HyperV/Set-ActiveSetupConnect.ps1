# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

param(
    [parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Name", ValueFromPipeline = $true)]
    [ValidateNotNullOrEmpty()]
    $Name = "StartHVM",

    [parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "File to execute")]
    [ValidateNotNullOrEmpty()]
    $CommandToExecute = "'Powershell.exe -WindowStyle hidden -ExecutionPolicy bypass -File C:\Windows\Temp\StartConnect-VM.ps1'"
)

# Stop script FileToRun when a non-terminating error occurs
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


# Set registry key for active setup
Write-Host $Name
$key = [System.Guid]::NewGuid().ToString()

New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components' -Name "$key" -Force
Set-Item -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\$key" -Value "$Name"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\$key" -Name 'Stubpath' -Value "$CommandToExecute"
