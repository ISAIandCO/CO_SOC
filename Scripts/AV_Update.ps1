$CUREITpath2 = '$PSScriptRoot\CureitUpd_Temp'
$CUREITpath = '$PSScriptRoot\Антивирусные_утилиты'

$WebClient = new-object System.Net.WebClient
$WebClient.Headers.Add(“user-agent”, “PowerShell Script”)
$WebClient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls, Ssl3"

function DownloadThisTo ([string]$url, [string]$path)
{
	try{
	"Обновляется файл: $path"
	$WebClient = New-Object System.Net.WebClient
	$WebClient.DownloadFile($url, $path)
	"OK
	"
		}
	catch {"Не удалось скачать ($Error)"}
}
	
$CureItArray = @(
	@("https://devbuilds.s.kaspersky-labs.com/devbuilds/KVRT/latest/full/KVRT.exe",
	"$CUREITpath\Kaspersky Virus Removal Tool.exe",
    "$CUREITpath2\Kaspersky Virus Removal Tool.exe"),
	@("https://download.geo.drweb.com/pub/drweb/cureit/cureit.exe",
	"$CUREITpath\Dr.Web CureIt!.exe",
	"$CUREITpath2\Dr.Web CureIt!.exe"),
	@("https://rescuedisk.s.kaspersky-labs.com/updatable/2018/krd.iso",
	"$CUREITpath\Kaspersky Rescue Disk (KRD).iso",
	"$CUREITpath2\Kaspersky Rescue Disk (KRD).iso"),
	@("https://download.geo.drweb.com/pub/drweb/livedisk/drweb-livedisk-900-cd.iso",
	"$CUREITpath\Doctor Web LiveDisk (CD).iso",
	"$CUREITpath2\Doctor Web LiveDisk (CD).iso"),
	@("https://download.geo.drweb.com/pub/drweb/livedisk/drweb-livedisk-900-usb.exe",
	"$CUREITpath\Doctor Web LiveDisk (USB).exe",
    "$CUREITpath2\Doctor Web LiveDisk (USB).exe"))
"
_________________________________________________________
"
$n=0
foreach ($CureIt in $CureItArray)
{
	$n=$n+1
	try {
	$dcf = Get-ChildItem -Path $CureIt[1] -Recurse -Force | Measure-Object -Property Length -Sum
	$dn = (Invoke-WebRequest $CureIt[0] -Method Head).Headers.'Content-Length'
	if ($dcf.sum -ne $dn) {
        DownloadThisTo -url $CureIt[0] -path $CureIt[2]
        $dcf = Get-ChildItem -Path $CureIt[2] -Recurse -Force | Measure-Object -Property Length -Sum
	    $dn = (Invoke-WebRequest $CureIt[0] -Method Head).Headers.'Content-Length'
        if ($dcf.sum -eq $dn) {
            "Производится копирование в основную папку"
            Move-Item -Path $CureIt[2] -Destination $CureIt[1] -Force
            "$n - Обновлен"
        }
    }
	else {"$n - Актуален"}}
	catch {
        DownloadThisTo -url $CureIt[0] -path $CureIt[2]
        $dcf = Get-ChildItem -Path $CureIt[2] -Recurse -Force | Measure-Object -Property Length -Sum
	    $dn = (Invoke-WebRequest $CureIt[0] -Method Head).Headers.'Content-Length'
        if ($dcf.sum -eq $dn) {
            "Производится копирование в основную папку"
            Move-Item -Path $CureIt[2] -Destination $CureIt[1] -Force
            "$n - Обновлен"
        }
    }
}