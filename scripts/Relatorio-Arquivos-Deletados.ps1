<#
.Info
Gera relatório de arquivos deletados com base nos logs de segurança do Windows.

.Função
O script consulta o Event Viewer (log de segurança) buscando eventos relacionados
à manipulação de arquivos (ID 4663), permitindo auditoria e rastreabilidade.

.Autor
Edilson Gomes Pereira
#>

Write-Output "Coletando eventos de auditoria..."

# Coleta eventos do log de segurança
$eventos = Get-WinEvent -LogName Security | Where-Object {
    $_.Id -eq 4663
}

# Seleciona informações relevantes
$relatorio = $eventos | Select-Object TimeCreated, Message

# Caminho do arquivo de saída
$caminhoSaida = "\\Fileserver\auditoria$\Scripts\Resultados\Arquivos_Deletados.csv"

# Exporta relatório
$relatorio | Export-Csv $caminhoSaida -NoTypeInformation

Write-Output "Relatório gerado em: $caminhoSaida"
