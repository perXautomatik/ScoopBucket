# first get small tumbnail, then calculate, then pair with one of digicams colour tags.

$filename = "E:\PuffinPron\puffpron2018\image004 (2).jpg"
$BitMap = [System.Drawing.Bitmap]::FromFile((Get-Item $filename).fullname) 

$R=0;
$G=0;
$B=0;
$A=0;
$i=0;

# A hashtable to keep track of the colors we've encountered
$table = @{}
foreach($h in 1..$BitMap.Height){
  foreach($w in 1..$BitMap.Width) {
    # Assign a value to the current Color key
    $table[$BitMap.GetPixel($w - 1,$h - 1)] = $true
  }
}

# The hashtable keys is out palette
$palette = $table.Keys



Foreach($pixel in $palette){ 
$i++;

$R = $R +  [int]($Pixel | select -ExpandProperty R)
$G = $G +  [int]($Pixel | select -ExpandProperty G)
$B = $B + [int]($Pixel | select -ExpandProperty B)
$A = $A +  [int]($Pixel | select -ExpandProperty A)

}

$R=[math]::Round($R/$i);
$G=[math]::Round($G/$i);
$B=[math]::Round($B/$i);
$A=[math]::Round($A/$i);

$allClr = "$R . $G . $B . $A" 
$allClr
