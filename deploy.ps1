<# 
.SYNOPSIS
Moves the custom symbol to the PI Vision extensibility folder, only works on the PI Vision machine

.DESCRIPTION
Automates the deployment of this custom sybmol for use in testing

.EXAMPLE
PS C:\Sample> .\deploy.ps1

#>

$pihome = $env:PIHOME64
$symbolFolder = $pihome + "PIVision\Scripts\app\editor\symbols\ext"

if (-Not (Test-Path $symbolFolder)) {
    Write-Host "Not on the PI Vision server or ext folder is missing"
    Read-Host 
    exit
}

$files = @("sym-sendvalue.js", "sym-sendvalue-config.html", "sym-sendvalue-template.html")
foreach ($file in $files) {
    $source = $PSScriptRoot + "\" + $file
    $target = $symbolFolder
    Copy-Item $source $target
}

$libraries = @("underscore-min.js")
foreach ($library in $libraries) {
    $source = $PSScriptRoot + "\" + $library
    $target = $symbolFolder + "\libraries"

    Copy-Item $source $target
}

$icons = @("sym-sendvalue.svg")
foreach ($icon in $icons) {
    $source = $PSScriptRoot + "\" + $icon
    $target = $symbolFolder + "\icons"

    Copy-Item $source $target
}


<#
$urls = @("https://localhost/PIVision/#/Displays/AdHoc?dataitems=%5C%5CJLEFEBVRE7390%5CVisy%5CRoll1%7CActual%20GSM&symbol=thresholdtrend", 
           "https://localhost/PIVision/#/Displays/20107/garbage")
foreach ($url in $urls) {
    start microsoft-edge:$url
}#>
<#
Start-Process microsoft-edge:https://localhost/PIVision/#/Displays/40127/Phase-6-invisible
$wshell = New-Object -ComObject wscript.shell;
Start-Sleep 5
$wshell.SendKeys('{F12}')
Start-Sleep 5
$wshell.SendKeys('^p')
Start-Sleep 5
$wshell.SendKeys('localhost/PIVision/Scripts/app/editor/symbols/ext/sym-thresholdDigitalBar.js')
Start-Sleep 5
$wshell.SendKeys('{ENTER}')
#>