[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [ValidateSet('localhost', 'dev', 'test', 'pre-prod', 'prod')]
    [string]
    $Environment
)

# Define root folder of this Extension
$ProjectPath = Split-Path -parent $PSScriptRoot
$SymbolPath = Join-Path $ProjectPath -ChildPath '.alpackages'

# Read app.json settings
$AppJsonPath = Join-Path $ProjectPath -ChildPath 'app.json'
$AppSetting = (Get-Content $AppJsonPath | ConvertFrom-Json)
$LaunchJsonPath = Join-Path $ProjectPath -ChildPath '.vscode\launch.json'
$LaunchSettings = (Get-Content $LaunchJsonPath | ConvertFrom-Json)

# Load environment settings from .\vscode\launch.json
for ($i = 0; $i -lt $LaunchSettings.configurations.Count; $i++) {
    if ($LaunchSettings.configurations[$i].name -eq $Environment) {
        $EnvironmentSettings = $LaunchSettings.configurations[$i]
        $i = $LaunchSettings.configurations.Count + 1
    }
}
$EnvironmentSettings

$SystemSymbolsUrl = '{0}:7049/{1}/dev/packages?publisher=Microsoft&appName=System&versionText= {2}' -f $EnvironmentSettings.server, $EnvironmentSettings.serverInstance, $AppSetting.platform
$ApplicationSymbolsUrl = '{0}:7049/{1}/dev/packages?publisher=Microsoft&appName=Application&versionText={2}' -f $EnvironmentSettings.server, $EnvironmentSettings.serverInstance, $AppSetting.application

Remove-Item (Join-Path $SymbolPath -ChildPath '*.app' )


Invoke-WebRequest $SystemSymbolsUrl -OutFile "$symbolPath\system.app" -UseDefaultCredentials -AllowUnencryptedAuthentication
Invoke-WebRequest $ApplicationSymbolsUrl -OutFile "$symbolPath\application.app" -UseDefaultCredentials -AllowUnencryptedAuthentication