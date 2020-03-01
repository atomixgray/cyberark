#Automate CyberARK Safe Creation Process
# At0mix
# Created 3/1/2020

# ************ Work in Progress not Ready for Full Use ******************* #


#Connect to CyberARK
$admin2 = "CYBADM_Admin2"

# Point to your CyberArk site
New-PASSession -Credential $admin2 -BaseURI https://cyberark.localsite.org

# Set Vars
$username = Read-Host "Users Daily Network Account: bob001"
$teamname1 = Read-Host " Enter User's Team Name"
$useradmin = Read-Host "Enter Users Admin account: bob001-admin"

# Hard Code Team Name here to save a step during creation process.
#$teamname1 = "Server Team"

$safename = "$username_Personal_Safe"
$vaultadmin = "Vault Admins"

#Create User Safe
Add-PASSafe -SafeName $safename -Description "$username $teamname1" -ManagingCPM PasswordManager -NumberOfVersionsRetention 3

#Add User to Safe -- Remove, add needed permissions for User
Add-PASSafeMember -SafeName $safename -MemberName $username -SearchIn "localsite.com" -UseAccounts $true -ListAccounts $true -RetrieveAccounts $true -ViewAuditLog $true -AddAccounts $true -UpdateAccountContent $true -UpdateAccountProperties $true -InitiateCPMAccountManagementOperations $true

#Add CyberArk Admin Group. Add local CyberArk Admin Group CASYS_CYBADM
Add-PASSafeMember -SafeName $safename -MemberName CASYS_CYBADM -SearchIn Vault -UseAccounts $false -ListAccounts $true -RetrieveAccounts $false -AddAccounts $true -UpdateAccountProperties $true -InitiateCPMAccountManagementOperations $true -SpecifyNextAccountContent $true -RenameAccounts $true -DeleteAccounts $true -UnlockAccounts $true -ManageSafe $true -ManageSafeMembers $true -BackupSafe $true -ViewAuditLog  $true -ViewSafeMembers $true -RequestsAuthorizationLevel $true -AccessWithoutConfirmation $true -CreateFolders $true -DeleteFolders $true -MoveAccountsAndFolders $true -UpdateAccountContent $true

#Add Vault Admin to Safe -- Add Vault Admins to Safe.
Add-PASSafeMember -SafeName $safename -MemberName $vaultadmin -SearchIn Vault -UseAccounts $true -ListAccounts $true -RetrieveAccounts $true -AddAccounts $true -UpdateAccountProperties $true -InitiateCPMAccountManagementOperations $true -SpecifyNextAccountContent $true -RenameAccounts $true -DeleteAccounts $true -UnlockAccounts $true -ManageSafe $true -ManageSafeMembers $true -BackupSafe $true -ViewAuditLog  $true -ViewSafeMembers $true -RequestsAuthorizationLevel $true -AccessWithoutConfirmation $true -CreateFolders $true -DeleteFolders $true -MoveAccountsAndFolders $true -UpdateAccountContent $true

# Add Users Admin account
Add $useradmin




