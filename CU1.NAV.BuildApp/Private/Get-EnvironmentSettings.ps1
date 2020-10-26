function Get-EnvironmentSettings {
    param (
        [Parameter(Mandatory = $true)]
        [PSCustomObject]
        $LaunchSettings
    )

    for ($i = 0; $i -lt $LaunchSettings.configurations.Count; $i++) {
        if ($LaunchSettings.configurations[$i].name -eq $Environment) {
            $EnvironmentSettings = $LaunchSettings.configurations[$i]
            $i = $LaunchSettings.configurations.Count + 1
        }
    }
    return $EnvironmentSettings
}