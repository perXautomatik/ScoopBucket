Function Get-Something {

            [CmdletBinding()]

            Param($item)
        
            ((Get-Content -Path $item | ConvertFrom-Json | select state).state | Convertfrom-Json).tabGroups |
 % { $_.tabsmeta } | Export-Csv -Path $item + 'csv' -Delimiter ';' -NoTypeInformation

}

