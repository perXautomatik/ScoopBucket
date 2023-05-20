#to add adress column
Function Get-Something 
{
         [CmdletBinding()] param([Parameter(ValueFromPipeline)][pscustomobject]$Thing)
process{ $tabgroups=((Get-Content -Path $Thing | ConvertFrom-Json | select state).state | Convertfrom-Json).tabGroups ;
            $result = @();
         $set = @(foreach($creationDate in $tabgroups.createDate){[pscustomobject] @{ creationDate = $creationDate; tabsmeta = $tabgroups.tabsmeta}}) 

         $result = @(foreach($element in $set.tabsmeta){[pscustomobject] @{ title = $element.title; creationDate = $set.createDate; url = $element.url}}) ; $result 
        }
 } 

