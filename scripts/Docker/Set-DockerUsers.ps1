Write-Host "Set local group to docker-users group"
Add-LocalGroupMember -Group "docker-users" -Member "Administrators"