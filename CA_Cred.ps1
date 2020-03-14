#Module installation
#Copy the CredentialRetriever folder to your "Powershell Modules" directory. Get-Module -ListAvailable CredentialRetriever

#Import the module:

#Import-Module CredentialRetriever

#Now that we have the module installed we can start our custom script.

# Pulls Current Creds

#set vars
$username = Read-Host "Enter Admin account ID"
$server = Read-Host "Enter Server your connecting to"
$safename = "CA_U_alark002"

$test = Get-AIMCredential -AppID RESTAPI -Safe $safename -UserName $username -RequiredProps Username, address

#Add the password to Clipboard
Set-Clipboard -Value $test.password


#Show Info on Screen
$test.Username
$test.Password

#Launch RDP Connection
mstsc /v:$server