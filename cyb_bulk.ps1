$user2 = "CYBADM_Admin2"

New-PASSession -Credential $user2 -BaseURI https://cyberark.local.com

# Set Vars
$vaultadmin = "Vault Admins"
#$users = Import-Csv -Path C:\Temp\users.txt
$users = Get-Content C:\temp\users.txt

foreach ($user in $users)
{

#Create User Safe
Add-PASSafe -SafeName "U_$($user)" -Description "U_$($user)" -ManagingCPM PasswordManager -NumberOfVersionsRetention 3

#Add User to Safe
Add-PASSafeMember -SafeName "U_$($user)" -MemberName $user -SearchIn "local.com" -UseAccounts $true -ListAccounts $true -RetrieveAccounts $true -ViewAuditLog $true -AddAccounts $true -UpdateAccountContent $true -UpdateAccountProperties $true -InitiateCPMAccountManagementOperations $true

#Add CyberArk Admin to Safe
Add-PASSafeMember -SafeName "U_$($user)" -MemberName G_CASYS_CYBADM -SearchIn Vault -UseAccounts $false -ListAccounts $true -RetrieveAccounts $false -AddAccounts $true -UpdateAccountProperties $true -InitiateCPMAccountManagementOperations $true -SpecifyNextAccountContent $true -RenameAccounts $true -DeleteAccounts $true -UnlockAccounts $true -ManageSafe $true -ManageSafeMembers $true -BackupSafe $true -ViewAuditLog  $true -ViewSafeMembers $true -RequestsAuthorizationLevel $true -AccessWithoutConfirmation $true -CreateFolders $true -DeleteFolders $true -MoveAccountsAndFolders $true -UpdateAccountContent $true

#Add Vault Admin to Safe
Add-PASSafeMember -SafeName "U_$($user)" -MemberName $vaultadmin -SearchIn Vault -UseAccounts $true -ListAccounts $true -RetrieveAccounts $true -AddAccounts $true -UpdateAccountProperties $true -InitiateCPMAccountManagementOperations $true -SpecifyNextAccountContent $true -RenameAccounts $true -DeleteAccounts $true -UnlockAccounts $true -ManageSafe $true -ManageSafeMembers $true -BackupSafe $true -ViewAuditLog  $true -ViewSafeMembers $true -RequestsAuthorizationLevel $true -AccessWithoutConfirmation $true -CreateFolders $true -DeleteFolders $true -MoveAccountsAndFolders $true -UpdateAccountContent $true
}

out-file c:\temp\out.txt
