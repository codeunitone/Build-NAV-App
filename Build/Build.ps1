$ALCompilerPath = 'C:\Program Files (x86)\Microsoft Dynamics NAV\110\Modern Development Environment\ALLanguage\extension\bin\alc.exe'

# Define root folder of this Extension
$ProjectPath = Split-Path -parent $PSScriptRoot

# Read app.json settings
$AppJsonPath = Join-Path $ProjectPath -ChildPath 'app.json'
$AppSetting = (Get-Content $AppJsonPath | ConvertFrom-Json)

# Define location of symbols
$PackageCachePath = Join-Path $ProjectPath -ChildPath '.alpackages'

# Build app Name and define location off the compiled app
$AppName = '{0}_{1}_{2}.app' -f $AppSetting.publisher, $AppSetting.name, $AppSetting.version
$OutPath = Join-Path $ProjectPath -ChildPath $AppName

#Debug info: Feedback of defined paths and names
Write-Host "ALCompilerPath: $ALCompilerPath" -ForegroundColor Cyan
Write-Host "ProjectPath: $ProjectPath" -ForegroundColor Cyan
Write-Host "PackageCachePath: $PackageCachePath" -ForegroundColor Cyan
Write-Host "OutPath: $OutPath" -ForegroundColor Cyan

# Build App
& $ALCompilerPath /project:"$ProjectPath" /packagecachepath:"$PackageCachePath" /out:"$OutPath"

