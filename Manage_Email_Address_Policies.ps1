#Please start the EMS (Exchange Management Shell)

#Let's check all policies
Get-EmailAddressPolicy

#Create a new email address policies
New-EmailAddressPolicy -Name "Zurich Office" -IncludedRecipients AllRecipients -ConditionalStateorProvince "ZH" -EnabledEmailAddressTemplate "SMTP:%g.%s@contosotom.ch", "smtp:zh-%g.%s@contosotom.ch"

#Now we use the new policy
Update-EmailAddressPolicy –Identity "Zurich Office"

#Let's check all policies
Get-EmailAddressPolicy

#A bit more infos
Get-EmailAddressPolicy | Format-List Name,Priority,Enabled*,RecipientFilterType,IncludedRecipients,Conditional*

#Check the default policy
Get-EmailAddressPolicy –Identity Default* | Format-List Name,Priority,Enabled*,RecipientFilterType,IncludedRecipients,Conditional*

#A new policy with more specifications
New-EmailAddressPolicy -Name "Luzern Managers" -RecipientFilter "(StateOrProvince-eq 'LU') -and (Title -like '*Director*' -or Title -like '*Manager*')" -EnabledEmailAddressTemplate "SMTP:%g.%s@contosotom.ch", "smtp:lu_managers.%g.%s@contosotom.ch"

#Now we use the new policy
Update-EmailAddressPolicy –Identity "Luzern Managers"

#Update an existing policy
Set-EmailAddressPolicy -Identity "Zurich Office" -ConditionalStateOrProvince @{Add= "ZHDWNT"}

#Let's check the configuration
Get-EmailAddressPolicy –Identity "Zurich Office" | Format-List Name,Priority,Enabled*,RecipientFilterType,IncludedRecipients,Conditional*

#To remove a policy
Remove-EmailAddressPolicy –Identity "Luzern Managers"
Remove-EmailAddressPolicy –Identity "Zurich Office"