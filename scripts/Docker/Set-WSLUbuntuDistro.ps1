# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

Write-Host "Installing WSL Ubuntu distro..."
Start-Process -FilePath "WSL" -ArgumentList "--install -d Ubuntu" -Wait -NoNewWindow
Start-Sleep -Seconds 5
Start-Process -FilePath "WSL" -ArgumentList "-- '/mnt/c/program files/microsoft visual studio/2022/enterprise/common7/ide/extensions/bcd5kvaq.xyl/scripts/installdotnet.sh' aspnetcore 7.0" -Wait -NoNewWindow
