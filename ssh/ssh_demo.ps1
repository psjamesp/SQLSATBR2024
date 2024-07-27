# Install the OpenSSH Client and Server
 
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
 
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
 
# Initial Configuration of SSH Server
 
Start-Service sshd
 
Set-Service -Name sshd -StartupType 'Automatic'
 
# Confirm the Firewall rule is configured. It should be created automatically by setup.
 
Get-NetFirewallRule -Name *ssh*
 
# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled

code $env:ProgramData\sshd\sshd_config


# set default shell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force

# enable PowerShell subsystem for SSH
$sshdConfigPath = "C:\ProgramData\ssh\sshd_config"
$lines = Get-Content -Path $sshdConfigPath
$sftpLine = $lines | Select-String -Pattern "Subsystem`tsftp" | Select-Object LineNumber

$newLine = "Subsystem powershell C:/PROGRA~1/PowerShell/7/pwsh.exe -sshs `n"
$lines = $lines[0..($sftpLine.LineNumber)] + $newLine + $lines[($sftpLine.LineNumber+1)..($lines.Length-1)]
$lines | Out-File -FilePath $sshdConfigPath


Enter-PSSession -HostName ubuntu -UserName superadmin

Enter-PSSession -ComputerName dc01 -Credential 714tech\bob
Enter-PSSession -HostName dc01 -UserName 714tech\bob

invoke-command -HostName dc01 -ScriptBlock {Write-Output "My name is $env:computername" }


$mysession = New-PSSession -HostName dc01,srv01,srv02 -UserName 714tech\bob



# Install the OpenSSH Client and Server
 
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
 
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
 
# Initial Configuration of SSH Server
 
Start-Service sshd
 
Set-Service -Name sshd -StartupType 'Automatic'
 
# Confirm the Firewall rule is configured. It should be created automatically by setup.
 
Get-NetFirewallRule -Name *ssh*
 
# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled

code $env:ProgramData\ssh\sshd_config

PasswordAuthentication yes

Subsystem powershell c:/progra~1/powershell/7/pwsh.exe -sshs -NoLogo -NoProfile

PubkeyAuthentication yes