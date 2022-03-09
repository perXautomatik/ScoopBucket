Function ListDirectoriesAtDepth {
[CmdletBinding()]
param (

    [Parameter(Mandatory=$false,
                HelpMessage="what to link")] 
    [string]$root,

    [Parameter(Mandatory=$true,
                HelpMessage="where to create link")] 
    [int]$depth
)
PROCESS {

Get-ChildItem $root -Directory -Recurse -Depth $depth 

}