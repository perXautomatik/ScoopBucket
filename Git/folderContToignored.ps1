Function addToIgnored {
    [CmdletBinding()]
    param (
    
        [Parameter(Mandatory=$true,
                    HelpMessage=" root dir to")] 
        [string]$root,
    
        [Parameter(Mandatory=$false,
                    HelpMessage=" excluded dirs ")] 
        [string]$excluded
    )

ls -path $root | Where-Object { $_.Name -notin $exluded } > .gitignore

}