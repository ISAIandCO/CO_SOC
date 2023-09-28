$data = Read-Host 'Введите значение'

try {$info = Get-ADUser -Identity "$data" | select SamAccountName,SID,ObjectClass}
catch {
    try {$info = Get-ADGroup -Identity "$data" | select SamAccountName,SID,ObjectClass}
    catch {$info = Get-ADComputer $data | select SamAccountName,SID,ObjectClass}
}

$name=$info.SamAccountName; $sid=$info.SID.Value; $type = $info.ObjectClass; $status = $info.Enabled

"
Тип    == $type
УЗ     == $name
SID    == $sid"
if ($status) {"Статус == $status
"}
else {"
"}

pause