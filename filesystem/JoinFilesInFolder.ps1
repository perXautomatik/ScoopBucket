Set-PSDebug -Trace 2

get-childItem | foreach {
 
 $output = '' + $_.Directory + '\merge.txt'

[System.IO.File]::AppendAllText($output , [System.IO.File]::ReadAllText($_.FullName))
}