
##Windows 10 (and Powershell 5.0 in general) allows you to create symbolic links via the New-Item cmdlet.

##Usage:

New-Item -Path "C:\Users\crbk01\OneDrive - Region Gotland\WindowsPowerShell\PSReadline" -ItemType Junction -Value "C:\Users\crbk01\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline"
##Or in your profile:

function make-link ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}
##Turn on Developer Mode to not require admin privileges when making links with New-Item:

##Copied from: symlink - Creating hard and soft links using PowerShell - Stack Overflow - 2020-10-15 14:34:42 - <https://stackoverflow.com/questions/894430/creating-hard-and-soft-links-using-powershell>