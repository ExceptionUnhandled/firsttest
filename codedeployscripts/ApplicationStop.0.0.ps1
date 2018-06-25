######section savelogs - not transscribed######
$TranscriptRoot = 'C:\Windows\Temp\CodeDeployLogs'
$TranscriptFilter = '*.0.0.txt'
$TranscriptsFolderName = 'CodeDeployTranscripts'
$TranscriptsFolderPath = Join-Path -Path $TranscriptRoot -ChildPath $TranscriptsFolderName
if(-not (Test-Path -Path $TranscriptsFolderPath )){New-Item -Path $TranscriptsFolderPath -ItemType Directory}

#create a new folder to hold this runs transcripts
$Ticks = (Get-Date).Ticks 
$LastRunsTranscriptsFolderName = "CodeDeploy_$Ticks"
$LastRunsTranscriptsFolderPath = Join-Path -Path $TranscriptsFolderPath -ChildPath $LastRunsTranscriptsFolderName
if(-not (Test-Path -Path $LastRunsTranscriptsFolderPath )){New-Item -Path $LastRunsTranscriptsFolderPath -ItemType Directory}

Get-ChildItem -Path $TranscriptRoot -Filter $TranscriptFilter | ForEach-Object -Process {
    Move-Item -Path $_.FullName -Destination $LastRunsTranscriptsFolderPath    
}
Start-Transcript -Path 'C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt'
Stop-Transcript
write-output "######## section EnvironmentInfo ############`n`r" | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt -Append
write-output "The version: $($PSVersionTable.PSVersion)`n`r" | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt -Append
write-output "Current directory is: $((Get-Location).Path)`n`r" | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt -Append
write-output "OS is: $($env:OS)`n`r" | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt -Append
write-output "UserName is: $([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)`n`r" | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt -Append
Get-ChildItem -LiteralPath env: | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt -Append
write-output "######## section ServiceChange ############`n`r" | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt -Append
Get-Service -Name Spooler | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt -Append
Start-Service -Name Spooler | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt -Append
Get-Service -Name Spooler | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt -Append
Stop-Service -Name Spooler | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt -Append 
Get-Service -Name Spooler | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\ApplicationStop.0.0.txt -Append

