
param($drive1, $drive2, $drive3)
$diskdata = get-PSdrive $drive1 | Select-Object Used,Free
write-host "$($drive1) has  $($diskdata.Used) Used and $($diskdata.Free) free"
if ($drive2 -ne $null) {
$diskdata = get-PSdrive $drive2 | Select-Object Used,Free
write-host "$($drive2) has  $($diskdata.Used) Used and $($diskdata.Free) free"
    if ($drive3 -ne $null) {
    $diskdata = get-PSdrive $drive3 | Select-Object Used,Free
    write-host "$($drive3) has  $($diskdata.Used) Used and $($diskdata.Free) free"
    }
    else
    { return}
}
else
{return} # don't bother testing for drive3 since we didn't even have 
