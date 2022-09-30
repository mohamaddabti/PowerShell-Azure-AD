Find-Module -Name AzureAD | Install-Module
Import-Module AzureAD 
Connect-AzureAD

Find-Module -Name MSOnline | Install-Module
Connect-MsolService
Get-Command -module MSOnline
Get-Command -module AzureAD
Get-MsolUser

# Here I create a new user with a license and a random password. The user must change the password after logging in.
New-MsolUser `
    -UserPrincipalName "Knut.Andreas@3ydypq.onmicrosoft.com" `
    -DisplayName "Knut Andreas" `
    -FirstName "Knut" `
    -LastName "Andreas" `
    -Password "" `
    -UsageLocation "NO" `
    -LicenseAssignment "3ydypq:DEVELOPERPACK_E5" `
    -ForceChangePassword $true `
    -StrongPasswordRequired $true`

# to sjekke hva slike rolle vi har 
Get-MsolRole
#here I create a role assignment to Knut as User Administrator
Add-MsolRoleMember -RoleObjectId "fe930be7-5e62-47db-91af-98c3a49a38b1" -RoleMemberEmailAddress "Knut.Andreas@3ydypq.onmicrosoft.com"

#create a new group 
New-MsolGroup -DisplayName "User Administrator" -Description "Groupe of admins to manage all users and groups"

#To add the user "Knut" to the new group I created.
Add-MsolGroupMember -GroupObjectId "a97c7bcc-22d8-4082-b83f-0eb2193ec91a" -GroupMemberType "User" -GroupMemberObjectId "c6924386-1fda-4e3d-9f59-7fabd994b17c"

# Now we check that Knut is in the new group
Get-MsolGroupMember -groupObjectid "2c149a00-7e92-448e-8a95-fa9d97580632"

# here I activate MFA for the user Knut and I can run -All if I want to activate for all users I have
Get-MsolUser -UserPrincipalName "Knut.Andreas@3ydypq.onmicrosoft.com" | Set-MfaState -State Enabled

# here I can Disable MFA for all users or set them to Enable
Get-MsolUser -All | Set-MfaState -State Disabled # Disable eller Enable

# to remove user Knut..
Remove-MsolUser -UserPrincipalName "Knut.Andreas@3ydypq.onmicrosoft.com" -RemoveFromRecycleBin



$user=Get-MsolUser -UserPrincipalName "Knut.Andreas@3ydypq.onmicrosoft.com"
$user.StrongAuthenticationMethods

$mfActive= New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$mfActive.RelyingParty = "*"
$mfa= @($mfActive)
Set-MsolUser -UserPrincipalName "Knut.Andreas@3ydypq.onmicrosoft.com" -StrongAuthenticationRequirements $mfa


Get-MsolGroup

Get-ADGroup
Get-AzureADGroup
Get-AzureADGroupAppRoleAssignment
Get-AzureADGroup

Get-Help Remove-MsolUser -Examples
Get-MsolUserRole
-UserPrincipalName "Knut.Andreas@3ydypq.onmicrosoft.com"

Get-MsolUserByStrongAuthentication

Get-MsolRole
Get-Help Set-MfaState -Examples
Set-MsolCompanyMultiNationalEnabled
Set-MsolDomainAuthentication
