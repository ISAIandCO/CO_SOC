$paths = $PSScriptRoot
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    break
}
cd $paths

if ($A=Read-Host "Нижняя граница в формате дд.мм.гг чч:мм:сс [Отсутствует]") {
    $A=Get-Date -Format "yyyy-MM-ddTHH:mm:ss" ([datetime](Get-Date $A)).AddHours(-5)
    if ($B=Read-Host "Верхняя граница в формате дд.мм.гг чч:мм:сс [Отсутствует]") {$B=Get-Date -Format "yyyy-MM-ddTHH:mm:ss" ([datetime](Get-Date $B)).AddHours(-5)}
    else {$B=Get-Date -Format "yyyy-MM-ddTHH:mm:ss" ([datetime](Get-Date)).AddHours(-5)}
    $q="*[System[TimeCreated[@SystemTime>='$A' and @SystemTime<'$B']]]"
} else {$q='*'}

$logs = @(@('Microsoft-Windows-Dhcp-Client/Admin','Microsoft-Windows-Dhcp-Client_Admin'),
@('Microsoft-Windows-Kernel-Boot/Operational','Microsoft-Windows-Kernel-Boot_Operational'),
@('Microsoft-Windows-PrintService/Admin','Microsoft-Windows-PrintService_Admin'),
@('Microsoft-Windows-SmbClient/Connectivity','Microsoft-Windows-SmbClient_Connectivity'),
@('Microsoft-Windows-SmbClient/Security','Microsoft-Windows-SmbClient_Security'),
@('Microsoft-Windows-TerminalServices-LocalSessionManager/Operational','Microsoft-Windows-TerminalServices-LocalSessionManager_Operational'),
@('Microsoft-Windows-TerminalServices-RDPClient/Operational','Microsoft-Windows-TerminalServices-RDPClient_Operational'),
@('Microsoft-Windows-UAC-FileVirtualization/Operational','Microsoft-Windows-UAC-FileVirtualization_Operational'),
@('Microsoft-Windows-Windows Defender/Operational','Microsoft-Windows-Windows Defender_Operational'),
@('Microsoft-Windows-Windows Firewall With Advanced Security/Firewall','Microsoft-Windows-Windows Firewall With Advanced Security_Firewall'),
@('Microsoft-Windows-Windows Firewall With Advanced Security/FirewallDiagnostics','Microsoft-Windows-Windows Firewall With Advanced Security_FirewallDiagnostics'),
@('Microsoft-Windows-Winlogon/Operational','Microsoft-Windows-Winlogon_Operational'),
@('Microsoft-Windows-WMI-Activity/Operational','Microsoft-Windows-WMI-Activity_Operational'),
@('Security','Security'),
@('System','System'),
@('Windows PowerShell','Windows PowerShell'),
@('Application','Application'),
@('Kaspersky Endpoint Security','Kaspersky Endpoint Security'),
@('Kaspersky Event Log','Kaspersky Event Log'),
@('Microsoft-Windows-PowerShell/Operational','Microsoft-Windows-PowerShell_Operational'),
@('Microsoft-Windows-Policy/Operational','Microsoft-Windows-Policy_Operational'),
@('Microsoft-Windows-NetworkProfile/Operational','Microsoft-Windows-NetworkProfile_Operational'),
@('Microsoft-Windows-GroupPolicy/Operational','Microsoft-Windows-GroupPolicy_Operational'),
@('Microsoft-Windows-TaskScheduler/Operational','Microsoft-Windows-TaskScheduler_Operational'),
@('Microsoft-Windows-TaskScheduler/Maintenance','Microsoft-Windows-TaskScheduler_Maintenance'),
@('Microsoft-Windows-RemoteApp and Desktop Connections/Operational','Microsoft-Windows-RemoteApp and Desktop Connections_Operational'),
@('Microsoft-Windows-User Profile Service/Operational','Microsoft-Windows-User Profile Service_Operational')
)

foreach ($log in $logs) {
    $in=$log[0]
    $out=$log[1]
    wevtutil epl $in "$out.evtx" /q:"$q"
}
