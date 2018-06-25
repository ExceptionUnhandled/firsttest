#region test profile code. added to every test script
$TestProfile = ""
$TestRegion = ""
$CustomTagName = ""
$CustomTagValue = ""

Function Set-TestAWSProfileModule_AWSenvironmentSetup {
    param(
        $ProfileName,
        $Region,
        $CustomTag    
    )
    if($ProfileName){$script:TestProfile = $ProfileName}
    if($Region){$script:TestRegion = $Region}
    if($CustomTag){$script:CustomTagName = $CustomTag.Name; $script:CustomTagValue = $CustomTag.Value}
}

Function Get-TestAWSProfile_AWSenvironmentSetup{
    $props = @{
        'TestProfile'=$Script:TestProfile
        'TestRegion'=$Script:TestRegion
        'TestCustomTagName'=$Script:CustomTagName
        'TestCustomTagValue'=$Script:CustomTagValue
    }
    $obj = New-Object -TypeName psobject -Property $props
    $obj
}

$CustomTag = @{
    Name='Owner'
    Value='Derrick Oliphant'
}
Set-TestAWSProfileModule_AWSenvironmentSetup -ProfileName Personal -Region us-west-2 -CustomTag $CustomTag

$ProfileAdd = @{}
if($TestProfile){$ProfileAdd.add('ProfileName',$TestProfile)} #add this to allow profile in each function

$RegionAdd = @{}
if($TestRegion){$RegionAdd.add('Region',$TestRegion)} #add this to allow region in each function

#endregion profile code

#region whatwedoin
<#
get git
install git
create ssh keys
manual process to register ssh keys
#>
#endregion

#region dothings

#Get git
$WorkingDirectory = Join-Path -Path $env:USERPROFILE -ChildPath 'Documents'

$GitInstallerFile = Join-Path -Path $WorkingDirectory -ChildPath 'Git-2.16.1.3-64-bit.exe'

#Invoke-WebRequest -Uri 'https://git-scm.com/download/win' -OutFile $GitInstallerFile

$URI = "https://github.com/git-for-windows/git/releases/download/v2.16.1.windows.3/Git-2.16.1.3-64-bit.exe"

Invoke-WebRequest -Uri $URI -OutFile $GitInstallerFile

$MSIlogfile = Join-Path -Path $WorkingDirectory -ChildPath 'MSIlog.log'

$arguments = "/SILENT /LOG=`"$MSIlogfile`""

#Install Git
#so done with this, here's a bat file

$BatFileName = 'ding.bat'

$BatFilePath = Join-Path -Path $WorkingDirectory -ChildPath $BatFileName

Set-Content -PassThru $BatFilePath -Value "$GitInstallerFile $arguments"

. $BatFilePath

Remove-Item -Path $BatFilePath -Force

#make a shell script that can generate ssh keys

#open git-bash

$SSHconfigDirName = ".ssh"

$SSHconfigDir = Join-Path -Path (Split-Path $WorkingDirectory -Parent) -ChildPath $SSHconfigDirName

New-Item -Path $SSHconfigDir -ItemType Directory

$ShellScriptName = 'makeakey.sh'

$GitBash = "C:\Program Files\Git\git-bash.exe"

$KeyName = 'codecommit_pu_rsa'
$KeyPass = 'automateall'

$shellscript = @'
ssh-keygen.exe -f ~/.ssh/$KeyName -N $KeyPass
'@

$shellscript = $shellscript.Replace('$KeyName',$KeyName)
$shellscript = $shellscript.Replace('$KeyPass',$KeyPass)

$ShellScriptPath = Join-Path -Path $SSHconfigDir -ChildPath $ShellScriptName

Set-Content -Path $ShellScriptPath -Value $shellscript

#open Git Bash and run the shell script

Read-Host "Press enter to open the Git Bash shell. navigate to the ~/.ssh directory and run makeakey.sh"

. $GitBash

Read-Host "Press enter to continue once the key has been created"

$PubKeyPath = Join-Path -Path $SSHconfigDir -ChildPath 'codecommit_pu_rsa.pub'

Get-Content $PubKeyPath

$SSHaccessKey = Read-Host "Send the Public Key text to the Code Commit admin to register you SSH key. and paste your Access Key here when they respond"

$SSHconfigFileName = 'config'

$SSHconfigFile = Join-Path -Path $SSHconfigDir -ChildPath $SSHconfigFileName

$SSHconfigFileContents = @'
Host git-codecommit.*.amazonaws.com
  User $UserAccessKey
  IdentityFile ~/.ssh/$KeyName
'@

$SSHconfigFileContents = $SSHconfigFileContents.Replace('$UserAccessKey',$SSHaccessKey)
$SSHconfigFileContents = $SSHconfigFileContents.Replace('$KeyName',$KeyName)

Set-Content $SSHconfigFile -Value $SSHconfigFileContents

#endregion

#region undothings
<#
#unistall git
#remove install file

#>
#endregion
