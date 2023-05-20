


Function Get-Something {[CmdletBinding()] param([Parameter(ValueFromPipeline)][pscustomobject]$Thing)
process{

$hash = $null
$hash = @{}
$proc = ((Get-Content -Path $Thing | ConvertFrom-Json | select state).state | Convertfrom-Json).tabGroups
$ressult = @()

foreach ($p in $proc) {$hash.add($p.createDate,$p.tabsmeta)}

foreach ($p in $hash.GetEnumerator())
{$creationDate = $p.key
    foreach ($v in $p.value){ $ressult += [pscustomobject] @{ creationDate = $creationDate; title = $v.title ; url = $v.url}}
};$ressult
}}

. ./unionObject

$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path 'transcribe.txt'
# Do some stuff
$(

    get-childitem -Filter '*.json' | %{($_ | Get-Item).FullName } | Get-Something | Union-Object -Property 'creationDate','url','title' | Sort url,title -Unique | Export-Csv -Path 'i.csv' -Delimiter ';' -NoTypeInformation
    If ($ProcessError) {

        ####### Something went wrong
        Write-Warning -Message
    }

) *>&1 > output.txt
Stop-Transcript

