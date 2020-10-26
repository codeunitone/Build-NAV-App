function Build-SymbolUrl {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $AppName,

        [Parameter(Mandatory = $true)]
        [PSCustomObject]
        $ServerAddress,

        [Parameter(Mandatory = $true)]
        [PSCustomObject]
        $InstanceName,

        [Parameter(Mandatory = $true)]
        [PSCustomObject]
        $Publisher,
        
        [Parameter(Mandatory = $true)]
        [PSCustomObject]
        $Version
    )
    
    $Url = '{0}:7049/{1}/dev/packages?publisher={2}&appName={3}&versionText={4}' -f `
        $ServerAddress, `
        $InstanceName, `
        $Publisher, `
        $AppName, `
        $Version

    return $Url
}