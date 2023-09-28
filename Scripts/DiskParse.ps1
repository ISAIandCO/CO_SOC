$paths = $PSScriptRoot
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    break
}
cd $paths
"
__________________________________________________________
    Запущен сбор информации о содержимом дисков
    Данные будут по пути $paths
__________________________________________________________

"
Get-PSDrive | where -Property Provider -Like "*FileSystem*" | ForEach-Object {$f="$_"+".csv";Get-Childitem $_.root -Recurse | Select-Object -Property FullName | Export-Csv -Path .\$f -Encoding UTF8 -Delimiter ";"}