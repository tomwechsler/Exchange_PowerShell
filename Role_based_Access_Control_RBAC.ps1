#region 
<#Description
Role groups: Role groups enable you to grant permissions to administrators and specialist users.

Role assignment policies: Role assignment policies enable you to grant permissions to end users to 
change settings on their own mailbox or distribution groups that they own.

Terminology:
Role Group: Is a collcetion of roles (Discovery Management => Legal Hold, Mailbox Search)

Role: Is a collection of cmdlets so that the role's tasks can be done

Roleentry: A specific cmdlet

#>
#endregion


#Please start the EMS (Exchange Management Shell)

#A first look
Get-ManagementRoleAssignment

#Display all role groups
Get-RoleGroup 

#More details
Get-RoleGroup -Identity "Organization Management" | Format-List

#Which members are assigned to the role group 
Get-RoleGroup -Identity "Organization Management" | Get-RoleGroupMember

#Views the roleentries
Get-ManagementRole "Mail Recipient Creation" | Select-Object -ExpandProperty RoleEntries

#Just another way
Get-ManagementRole "Mail Recipient Creation" | Get-ManagementRoleEntry

#Shows all the cmdlets from a role
Get-ManagementRoleEntry "Mail Recipients\*"

#Shows all the cmdlets from a role
Get-ManagementRoleEntry "Address Lists\*"

#Shows all the cmdlets from a role
Get-ManagementRoleEntry "View-Only Recipients\*"

#Finds the user Tim Thomann on all roles
Get-ManagementRoleAssignment -GetEffectiveUsers | Where-Object {$_.EffectiveUserName -Eq "Jane Ford"} | Format-Table EffectiveUserName, Role, CustomRecipientWriteScope, CustomConfigWriteScope

#Find the permissions required to run a cmdlet
Get-ManagementRole -Cmdlet Set-Notification

#Find the permissions required to run a cmdlet
Get-ManagementRole -Cmdlet New-MailboxDatabase

$Perms = Get-ManagementRole -Cmdlet Set-Mailbox
$Perms | ForEach-Object {Get-ManagementRoleAssignment -Role $_.Name -Delegating $false | Format-Table -Auto Role,RoleAssigneeType,RoleAssigneeName}

#To see all roles assigned to a specific user
Get-ManagementRoleAssignment -RoleAssignee janeford@contosotom.ch -Delegating $false | Format-Table -Auto Role,RoleAssigneeName,RoleAssigneeType

#To see all users who are assigned a specific role
Get-ManagementRoleAssignment -Role "Mailbox Import Export"  -GetEffectiveUsers -Delegating $false | Where-Object {$_.EffectiveUserName -ne "All Group Members"} | Format-Table -Auto EffectiveUserName,Role,RoleAssigneeName,AssignmentMethod

#To see the members of a specific role group
Get-RoleGroupMember "Organization Management"