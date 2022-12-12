# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.
Out-File -FilePath C:\users\public\desktop\SetLog.txt
Write-Host "Installing WSL Ubuntu distro..."
Start-Process -FilePath "WSL" -ArgumentList "--install -d Ubuntu" -WindowStyle Hidden
Start-sleep -Seconds 10
Start-Process -FilePath "WSL" -ArgumentList "-- '/mnt/c/program files/microsoft visual studio/2022/enterprise/common7/ide/extensions/bcd5kvaq.xyl/scripts/installdotnet.sh' aspnetcore 7.0" -WindowStyle Hidden
Write-Host "Finished at $(Get-Date)"