function New-Eicar {
    [CmdletBinding()] Param(
        [ValidateScript({Test-Path $_ -PathType 'Container'})] 
        [string] 
        $Path = "$env:temp\"
        )            
            [string] $FilePath = (Join-Path $Path eicar.com)
            #Base64 of Eicar string
            [string] $EncodedEicar = 'WDVPIVAlQEFQWzRcUFpYNTQoUF4pN0NDKTd9JEVJQ0FSLVNUQU5EQVJELUFOVElWSVJVUy1URVNULUZJTEUhJEgrSCo='

            If (Test-Path -Path $FilePath) {
				Remove-Item -Path $FilePath -Force
			}
            Try {
				[byte[]] $EicarBytes = [System.Convert]::FromBase64String($EncodedEicar)
				[string] $Eicar = [System.Text.Encoding]::UTF8.GetString($EicarBytes)
				Set-Content -Value $Eicar -Encoding ascii -Path $FilePath -Force 
            }
			Catch {;
            }
}

$local_path = "C:\temp"

for(;;)
{
"-----------------------------------------------------------------------"
New-Eicar -Path $local_path
Get-Date
Start-Sleep 60
if (!(Test-Path -Path $local_path\eicar.com)) {
	ping Hello_There -n 1 > $null
    Start-Sleep 3540
	ping Hello_There -n 1 > $null
    Start-Sleep 3600
	}
Else {
	ping Hello_There -n 1 > $null
    Start-Sleep 1740
	}
}