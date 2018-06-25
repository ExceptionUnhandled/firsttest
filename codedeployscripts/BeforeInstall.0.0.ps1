
Start-Transcript -Path 'C:\Windows\Temp\CodeDeployLogs\BeforeInstall.0.0.txt'
Stop-Transcript

<#
create the directory structure where the app is being deployed so that all of the folders are in place before the install step

c:\ProgramData\CDapplicationRoot
and
c:\ProgramData\CDapplicationRoot\NestedFolder

#>


write-output "######## section DisplayFolders ############`n`r" | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\BeforeInstall.0.0.txt -Append
write-host "The Current contents of c:\programdata is:"| Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\BeforeInstall.0.0.txt -Append
Get-ChildItem -Path "C:\ProgramData\" | Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\BeforeInstall.0.0.txt -Append

#now make the new Folders
write-host "begin creation of destination folders"| Out-File -FilePath C:\Windows\Temp\CodeDeployLogs\BeforeInstall.0.0.txt -Append

$ApplicationRoot = 'C:\ProgramData\CDapplicationRoot'

if(-not (Test-Path -Path $ApplicationRoot)){
    New-Item -Path $ApplicationRoot -ItemType Directory
}

#now make the nested folder

$TheNestedFolder = Join-Path -Path $ApplicationRoot -ChildPath "NestedFolder"
if(-not (Test-Path -Path $TheNestedFolder)){
    New-Item -Path $TheNestedFolder -ItemType Directory
}

#now hopefully the source files will fall into place nicely