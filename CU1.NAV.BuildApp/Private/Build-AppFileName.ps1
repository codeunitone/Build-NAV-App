function Build-AppFileName {
    param (
        [Parameter(Mandatory = $true)]
        [PSCustomObject]
        $AppSettings
    )

    # Build app Name and define location off the compiled app
    $AppName = '{0}_{1}_{2}.app' -f $AppSettings.publisher, $AppSettings.name, $AppSettings.version
    return $AppName
}