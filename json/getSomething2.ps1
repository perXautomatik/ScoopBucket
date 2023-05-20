#to add adress column
Function Get-Something 
{
         [CmdletBinding()] param([Parameter(ValueFromPipeline)][pscustomobject]$Thing)
process{ ((Get-Content -Path $Thing | ConvertFrom-Json | select state).state | Convertfrom-Json).tabGroups | %{[pscustomobject] @{ creationDate = $_.creationDate; tabsmeta = $_.tabsmeta}} | forEach-object($_.tabmeta) {%{[pscustomobject] @{title = $_.title; creationDate = $_.createDate; url = $_.url}}}

        }
 } 
