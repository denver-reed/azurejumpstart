$filePath = "C:\Users\denreed"
$Url = "https://github.com/Azure-Samples/azure-files-samples/releases/download/v0.2.4/AzFilesHybrid.zip"
$subscriptionName = ""
$ResourceGroupName = ""
$StorageAccountName = "cocvdiupd"
$SamAccountName = "cocvdiupd"
$DomainAccountType = "ComputerAccount"  
$OuDistinguishedName = "OU=AVD,OU=Kiosk,OU=Business Units,DC=ci,DC=charlotte,DC=nc,DC=us"
$EncryptionType = "AES256"


$DownloadZipFile = $filePath + $(Split-Path -Path $Url -Leaf)

$ExtractPath = $filePath

Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile

$ExtractShell = New-Object -ComObject Shell.Application 

$ExtractFiles = $ExtractShell.Namespace($DownloadZipFile).Items() 

$ExtractShell.NameSpace($ExtractPath).CopyHere($ExtractFiles) 

cd $filePath

.\CopyToPSPath.ps1 


#Restart Powershell ISE

Import-Module Az.Accounts
Import-Module AzFilesHybrid

================================
Connect-AzAccount
#Select the correct subscription
Get-AzSubscription -SubscriptionName $subscriptionName | Select-AzSubscription

=====================================
=====================================

Join-AzStorageAccount `
        -ResourceGroupName $ResourceGroupName `
        -StorageAccountName $StorageAccountName `
        -SamAccountName $SamAccountName `
        -DomainAccountType $DomainAccountType `
        -OrganizationalUnitDistinguishedName $OuDistinguishedName `
        -EncryptionType $EncryptionType


==========================================================================

#$storageacccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName
#$storageacccount | Get-AzStorageAccountKey -ListKerbKey | Format-Table Keyname

#$storageacccount.AzureFilesIdentityBasedAuth.DirectoryServiceOptions
#$storageacccount.AzureFilesIdentityBasedAuth.ActiveDirectoryProperties