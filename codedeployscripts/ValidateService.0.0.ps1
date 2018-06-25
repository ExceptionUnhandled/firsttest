
Start-Transcript -Path 'C:\Windows\Temp\CodeDeployLogs\ValidateService.0.0.txt'
Stop-Transcript

write-output "######## section ServiceChange ############`n`r" | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ValidateService.0.0.txt -Append
Get-Service -Name Audiosrv | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ValidateService.0.0.txt -Append
Start-Service -Name Audiosrv | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ValidateService.0.0.txt -Append
Get-Service -Name Audiosrv | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ValidateService.0.0.txt -Append
Stop-Service -Name Audiosrv | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ValidateService.0.0.txt -Append 
Get-Service -Name Audiosrv | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ValidateService.0.0.txt -Append

