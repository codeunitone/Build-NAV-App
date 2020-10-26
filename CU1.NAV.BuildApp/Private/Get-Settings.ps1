function Get-Settings {
    $ModuleRootFolder = $MyInvocation.MyCommand.Module.ModuleBase

    $Settings = Join-Path $ModuleRootFolder -ChildPath 'config\settings.json'
    return (Get-Content $Settings | ConvertFrom-Json)
}