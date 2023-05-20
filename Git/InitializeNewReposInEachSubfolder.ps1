
Function NewRepo {
    [CmdletBinding()]
    param (
    
        [Parameter(Mandatory=$true,
                    HelpMessage=" root dir to")] 
        [string]$root,
    
        [Parameter(Mandatory=$false,
                    HelpMessage=" excluded dirs ")] 
        [string]$excluded
    )
#'PortableApps.com'
$root
Get-ChildItem $root | Where-Object { $_.Name -notin $exluded }  |%{ git init $_ }

}