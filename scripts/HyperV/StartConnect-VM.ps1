# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

# Start HyperV Vm and open connection
Start-VM -Name "UbuntuVM"
vmconnect.exe localhost "UbuntuVM"