function Get-SymbolPath {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $ProjectFolder
    )
    
    $SymbolPath = Join-Path $ProjectFolder -ChildPath '.alpackages'

    return  $SymbolPath
}