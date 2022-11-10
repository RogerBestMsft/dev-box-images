# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

Write-Host "Installing WSL 2 ..."
Start-Process -FilePath "WSL" -ArgumentList "--install" -Wait