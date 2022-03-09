. ./splitFileLineByLine
    $infile = "E:\OneDrive\Dokument\Desktop\New folder (2)\Unknown\Diska.txt"
    $parentPath = Split-Path -parent $infile
    $upperBound = 50MB 

splitFileLineByLine $infile $parentPath $upperBound

