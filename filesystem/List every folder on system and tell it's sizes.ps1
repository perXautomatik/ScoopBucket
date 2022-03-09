Import-Module SplitPipeline

. .recuse


$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$outputlist = Recurse($scriptPath)

Get-ChildItem -Path C:\ -Recurse -Directory -Force -ErrorAction SilentlyContinue | Split-Pipeline -count 4 -load 4 {process{

	$Directory = $_.FullName

	
    if (Test-Path -Path $Directory)
    {
    $size = 0;
	    Get-ChildItem -Path $Directory -File | ForEach-Object {$size += $_.Length}
		
	[PSCustomObject]@{'Directory' = $Directory; 'SizeInMB' = $size / 1MB}
    }
    else
    {
	Write-Error "Cannot find directory: $Directory"
    }
}} | Where-Object {$_.sizeInMb -gt 100} | Sort-Object sizeInMb,Directoty –Descending


