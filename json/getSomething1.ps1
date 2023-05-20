
Function Get-Something {[CmdletBinding()] param([Parameter(ValueFromPipeline)][pscustomobject]$Thing)
        process{

        $hash = $null

        $hash = @{}

        $proc = ((Get-Content -Path $Thing | ConvertFrom-Json | select state).state | Convertfrom-Json).tabGroups

        $ressult = @()

        foreach ($p in $proc)
        {
            $hash.add($p.createDate,$p.tabsmeta)
        }

        foreach ($p in $hash.GetEnumerator())
        {
            $creationDate = $p.key
        foreach ($v in $p.value)
        {
            $ressult += [pscustomobject] @{ creationDate = $creationDate; title = $v.title ; url = $v.url}
        }

        }


        ;
    $ressult
    }
}