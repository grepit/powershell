$uri = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
$path = "$PSScriptRoot\ChromeStandaloneSetup64.exe" 
Invoke-WebRequest -Uri $uri -OutFile $path
& $path /install
