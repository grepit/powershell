$logs = Get-WinEvent -FilterHashtable @{
    LogName = 'Application', 'System'
    Level = 2
}

foreach ($log in $logs) {
    $eventTime = $log.TimeCreated
    $formattedTime = $eventTime.ToString('yyyy-MM-dd HH:mm:ss')
    
    Write-Host "Event ID: $($log.Id)"
    Write-Host "Level: $($log.LevelDisplayName)"
    Write-Host "Source: $($log.ProviderName)"
    Write-Host "Message: $($log.Message)"
    Write-Host "Date and Time: $formattedTime"
    Write-Host "------------------------"
}
