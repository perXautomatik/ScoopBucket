
function Recurse($path) {

  $fc = new-object -com scripting.filesystemobject
  $folder = $fc.getfolder($path)

  foreach ($i in $folder.files) { $i | select Path }

  foreach ($i in $folder.subfolders) {
    $i | select Path        
    if ( (get-item $i.path).Attributes.ToString().Contains("ReparsePoint") -eq $false) {        
        Recurse($i.path)
    }
  }
}