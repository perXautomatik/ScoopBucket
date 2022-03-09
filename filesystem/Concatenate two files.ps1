##Copied from: How do I concatenate two text files in PowerShell? - Stack Overflow - 2020-10-15 14:30:22 - <https://stackoverflow.com/questions/8749929/how-do-i-concatenate-two-text-files-in-powershell>
##Simply use the Get-Content and Set-Content cmdlets:
##You can concatenate more than two files with this style, too.
##If the source files are named similarly, you can use wildcards:

Get-Content inputFile1.txt, inputFile2.txt | Set-Content joinedFile.txt


Get-Content inputFile*.txt | Set-Content joinedFile.txt

