#todo find original source, not created by me
#?#by Lee @ http://webcache.googleusercontent.com/search?q=cache:stackoverflow.com/questions/1001776/how-can-i-split-a-text-file-using-powershell

function splitFileLineByLine (
    $infile, 
    $parentPath,
    $upperBound # calculated by Powershell
)

if (test-path $infile)  #test to make sure the file exists
{
    $reader = new-object System.IO.StreamReader($infile)     
        $ext = [System.IO.Path]::GetExtension($infile)
        $fileName =  [System.IO.Path]::GetFileNameWithoutExtension($infile)
        #Get the CreationTime value from the file
        $creatonDate = (Get-ChildItem $infile).CreationTime
        $editDate = (Get-ChildItem $infile).ModificationTime
        $datum = If ($creatonDate -lt $editDate) {$creatonDate} Else {$editDate}

        $count = 1
        $rownr = 1
            while(($line = $reader.ReadLine()) -ne $null)
            {
            #Get-ChildItem $infile |
            $line | Select-String -Pattern "^(.*)|(\w{1,10})" |
                Foreach-Object {
                    # extracting captured groups, foreach will always be 1, because it's a single capture group
                    $content, $simplified = $_.Matches[0].Groups[1..2].Value   # this is a common way of getting the groups of a call to select-string
                    $rowobject = [PSCustomObject] @{
                        Summary = $simplified
                        content = $content
                        date = $datum
                        ext = $ext
                        rowNr = $rownr++
                    }

                    
                    $path = $parentPath -join ("{0}-{2}.{1}" -f ($rowobject.Summary,$rowobject.ext,$rowobject.date))
                    while([System.IO.File]::Exists($path) -OR (Get-ChildItem -path $path).Length -ge $upperBound)
                    {
                        ++$count
                        $path = $parentPath -join ("{0}{1}-{3}.{2}" -f ($count,$rowobject.Summary,$rowobject.ext,$rowobject.date))

                    }

                    Set-Content -path $path -value $rowobject.content
                    
                }
            }

    $reader.Close()
}
else
{
    #File did not exist, write that to the log also
    throw "fileNotFound"
}