    function updateFileSystemInfo([System.IO.FileSystemInfo]$fsInfo) {
      $datetime = get-date
      if ( $only_access )
      {
         $fsInfo.LastAccessTime = $datetime
      }
      elseif ( $only_modification )
      {
         $fsInfo.LastWriteTime = $datetime
      }
      else
      {
         $fsInfo.CreationTime = $datetime
         $fsInfo.LastWriteTime = $datetime
         $fsInfo.LastAccessTime = $datetime
       }
    }