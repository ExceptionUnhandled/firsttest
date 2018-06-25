  $region = Read-Host -Prompt "Region: (hit enter for us-west-2)"
    if($region.Length -eq 0){$region = "us-west-2"}
    $profilename = read-host -Prompt "User Profile Name:"
    $Credential = Get-Credential -Message "username: AK, password: SAK"
    Set-DefaultAWSRegion -Region us-west-2
    #Set-AWSCredentials -StoreAs ($Credential.UserName.Replace($TrimUserNumber,'')) -AccessKey $Credential.AK -SecretKey $Credential.SAK
    Set-AWSCredentials -StoreAs $profilename -AccessKey $Credential.UserName -SecretKey $Credential.GetNetworkCredential().Password
    Get-IAMUserList -ProfileName $profilename
    $RegisteredAccountspath = Join-Path -Path $env:LOCALAPPDATA -ChildPath 'awstoolkit' ; cd $RegisteredAccountspath; Get-Content -Path .\RegisteredAccounts.json
    #Remove-AWSCredentialProfile -ProfileName $profilename -Force

    #ak and sak are stored in an encrypted json here and this is the contents...
    #I want to be able to register Personal as well as Work and switch between them on the fly... or not at all.
    # the issue is that I don't want to write two lines for each command I'm calling..

    #assume you had your own AK and SAK