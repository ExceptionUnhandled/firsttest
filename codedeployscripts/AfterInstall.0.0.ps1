
Start-Transcript -Path 'C:\Windows\Temp\CodeDeployLogs\AfterInstall.0.0.txt'
Stop-Transcript


write-output "######## section DisplayFolders ############`n`r" | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\AfterInstall.0.0.txt -Append
write-host "The Current contents of c:\programdata is:"| Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\AfterInstall.0.0.txt -Append
Get-ChildItem -Path "C:\ProgramData\" | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\AfterInstall.0.0.txt -Append
