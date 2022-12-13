# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.


Param(
    [Parameter(Mandatory=$false)]
    [string]$Vm_Name= "UbuntuVM"
)


$ProgressPreference = 'SilentlyContinue'	# hide any progress output

$SourceFilePath = "$($ENV:windir)\System32\vmconnect.exe"
$ShortcutPath = "$($ENV:PUBLIC)\Desktop\Ubuntu Developer VM.lnk"
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Arguments = 'localhost ' + """$($Vm_Name)"""
$shortcut.Save()

# Set administrator
$bytes = [System.IO.File]::ReadAllBytes($ShortcutPath)
$bytes[0x15] = $bytes[0x15] -bor 0x20 #set byte 21 (0x15) bit 6 (0x20) ON
[System.IO.File]::WriteAllBytes($ShortcutPath, $bytes)