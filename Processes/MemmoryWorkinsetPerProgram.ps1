$sum = 0
Get-Process | sort name -unique | ForEach-Object { $sum +=(Get-Process $_.Name | Measure-Object WorkingSet -sum).sum/1Gb
" " + [math]::round((Get-Process $_.Name | Measure-Object WorkingSet -sum).sum/1Gb,2) + " " + $_.name + [math]::round($sum,2) + " "} | sort
