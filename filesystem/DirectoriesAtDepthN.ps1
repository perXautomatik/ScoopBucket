Function ListDirectoriesAtDepth {
[CmdletBinding()]
param (

    [Parameter(Mandatory=$false,
                HelpMessage="current folder or provided")] 
    [string]$root,

    [Parameter(Mandatory=$true,
                HelpMessage="depth")] 
    [int]$depth
)
PROCESS {

Get-ChildItem $root -Directory -Recurse -Depth $depth 

}
}
