#For PowerShell v3
Function gig {
  param(
    [Parameter(Mandatory=$true)]
    [string[]]$list
  )
  $params = ($list | ForEach-Object { [uri]::EscapeDataString($_) }) -join ","
  Invoke-WebRequest -Uri "https://www.toptal.com/developers/gitignore/api/$params" | select -ExpandProperty content | Out-File -FilePath $(Join-Path -path $pwd -ChildPath ".gitignore") -Encoding ascii
}

gig git,DiskImage,CompressedArchive,Audio,diff,Audio,Images,JetBrains,Linux,lua,MicrosoftOffice,Node,PowerShell,Renpy,TortoiseGit,Unity,VisualBasic,VisualStudioCode,Windows,vs >> ~/.gitignore_global