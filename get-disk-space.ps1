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

Get-Volume | Select-Object $props | Format-Table
