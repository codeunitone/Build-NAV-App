function Build-NAVApp {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $ProjectFolder
    )

    # Import helper functions
    $ModuleRootFolder = $MyInvocation.MyCommand.Module.ModuleBase
    . $(Join-Path $ModuleRootFolder -ChildPath 'Private\Get-Settings.ps1')
    . $(Join-Path $ModuleRootFolder -ChildPath 'Private\Get-AppSettings.ps1')
    . $(Join-Path $ModuleRootFolder -ChildPath 'Private\Build-AppFileName.ps1')

    # Read Settings
    $ModuleSettings = Get-Settings # module Settings
    $AppSettings = Get-AppSettings -ProjectFolder $ProjectFolder # app.json from $ProjectFolder

    $ALCompilerPath = $ModuleSettings.ALCompilerPath

    # # Define location of symbols
    $PackageCachePath = Join-Path $ProjectFolder -ChildPath '.alpackages'

    # # Build app Name and define location off the compiled app
    $AppName = Build-AppFileName -AppSettings $AppSettings
    $OutPath = Join-Path $ProjectFolder -ChildPath $AppName

    #Debug info: Feedback of defined paths and names
    Write-Host "ALCompilerPath: $ALCompilerPath" -ForegroundColor Cyan
    Write-Host "ProjectFolder: $ProjectFolder" -ForegroundColor Cyan
    Write-Host "PackageCachePath: $PackageCachePath" -ForegroundColor Cyan
    Write-Host "OutPath: $OutPath" -ForegroundColor Cyan

    # Build App
    & $ALCompilerPath /project:"$ProjectFolder" /packagecachepath:"$PackageCachePath" /out:"$OutPath"



}