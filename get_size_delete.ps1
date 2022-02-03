#https://community.spiceworks.com/how_to/17736-run-powershell-scripts-from-task-scheduler
#https://docs.microsoft.com/en-us/powershell/scripting/learn/ps101/09-functions?view=powershell-7.2
#https://superuser.com/questions/1622534/specifying-log-file-for-a-scheduled-powershell-script

#need to create a config file called C:\jobs\config.txt

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

#anything older than 15 days will be deleted
$limit = (Get-Date).AddDays(-15)
$configPathFile = "C:\jobs\config.txt"
#read the input file for all the directories we need to clean 
$filePathList = Get-Content -Path @($configPathFile)

Foreach ($path in $filePathList)
{
write-host "cleaning ..."
write-host $path
# Delete files older than the $limit.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force

# Delete any empty directories left behind after deleting the old files.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse
}


Get-Size-Dirs
 
