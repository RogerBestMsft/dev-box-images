# Copy SetDockerUsers.ps1
# Set registry key for active setup
Write-Host "Adding Active Setup for Docker Users"
$guid = New-Guid
New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components' -Name $guid.Guid -Value "Set Docker User"
New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\$($guid.Guid)" -Name StubPath -Value 'Powershell.exe -WindowStyle hidden -ExecutionPolicy bypass -File C:\\Windows\\Temp\\Set-DockerUsers.ps1"'

