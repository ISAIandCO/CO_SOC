$WebClient = new-object System.Net.WebClient
$WebClient.Headers.Add(“user-agent”, “PowerShell Script”)
$WebClient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls, Ssl3"

function DownloadThisTo ([string]$url, [string]$path) {
    try {
	$lfs = Get-ChildItem -Path $path | Measure-Object -Property Length -Sum
	$rfs = (Invoke-WebRequest $url -Method Head).Headers.'Content-Length'
	    if ($lfs.sum -ne $rfs) {
            "Обновляется файл: $path"
            $WebClient = New-Object System.Net.WebClient
            $WebClient.DownloadFile($url, $path)
	        "OK"
        } else {"$path - Актуален"}
	} catch {"Не удалось скачать ($Error)"}
}

$rulesAr=@("rules_linux.json",
"rules_windows_generic.json",
"rules_windows_generic_full.json",
"rules_windows_generic_high.json",
"rules_windows_generic_medium.json",
"rules_windows_sysmon.json",
"rules_windows_sysmon_full.json",
"rules_windows_sysmon_high.json",
"rules_windows_sysmon_medium.json")

foreach ($rule in $rulesAr) {
    DownloadThisTo -url "https://raw.githubusercontent.com/wagga40/Zircolite-Rules/main/$rule" -path "$PSScriptRoot\rules\$rule"
}

DownloadThisTo -url "https://github.com/wagga40/Zircolite/raw/master/gui/zircogui.zip" -path "$PSScriptRoot\gui\zircogui.zip"
DownloadThisTo -url "https://raw.githubusercontent.com/wagga40/Zircolite/master/config/fieldMappings.json" -path "$PSScriptRoot\config\fieldMappings.json"
DownloadThisTo -url "https://raw.githubusercontent.com/wagga40/Zircolite/master/templates/exportForZircoGui.tmpl" -path "$PSScriptRoot\templates\exportForZircoGui.tmpl"