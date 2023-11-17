dism /online /Enable-Feature /FeatureName:TelnetClient
## if above does not work you can try this:
Enable-WindowsOptionalFeature -Online -FeatureName "TelnetClient"

## another approach
dism /online /Enable-Feature /FeatureName:TelnetClient
