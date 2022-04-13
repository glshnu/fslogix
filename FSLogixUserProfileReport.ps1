#TLS Enablement

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Script fetch details with Azure storage commands

$StorageAccountName="storage account Name" # Dont include file.core.windowsnet, just give storage account name
$fileShares="profile2","profile3","profile4","profile5","profile6"
$ResourceGroup = (Get-AzResource -Name $StorageAccountName).ResourceGroupName
$Key = Get-AzStorageAccountKey -ResourceGroupName $ResourceGroup -Name $StorageAccountName
$context=New-AzStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $Key[1].Value

$finalResult=@()
foreach($fileShare in $fileShares)
{
    $Files=Get-AzStorageFile -Context $context -ShareName $fileShare | Get-AzStorageFile
    write-host "$($fileShare) Count = $($Files.Count)"
    $i=1
    $Files | ForEach-Object{
    Write-Host "Executing File $i"
    $File=$_.ShareFileClient.Path
    #$FileDetails=Get-AzStorageFile -Context $context -ShareName $fileShareName -Path $File
    #$obj=""|select UserGPN,UserSID,File,SizeInMB,LastModified
    $obj=""|select FileShare,UserGPN,UserSID,File,SizeInMB
    $obj.FileShare=$fileShare
    $obj.UserGPN=($File.Split("/")[0]).Split("_")[0]
    $obj.UserSID=($File.Split("/")[0]).Split("_")[1]
    $obj.File=$_.Name
    $obj.SizeInMB=$_.Length/1024/1024
    #$obj.LastModified=$FileDetails.LastModified
    $finalResult+=$obj
    $i=$i+1
    }
}

$finalResult | Export-Csv -Path C:\Temp\$StorageAccountName"_ProfileSizes_$(get-date -Format yyyyMMdd_hhmmss)".csv -NoTypeInformation
