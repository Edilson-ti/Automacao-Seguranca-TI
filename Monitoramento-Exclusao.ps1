$path = "C:\Compartilhado"
$limite = 10
$contador = 0

Register-WmiEvent -Query "SELECT * FROM __InstanceDeletionEvent WITHIN 5 WHERE TargetInstance ISA 'CIM_DataFile'" -Action {
    $global:contador++
    
    if ($global:contador -ge $limite) {
        Write-Output "ALERTA: Possível exclusão em massa detectada!"
    }
}
