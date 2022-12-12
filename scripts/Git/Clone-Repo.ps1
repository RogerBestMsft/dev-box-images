# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

Write-Host "Create repo directory"
New-Item -Path C:\Repos -ItemType Directory

Write-Host "Clone repo."
git clone https://github.com/rbest999/DemoApps C:\Repos