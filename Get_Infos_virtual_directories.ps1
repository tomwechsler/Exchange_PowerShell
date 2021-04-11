#Please start the EMS (Exchange Management Shell)

#Auto Discover allows the email clients like Outlook to discover the mailbox settings and configure the mailbox automatically without entering the details like server information etc.
Get-ClientAccessService -Identity ex01 | Select-Object AutodiscoverServiceInternalUri

#We update the URL
Set-ClientAccessService -Identity ex01 -AutoDiscoverServiceInternalUri https://autodiscover.contosotom.ch/Autodiscover/Autodiscover.xml

#Let's check again
Get-ClientAccessService -Identity ex01 | Select-Object AutodiscoverServiceInternalUri

#No need to set the Internal / External Url using Set-AutodiscoverVirtualDirectory as it is applicable when using Exchange Server 2019
Get-AutodiscoverVirtualDirectory -Server ex01 | Format-List ID, Internal*, External*

#MAPI over HTTP is the default protocol for Outlook in Exchange Server 2019
Get-MapiVirtualDirectory -Server Ex01 | Format-List ID, *url, *method*

#Exchange Control Panel is where an admin can access Exchange Admin Center to manage the Exchange Service
Get-EcpVirtualDirectory -Server ex01 | Format-List *url, *methods

OWA virtual directory allows the emails access using Web Browser
Get-OwaVirtualDirectory -Server ex01 | Format-List ID, *url, *methods

#Mobile Device clients that support Exchange Active Sync connects to Active Sync Virtual directory to access the mailbox
Get-ActiveSyncVirtualDirectory -Server ex01 | Format-List ID, *url, *methods

#Outlook clients using Cached mode requires offline address book to access the address book when it is not connected to exchange
Get-OabVirtualDirectory -Server ex01 | Format-List ID, *url, *methods

#EWS virtual directory supports many features like free busy look up, calendar sharing, mail tips, etc.
Get-WebServicesVirtualDirectory -Server ex01 | Format-List ID, *url, *methods