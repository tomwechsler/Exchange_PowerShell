#Please start the EMS (Exchange Management Shell)

#Get infos about messaging tracking log settings
Get-TransportService ex01 | Format-List *tracking*

#We could configure the Exchange organization to send copies of NDRs to the Exchange recipient. Is there a dedicated mailbox for the Exchange recipient?
Get-OrganizationConfig | Select-Object MicrosoftExchangeRecipientReplyRecipient

#To do so, this example assigns the existing mailbox named "Contoso System Mailbox" to the Exchange recipient
Set-OrganizationConfig -MicrosoftExchangeRecipientReplyRecipient "Contoso System Mailbox"

#OAuth2ClientProfileEnabled?
Get-OrganizationConfig | Select-Object OAuth2ClientProfileEnabled

#Are there any retention hold enabled?
Get-Mailbox -ResultSize unlimited | Where-Object {$_.RetentionHoldEnabled -eq $true} | Format-Table Name,RetentionPolicy,RetentionHoldEnabled -Auto

#Did Jane receive an email from the admin?
$Temp = Search-MessageTrackingReport -Identity "exadmin" -Recipients "janeford@contosotom.ch"
Get-MessageTrackingReport -Identity $Temp.MessageTrackingReportID -ReportTemplate Summary

#Infos about content filtering
Get-ContentFilterConfig

#Do we have an Active Sync Rule?
Get-ActiveSyncDeviceAccessRule

#Infos about a specific mailbox
Get-Mailbox -Identity "exadmin" | Format-List *

#If you need to test the internal mailflow
Test-Mailflow -TargetEmailAddress exadmin@contosotom.ch

#A list of distribution groups
Get-DistributionGroup

#A bit more specific
Get-DistributionGroup -Identity IT | Select-Object AcceptMessagesOnlyFrom, AcceptMessagesOnlyFromDLMembers

#Find the permissions required to run a cmdlet
$Perms = Get-ManagementRole -Cmdlet Set-Mailbox
$Perms | ForEach-Object {Get-ManagementRoleAssignment -Role $_.Name -Delegating $false | Format-Table -Auto Role,RoleAssigneeType,RoleAssigneeName}

#Need help?
Get-Help Set-CASMailbox -Full