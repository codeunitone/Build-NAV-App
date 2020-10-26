# Build NAV App from Commandline

Inspired from these Blogpost http://dankinsella.blog/business-central-al-compiler/ I decided to implement it and provide the Scripts for everyone.

## Prerequisites

You need the AL compiler to build the extension from the command line. The compiler is part of the AL-Extension for VSCode. You find it on every Product DVD under `.\ModernDev\program files\Microsoft Dynamics NAV\<NAVVersionNo>\Modern Development Environment\ALLanguage.vsix`.
If you have the `Modern Dev Enviornment` instlled it is locatet at `C:\Program Files (x86)\Microsoft Dynamics NAV\<NAVVersionNo>\Modern Development Environment\ALLanguage.vsix`.

Rename the `ALLanguage.vsix` to `ALLanguage.zip` and extract it somewhere. You will find the compiler under `.\extension\bin\alc.exe`

## Usage

Copy the `Build` folder into you AL Extension folder. 

The scripts are loading everything they need from the `.\app.json` and `.\.vscode\launch.json` of your AL project folder.

### Download symbols

The Script assumes you do have following environments configured in your ``.\.vscode\launch.json`.

* localhost
* dev
* test
* pre-prod
* prod

Here is an example of that `launch.json` for NAV 2018

```json
{
	"version": "0.2.0",
	"configurations": [
		{
			"type": "al",
			"request": "launch",
			"name": "localhost",
			"server": "http://localhost",
			"serverInstance": "DynamicsNAV110",
			"authentication": "Windows",
			"startupObjectId": 130401,
			"schemaUpdateMode": "Synchronize"
		},
		{
			"type": "al",
			"request": "launch",
			"name": "DEV",
			"server": "<replace with DEV server>",
			"serverInstance": "DynamicsNAV110",
			"authentication": "Windows",
			"schemaUpdateMode": "Synchronize",
			"startupObjectId": 22
		},
		{
			"type": "al",
			"request": "launch",
			"name": "TEST",
			"server": "<replace with TEST server>",
			"serverInstance": "DynamicsNAV110",
			"authentication": "Windows",
			"schemaUpdateMode": "Synchronize",
			"startupObjectId": 22
		},
		{
			"type": "al",
			"request": "launch",
			"name": "PRE-PROD",
			"serverreplace with PRE-PROD server>",
			"serverInstance": "DynamicsNAV110",
			"authentication": "Windows",
			"schemaUpdateMode": "Synchronize",
			"startupObjectId": 22
		},
		{
			"type": "al",
			"request": "launch",
			"name": "PROD",
			"serverreplace with PROD server>",
			"serverInstance": "DynamicsNAV110",
			"authentication": "Windows",
			"schemaUpdateMode": "Synchronize",
			"startupObjectId": 22
		}
	]
}
```

If you need more, less or environment with other names just change your `lauch.json` and the ValidateSet for the Environment parameter of `Download-Symbols.ps1`

```powershell
param (
    [Parameter(Mandatory = $true)]
    [ValidateSet('localhost', 'dev', 'test', 'pre-prod', 'prod')]
    [string]
    $Environment
)
```

### Build

This script is building you application and saves the binary (*.app file) in the root folder you AL project. The filename is a cocatination of Publisher, Name and Version you specified in the `app.json`

The scrip is assuming that you do have the AL compiler located at `'C:\Program Files (x86)\Microsoft Dynamics NAV\110\Modern Development Environment\ALLanguage\extension\bin\alc.exe'`

## Deploy

After the Extension is build you can deploy it with following cmdlets (in that order). These cmdlets are part of the NAV Admin Shell.

* Publish-NAVAp
* Sync-NAVApp
* Install-NAVApp