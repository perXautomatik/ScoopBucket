cd (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)
. .\powerPieChart.ps1


(get-process | Group-Object -Property ProcessName | select Name, @{n='Mem';e={[int] ([math]::Round(($_.Group|Measure-Object WorkingSet64 -Sum).Sum / 1MB))}}) | Sort-Object mem -Descending | select -First 10 | Out-PieChart -DisplayToScreen