. D:\Documents\WindowsPowerShell\Scripts\SymLinks\MakeSoftlink.ps1

cd (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)


$repos = get-content .\gitConfigsToAddAsSubmodules.txt | %{ Split-Path -Path $_ -Parent} | %{ Split-Path -Path $_ -Parent} | unique 

cd submodule
$repos | % { MakeSoftLink $_ }