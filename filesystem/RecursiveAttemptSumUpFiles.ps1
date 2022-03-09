<#
  simple recursive method listing every folder in a branching from path and it's total size
  error do occure in first try catch when filenames is corrupted or simmilar, therefore the catch whom should spread some info


#>
$Tab = [char]9


. ./RecurseX

RecurseX 'E:\' 6>> C:\Ressult.csv

robocopy /?


Clear-Host
$ErrorActionPreference = "Continue"
$DebugPreference = "Continue"
$VerbosePreference = "Continue"

@"

## robocopy_helper.ps1 ########################################################
Usage:        powershell -ExecutionPolicy Bypass -File ./robocopy_helper.ps1

Purpose:      Dry run before Full run of robocopy
src: https://serverfault.com/questions/611950/how-to-get-robocopy-summary-information-involved-in-powershell
History:      07/11/2014  -  Created
###############################################################################

"@

## User Supplied Variables
$cSrc = "E:\.vscode"
$cDst = "C:\Temp2"
$cLog = "c:\robo.log"

## Robocopy Dry Run
$robo_test = robocopy "$cSrc" null /L /S /NJH /BYTES /FP /NC /XJ /TS /R:0 /W:0 /NJH /NJS /S /LEV:1

## Use Regular Expression to grab the following Table
#               Total    Copied   Skipped  Mismatch    FAILED    Extras
#    Dirs :         1         0         1         0         0         0
#   Files :         1         0         1         0         0         0
$robo_results = $robo_test -match '^(?= *?\b(Total|Dirs|Files)\b)((?!    Files).)*$'

## Convert Table above into an array
$robo_arr = @()
foreach ($line in $robo_results){
    $robo_arr += $line
}

## Create Powershell object to tally Robocopy results
$row = "" |select COPIED, MISMATCH, FAILED, EXTRAS

$row.COPIED = [int](($robo_arr[1] -split "\s+")[4]) + [int](($robo_arr[2] -split "\s+")[4])
$row.MISMATCH = [int](($robo_arr[1] -split "\s+")[6]) + [int](($robo_arr[2] -split "\s+")[6])
$row.FAILED = [int](($robo_arr[1] -split "\s+")[7]) + [int](($robo_arr[2] -split "\s+")[7])
$row.EXTRAS = [int](($robo_arr[1] -split "\s+")[8]) + [int](($robo_arr[2] -split "\s+")[8])

## If there are differences, lets kick off robocopy again
if ( ($row.COPIED + $row.MISMATCH + $row.FAILED + $row.EXTRAS) -gt 0 ){
    robocopy "$cSrc" "$cDst" /MIR /FFT /Z /W:5 /MT:64 /XX /log:$cLog
    Invoke-item $cLog
}
else { Write-host "Folders '$cSrc' and '$cDst' are twins" }