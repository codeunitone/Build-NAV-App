function Get-AppSettings {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $ProjectFolder
    )

    $AppJsonPath = Join-Path $ProjectFolder -ChildPath 'app.json'
    return (Get-Content $AppJsonPath | ConvertFrom-Json)
}