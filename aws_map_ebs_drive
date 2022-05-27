#Step 1 run this  to get disk number and Volumne ID
"C:\PROGRAMDATA\Amazon\Tools\ebsnvme-id.exe"

#step 2 run this to get which drive maps to which disk number 
Get-WmiObject Win32_DiskDrive | ForEach-Object {
  $disk = $_
  $partitions = "ASSOCIATORS OF " +
                "{Win32_DiskDrive.DeviceID='$($disk.DeviceID)'} " +
                "WHERE AssocClass = Win32_DiskDriveToDiskPartition"
  Get-WmiObject -Query $partitions | ForEach-Object {
    $partition = $_
    $drives = "ASSOCIATORS OF " +
              "{Win32_DiskPartition.DeviceID='$($partition.DeviceID)'} " +
              "WHERE AssocClass = Win32_LogicalDiskToPartition"
    Get-WmiObject -Query $drives | ForEach-Object {
      New-Object -Type PSCustomObject -Property @{
        Disk        = $disk.DeviceID
        DiskSize    = $disk.Size
        DiskModel   = $disk.Model
        Partition   = $partition.Name
        RawSize     = $partition.Size
        DriveLetter = $_.DeviceID
        VolumeName  = $_.VolumeName
        Size        = $_.Size
        FreeSpace   = $_.FreeSpace
      }
    }
  }
}
