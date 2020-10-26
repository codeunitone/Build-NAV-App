# Build NAV App from Commandline

Inspired from these Blogpost http://dankinsella.blog/business-central-al-compiler/ I decided to implement a Powershell module which is downloading Symbols and compiling an AL Extension.

## Prerequisites

You need the AL compiler to build the extension from the command line. The compiler is part of the AL-Extension for VSCode. You find it on every Product DVD under `.\ModernDev\program files\Microsoft Dynamics NAV\<NAVVersionNo>\Modern Development Environment\ALLanguage.vsix`.
If you have the `Modern Dev Enviornment` installed it is locatet at `C:\Program Files (x86)\Microsoft Dynamics NAV\<NAVVersionNo>\Modern Development Environment\ALLanguage.vsix`.

Rename the `ALLanguage.vsix` to `ALLanguage.zip` and extract it somewhere. You will find the compiler under `.\extension\bin\alc.exe`

## Settings

By default this module is assuming the al compile is located at `C:\Program Files (x86)\Microsoft Dynamics NAV\110\Modern Development Environment\ALLanguage\extension\bin\alc.exe`

Please change `.CU1.NAV.BuildApp\config\settings.json` if the you have the AL compiler located somewhere else.


## Installation

You need to import the module to use it. Open PowerShell and run following command

```PowerShell
Import-Module .\CU1.NAV.BuildApp\CU1.NAV.BuildApp.psd1
```

If you want to have the module loaded everytime you open a new PowerShell session, add thatline to your PowerShell Profile.


## Usage

The cmdlet either loading everything they need from the `.\app.json` and `.\.vscode\launch.json` of your AL project folder or getting the information from the parameters.

### Download symbols

To build succesfully an AL App you need to download all symbols you are referencing in your application.

* System Objects
* NAV Standard Application Objects
* Other depending AL Applications

To download the Symbols of the System Objects run folling command. 

```PowerShell
Download-cu1NavSymbols `
	-ProjectFolder <PathToYourALApp> `
	-Environment <Environment> `
	-Publisher Microsoft `
	-AppName System `
	-AppVersion 11.0.12925.0;
```

That Example is for NAV 2018 CU15

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
			"server": "<replace with PRE-PROD server>",
			"serverInstance": "DynamicsNAV110",
			"authentication": "Windows",
			"schemaUpdateMode": "Synchronize",
			"startupObjectId": 22
		},
		{
			"type": "al",
			"request": "launch",
			"name": "PROD",
			"server": "<replace with PROD server>",
			"serverInstance": "DynamicsNAV110",
			"authentication": "Windows",
			"schemaUpdateMode": "Synchronize",
			"startupObjectId": 22
		}
	]
}
```

If you need more, less or environment with other names just change your `lauch.json` and the ValidateSet for the Environment parameter of `Download-NavSymbols.ps1`. 

### Build

The cmdlet `Build-Cu1NavApp` is building you application and saves the binary (*.app file) in the root folder you AL project. The filename is a cocatination of Publisher, Name and Version you specified in the `app.json`

## Deploy

After the Extension is build you can deploy it with following cmdlets (in that order). These cmdlets are part of the NAV Admin Shell.

* Publish-NAVAp
* Sync-NAVApp
* Install-NAVApp