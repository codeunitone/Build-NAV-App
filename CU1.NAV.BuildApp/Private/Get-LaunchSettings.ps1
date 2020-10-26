function Get-LaunchSettings {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $ProjectFolder
    )

    $LaunchJsonPath = Join-Path $ProjectFolder -ChildPath '.vscode\launch.json'
    return (Get-Content $LaunchJsonPath | ConvertFrom-Json)
}