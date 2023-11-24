$cmd = ".\zircolite_win10.exe -e"

if ($A=Read-Host "Нижняя граница в формате дд.мм.гг чч:мм:сс [Отсутствует]") {
    $A=Get-Date -Format "yyyy-MM-ddTHH:mm:ss" ([datetime](Get-Date $A)).AddHours(-5)
    $time=" -A $A"
    if ($B=Read-Host "Верхняя граница в формате дд.мм.гг чч:мм:сс [Отсутствует]") {
        $B=Get-Date -Format "yyyy-MM-ddTHH:mm:ss" ([datetime](Get-Date $B)).AddHours(-5)
        $time=$time + " -B $B"} else {$B=Get-Date -Format "yyyy-MM-ddTHH:mm:ss" ([datetime](Get-Date)).AddHours(-5);$time=$time + " -B $B"}
}

switch ($lvl=Read-Host "Выберите тип анализа [Windows_Medium]
1. Windows_Full
2. Windows_High
3. Windows_Medium
4. Linux
") {
    1 {$cmd_a="$cmd 0.Windows --ruleset rules\rules_windows_generic_full.json --package$time"; $cmd_b="$cmd 0.Windows --ruleset rules\rules_windows_sysmon_full.json --package$time";Break}
    2 {$cmd_a="$cmd 0.Windows --ruleset rules\rules_windows_generic_high.json --package$time"; $cmd_b="$cmd 0.Windows --ruleset rules\rules_windows_sysmon_high.json --package$time";Break}
    3 {$cmd_a="$cmd 0.Windows --ruleset rules\rules_windows_generic_medium.json --package$time"; $cmd_b="$cmd 0.Windows --ruleset rules\rules_windows_sysmon_medium.json --package$time";Break}
    4 {$cmd_a="$cmd 0.Windows --ruleset rules\rules_linux.json --package$time";Break}
    Default {$cmd_a="$cmd 0.Windows --ruleset rules\rules_windows_generic_medium.json --package$time"; $cmd_b="$cmd 0.Windows --ruleset rules\rules_windows_sysmon_medium.json --package$time"}
}

powershell -command $cmd_a
if ((Get-ChildItem .\detected_events.json).Length -le 10 -and $lvl -ne 4) {powershell -command $cmd_b}
if ((Get-ChildItem .\detected_events.json).Length -le 10) {"События не найдены, проверьте ввод"; pause}
rm detected_events.json
rm zircolite.log