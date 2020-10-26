# Build NAV App from Commandline

Inspired from these Blogpost http://dankinsella.blog/business-central-al-compiler/ I decided to implement it and provide the Scripts for everyone.

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

## Build

This script is building you application and saves the binary (*.app file) in the root folder you AL project. The filename is a cocatination of Publisher, Name and Version you specified in the `app.json`


# Deploy

After the Extension is build you can deploy it with following cmdlets (in that order). These cmdlets are part of the NAV Admin Shell.

* Publish-NAVAp
* Sync-NAVApp
* Install-NAVApp