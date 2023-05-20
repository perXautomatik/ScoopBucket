function presentJson {
param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)][PSCustomObject] $input
  )

$json = [ordered]@{}

($input).PSObject.Properties |
    ForEach-Object { $json[$_.Name] = $_.Value }

$json.SyncRoot
}