function Get-ALTestRunnerCredential {
    param (
        [Parameter()]
        [switch]$VM,
        [Parameter(Mandatory = $false)]
        $LaunchConfig
    )

    $params = @{}

    if ($VM.IsPresent) {
        $credNamePropName = 'vmUserName'
        $credSecretPropName = 'vmSecurePassword'
        $params += @{ "VM" = $true }
    } else {
        $credNamePropName = 'userName'
        $credSecretPropName = 'securePassword'
    }

    $credName = Get-ValueFromALTestRunnerConfig -KeyName $credNamePropName
    $credSecret = Get-ValueFromALTestRunnerConfig -KeyName $credSecretPropName

    if (($credName -eq '') -or ($credSecret -eq '')) {
        $Credential = Get-Credential -Message ('Please enter the credentials to connect to {0}' -f (Get-ServerFromLaunchJson -LaunchConfig $LaunchConfig))
        if ($null -eq $Credential) {
            throw "Credentials not entered"
        }
        Set-ALTestRunnerCredential -Credential $Credential @params
        return $Credential
    }
    else {
        return [pscredential]::new($credName, (ConvertTo-SecureString $credSecret))
    }
}

Export-ModuleMember -Function Get-ALTestRunnerCredential