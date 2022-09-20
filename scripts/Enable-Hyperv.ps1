# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

Write-Output "Enable Hyper-V Restart required."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All