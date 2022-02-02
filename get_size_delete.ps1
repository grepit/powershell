#https://community.spiceworks.com/how_to/17736-run-powershell-scripts-from-task-scheduler
#https://docs.microsoft.com/en-us/powershell/scripting/learn/ps101/09-functions?view=powershell-7.2
#https://superuser.com/questions/1622534/specifying-log-file-for-a-scheduled-powershell-script

#get size for before and after
 function Get-Size-Dirs {
    param (
        [string[]]$ParameterName
    )

$props = @(
    'DriveLetter'
    'FileSystemLabel'
    'FileSystem'
    'DriveType'
    'HealthStatus'
    'OperationalStatus'
    @{
        Name = 'SizeRemaining'
        Expression = { "{0:N3} Gb" -f ($_.SizeRemaining/ 1Gb) }
    }
    @{
        Name = 'Size'
        Expression = { "{0:N3} Gb" -f ($_.Size / 1Gb) }
    }
    @{
        Name = '% Free'
        Expression = { "{0:P}" -f ($_.SizeRemaining / $_.Size) }
    }
)

Get-Volume -DriveLetter C, D | Select-Object $props | Format-Table

}

Get-Size-Dirs

#anything older than 15 days
$limit = (Get-Date).AddDays(-15)
$iis_dir = "C:\inetpub\logs\LogFiles\W3SVC1"
$apr_dir = "D:\Temp\AprisoLogs"
$filePathList =$iis_dir,$apr_dir
#$filePathList =$iis_dir

Foreach ($path in $filePathList)
{
# Delete files older than the $limit.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force

# Delete any empty directories left behind after deleting the old files.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse
}


Get-Size-Dirs
 
