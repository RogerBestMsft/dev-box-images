# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

$ProgressPreference = 'SilentlyContinue'	# hide any progress output
$ErrorActionPreference = 'Stop' 			# error result in stopping script execution

$installerUrls = @(	
	"https://download.visualstudio.microsoft.com/download/pr/5b9d1f0d-9c56-4bef-b950-c1b439489b27/b4aa387715207faa618a99e9b2dd4e35/dotnet-sdk-7.0.100-win-x64.exe",
    "https://download.visualstudio.microsoft.com/download/pr/e4f4bbac-5660-45a9-8316-0ffc10765179/8ade57de09ce7f12d6411ed664f74eca/dotnet-sdk-6.0.202-win-x64.exe",
    "https://download.visualstudio.microsoft.com/download/pr/cc9263cb-9764-4d34-a792-054bebe3abed/08c84422ab3dfdbf53f8cc03f84e06be/dotnet-sdk-5.0.407-win-x64.exe",
    "https://download.visualstudio.microsoft.com/download/pr/42778b69-3b6f-4542-a9ec-4eb5b1954dd6/eb2cb78b2827d75d6d2a7ab694a97298/dotnet-sdk-3.1.418-win-x64.exe"
)

foreach ($installerUrl in $installerUrls) {

	$installerPath = Join-Path -Path $env:TEMP -ChildPath (Split-Path $installerUrl -leaf)

	if (Test-Path $installerPath) { Remove-Item $installerPath }

	Write-Host "[${env:username}] Downloading $installerUrl ..."
	(new-object net.webclient).DownloadFile($installerUrl, $installerPath)

	Write-Host "[${env:username}] Installing $installerPath ..."
	$process = Start-Process -FilePath $installerPath -ArgumentList "/install", "/quiet", "/norestart" -NoNewWindow -Wait -PassThru

	if ($process.ExitCode -ne 0) { exit $process.ExitCode }
}

exit 0