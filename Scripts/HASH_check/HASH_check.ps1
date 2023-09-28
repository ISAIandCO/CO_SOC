$WebClient = new-object System.Net.WebClient
$WebClient.Headers.Add(“user-agent”, “PowerShell Script”)
$WebClient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls, Ssl3"

$VT_API_ms = @('740bce69a223d9434f8c789ce8b432e3e15cbfb4e8bf78b72a6fa41396b8b53a',
'8edecb7ecee60fc4662f54becad5cad6ca20fcf5f59f52e772b163dc8437e54f',
'c19d5ad64781c6abdc5092547b7590b17818b6860732b06712c84e9171f87440',
'899f21daff4d9af4bcec147c4ae9b9b71b8244db0dd91c70ed4c030f266e8c3d',
'dab678a43cd131a2ed0c91d0d26cc9aa3f2c69cee5198325bf4a1a29bf44c4f7',
'd265749382155a9250c2b1f2bc926eb6d7cfa0bd5c5ce00068225b516415cb67',
'e273041d51f6333fcd7a2802614a16454229bbfe4cec015b8be897698123c403',
'd0cd4a7359d3684adf78d9a545ba921c1207fb922bf13c214f30fb529871a6e5',
'49858c37eb67ff5a1d1f3785e7a9fc06462e097e3a3cfc8a5b2bf6e7d9fb60d4',
'86cab9f34bcd9542f07e7ec3b66a9933ceea130074b5e4c271de1df31a19c0ed',
'fff09b88b204426d835588f2721290958bed35c10536a641a0df1a844675ac8b',
'ec411e9e674b9b2f656f8665f61490c05b0e6bac0c7d68f560d66a9f80353526',
'd391871b14f3946f70de145e5ec32837d3cb0016f3048c21cb9c73b56d745e75',
'f873095544f7cb5a7be799220cb17e21b332f21578eed4d23d952a45e196074f',
'0ce5cb0b16c6be24b31ce39653359444dd3a3a761ba0d7f29ad3bc67e226f69a',
'e32d25b17688d0fcbf4490ca61ebd4af2ac3595d32621ae78a618ca169173efa') #API_KEYs VT

$OT_API='AY5rfg1/S7qQiOBxpfy1ew==' #API_KEY OT

$k=0;$mass=@()
while ($k -lt $VT_API_ms.Length) {$mass+=$k;$k+=1}
$temp_mass = $mass

Function GR(){
    $var = Get-Random $temp_mass
    $ix=0;$temp_temp_mass = @()
    if ($temp_mass.Length -gt 1) {
        while ($ix -le $temp_mass.Length) { 
            if ($temp_mass[$ix] -eq $var) {$ix=$ix+1} 
            else {
                $temp_temp_mass+=$temp_mass[$ix]
                $ix=$ix+1
            }
        }
    } else {$temp_mass = $mass}
    $temp_mass = $temp_temp_mass
    "$var"
}

$Body = @{"x-api-key"="$OT_API"}
$path = "$PSScriptRoot\HASH_check"
"Файл№Хэш№Статус№Тип Угрозы" >> output.csv

Function Check_hash_OT($hash){
    $OT_URI = "https://opentip.kaspersky.com/api/v1/search/hash?request=$hash"
    $check_ot = Invoke-WebRequest -Uri $OT_URI -Method GET -Headers $Body
    $tmp = convertfrom-json $check_ot.Content
    $status = $temp.FileGeneralInfo.FileStatus
    $di = $temp.DetectionsInfo | Select-Object DetectionName
    $di = $di.DetectionName
    "$file№$hash№$status№$di"
}

Function Check_hash($hash) {
    if (-not $Global:op) {
        [bool]$test=1
        while ($test) {
            $VT_API=$VT_API_ms[(GR)]
            $check_vt = Invoke-WebRequest -Uri "https://www.virustotal.com/vtapi/v2/file/report?resource=$hash+&apikey=$VT_API" -Method GET
            if ($check_vt.StatusCode -ne "204") {[bool]$test=0} else {
                if ($i -lt $VT_API_ms.Length) {$i=$i+1} else {
                    $Global:op=$VT_API_ms.Length
                    [bool]$test=0
                    $vat_tmp = Check_hash_OT($hash)
                }
            }
        }
        $tmp = convertfrom-json $check_vt.Content
        if ($tmp.response_code -eq '1' -or $check_vt.StatusCode -ne "404") {
            $pos = $tmp.positives
            $tot = $tmp.total
            $status = "$pos\$tot"
            if ($pos) {$di = ConvertTo-Csv $tmp.scans} else {$di = "Not detected"}
            $vat_tmp = "$file№$hash№$status№$di"
        } else {$vat_tmp = Check_hash_OT($hash)}
    } else {$vat_tmp = Check_hash_OT($hash); $Global:op = $Global:op - 1}
    "$vat_tmp"
}

Get-Childitem $path -Recurse -File | ForEach-Object {
    $file=$_.FullName
    $gfh = Get-FileHash $file -Algorithm SHA256
    $hash=$gfh.hash
    if ($hash) {
        $vat_tmp = Check_hash($hash); "$vat_tmp"; "$vat_tmp" >> output.csv
    }
}
