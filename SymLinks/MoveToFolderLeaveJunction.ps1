param(
[string]$InputPath
)

. ./GetFolder

$src = $inputPath
$parent = $src | split-path
$child = ($src | split-path -leaf)
$dest = Get-Folder | Join-Path -ChildPath $child
$num=1

Get-ChildItem -Path $src -Recurse | ForEach-Object {
    
    $item = $_
    $nextName = Join-Path -Path $dest -ChildPath $item.name

    while(Test-Path -Path $nextName)
    {
       $nextName = Join-Path $dest ($item.BaseName + "_$num" + $item.Extension)    
       $num+=1   
    }

$fullName = $item.FullName

if (!([system.io.directory]::Exists($dest))){
   [system.io.directory]::CreateDirectory($dest)
}
    Move-Item -path $fullName -Destination $nextName
}
remove-item $inputPath 
cd $parent
New-Item -ItemType Junction -path $parent -name $child -Target $dest
