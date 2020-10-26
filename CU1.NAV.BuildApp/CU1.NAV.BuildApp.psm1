foreach ($file in $(Get-ChildItem -Path $(Join-Path $PSScriptRoot -ChildPath '.\Public') -Recurse -Filter '*.ps1')) {	. $file.fullname}
