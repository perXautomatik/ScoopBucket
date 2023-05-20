


. ./getSomething1

get-something 'E:\Google Drive\Downloads\thot kute.json'


. ./getSomething2

 get-something 'E:\Google Drive\Downloads\thot kute.json' 
#to add adress column


. ./getSomething3


 get-something 'E:\Google Drive\Downloads\thot kute.json' 
#to add adress column


Invoke-Command -ScriptBlock 
{@{title=Extensions - OneTab; url=chrome://extensions/?id=chphlpgkkbolifaimnlloiipkdnihall; id=6YLMW5NfJhHgi2gNhqNSh1}}
  -ArgumentList *

Invoke-Command $i

$q ={@{r=r d;t=f}}

$q 


($q).GetEnumerator() | ForEach-Object{
    Write-Output "Key = $($_.key)"
    Write-Output "Value = $($_.value)"
    }


$q | ConvertFrom-Json

$q | ConvertFrom-StringData


$q | convertfrom-json


$hash = ($q)[0]

$hash | convertto-json

$hash | convertfrom-string



$hash | %{$_.r}

Import-LocalizedData $hash


ConvertFrom-StringData $hash

$hash.count

$ressult 
# https://powersnippets.com/union-object/

for-each json in path
{
    $temp = get-something(json)

    -join $temp, $ressult  
}


$ressult | Export-Csv -Path $item + 'csv' -Delimiter ';' -NoTypeInformation


. ./unionObject


<Object[]> | Union-Object [[-Property] <String[]>]