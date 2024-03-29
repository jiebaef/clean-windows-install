# Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope LocalMachine
# Run script as admin

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ( -Not ($isAdmin) ) {
    Write-Error "Please execute this script with admin privileges"
    exit
}

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds"
$name = "EnableFeeds"
$value = "0"
 
$registryPath2 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds"
$name2 = "ShellFeedsTaskbarViewMode"
$value2 = "2"
 
if ( -Not ( Test-Path $registryPath ) ) {
    New-Item -Path $registryPath -ItemType RegistryKey -Force
}
 
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
 
if ( -Not ( Test-Path $registryPath2 ) ) {
    New-Item -Path $registryPath2 -ItemType RegistryKey -Force
}
 
New-ItemProperty -Path $registryPath2 -Name $name2 -Value $value2 -PropertyType DWORD -Force | Out-Null

Invoke-WebRequest -useb https://git.io/debloat | Invoke-Expression
