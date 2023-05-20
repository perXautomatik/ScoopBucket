#by Lee @ http://webcache.googleusercontent.com/search?q=cache:stackoverflow.com/questions/1001776/how-can-i-split-a-text-file-using-powershell
$upperBound = 50MB # calculated by Powershell


$reader = new-object System.IO.StreamReader($Args[0])
$ext = "log"
$rootName = "log_"
$count = 1
$fileName = "{0}{1}.{2}" -f ($rootName, $count, $ext)

while(($line = $reader.ReadLine()) -ne $null)
{
    Add-Content -path $fileName -value $line
    if((Get-ChildItem -path $fileName).Length -ge $upperBound)
    {
        ++$count
        $fileName = "{0}{1}.{2}" -f ($rootName, $count, $ext)
    }
}

$reader.Close()