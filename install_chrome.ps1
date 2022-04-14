$uri = "https://dl.google.com/chrome/install/ChromeStandaloneSetup64.exe"
$path = "$PSScriptRoot\ChromeStandaloneSetup64.exe" 
Invoke-WebRequest -Uri $uri -OutFile $path
& $path /install
