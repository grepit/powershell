dism /online /Enable-Feature /FeatureName:TelnetClient
## if above does not work you can try this:
Enable-WindowsOptionalFeature -Online -FeatureName "TelnetClient"

## another approach
dism /online /Enable-Feature /FeatureName:TelnetClient
# yoo can also use this instead of telnet
Test-NetConnection some_ip_here -Port 22

# for linux netcat
nc -zv some_ip_here 80
