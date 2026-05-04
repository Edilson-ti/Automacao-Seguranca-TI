$path = "C:\Compartilhado"
$limite = 10
$contador = 0

Register-WmiEvent -Query "SELECT * FROM __InstanceDeletionEvent WITHIN 5 WHERE TargetInstance ISA 'CIM_DataFile'" -Action {
    $global:contador++
    
    if ($global:contador -ge $limite) {
        Write-Output "ALERTA: Possível exclusão em massa detectada!"
    }
}
# Enviar alerta por e-mail

$smtpServer = "smtp.mail.***.com"
$emailFrom = "edilson.pereira@****.com"
$emailTo = "admin@email.com"
$subject = "ALERTA DE SEGURANÇA"
$body = "Exclusão em massa detectada!"

Send-MailMessage -SmtpServer $smtpServer -From $emailFrom -To $emailTo -Subject $subject -Body $body
