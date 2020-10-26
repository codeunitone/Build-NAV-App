function Download-NavSymbols {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $ProjectFolder,

        [Parameter(Mandatory = $true)]
        [ValidateSet('localhost', 'dev', 'test', 'pre-prod', 'prod')]
        [string]
        $Environment,

        [Parameter(Mandatory = $true)]
        [string]
        $Publisher,

        [Parameter(Mandatory = $true)]
        [string]
        $AppName,

        [Parameter(Mandatory = $true)]
        [string]
        $AppVersion
    )

    $ModuleRootFolder = $MyInvocation.MyCommand.Module.ModuleBase
    . $(Join-Path $ModuleRootFolder -ChildPath 'Private\Get-LaunchSettings.ps1')
    . $(Join-Path $ModuleRootFolder -ChildPath 'Private\Get-SymbolPath.ps1')
    . $(Join-Path $ModuleRootFolder -ChildPath 'Private\Get-EnvironmentSettings.ps1')
    . $(Join-Path $ModuleRootFolder -ChildPath 'Private\Build-SymbolUrl.ps1')
    . $(Join-Path $ModuleRootFolder -ChildPath 'Private\Build-AppFileName.ps1')

    $LaunchSettings = Get-LaunchSettings -ProjectFolder $ProjectFolder

    $EnvironmentSettings = Get-EnvironmentSettings -LaunchSettings $LaunchSettings
    
    $SymbolPath = Get-SymbolPath -ProjectFolder $ProjectFolder

    $SymbolsUrl = Build-SymbolUrl `
        -AppName $AppName `
        -Publisher $Publisher `
        -ServerAddress $EnvironmentSettings.server `
        -InstanceName $EnvironmentSettings.serverInstance `
        -Version $AppVersion

    $AppSettings = @{
        publisher = $Publisher
        name      = $AppName
        version   = $AppVersion
    }

    $SymbolsFileName = Build-AppFileName -AppSettings $AppSettings
    $OutFileName = Join-Path $symbolPath -ChildPath $SymbolsFileName

    # Delete existing app files to ensure that if the download fails the application cannot be builde because the symbols are missing
    if (Test-Path -Path $SymbolPath) {
        Remove-Item (Join-Path $SymbolPath -ChildPath '*.app' )
    }


    Write-Host ('Download Symbols from {0} to {1}' -f $SymbolsUrl, $OutFileName) -ForegroundColor Cyan

    Invoke-WebRequest $SymbolsUrl -OutFile "$OutFileName" -UseDefaultCredentials
}