$eventos = Get-WinEvent -LogName Security | Where-Object {
    $_.Id -eq 4663
}

$relatorio = $eventos | Select-Object TimeCreated, Message

$relatorio | Export-Csv "C:\Relatorio_Arquivos_Deletados.csv" -NoTypeInformation
