<#
.Info
Monitora exclusões de arquivos no sistema de arquivos Windows.

.Função
Este script utiliza eventos WMI para detectar exclusões de arquivos.
Caso o número de exclusões atinja um limite definido em um intervalo curto,
um alerta é gerado, podendo indicar comportamento suspeito (ex: ransomware).

.Autor
Edilson Gomes Pereira
#>

# Caminho monitorado (ajustar conforme ambiente)
$path = "\\Fileserver\auditoria$\Scripts"

# Quantidade de exclusões que dispara alerta
$limite = 10

# Contador global de eventos
$global:contador = 0

Write-Output "Monitoramento iniciado no caminho: $path"

# Registro de evento de exclusão de arquivos
Register-WmiEvent -Query "SELECT * FROM __InstanceDeletionEvent WITHIN 5 WHERE TargetInstance ISA 'CIM_DataFile'" -Action {

    # Incrementa contador a cada exclusão detectada
    $global:contador++

    Write-Output "Exclusão detectada. Total: $global:contador"

    # Verifica se atingiu o limite definido
    if ($global:contador -ge $limite) {
        Write-Output "ALERTA: Possível exclusão em massa detectada!"

        # Aqui pode ser integrada ação adicional:
        # - Envio de e-mail
        # - Registro em log
        # - Acionamento de sistema externo
    }
}
