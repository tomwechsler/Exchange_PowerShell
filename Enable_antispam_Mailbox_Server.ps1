#Enable antispam functionality on Mailbox servers
#https://docs.microsoft.com/en-us/exchange/antispam-and-antimalware/antispam-protection/antispam-on-mailbox-servers

#Please start the EMS (Exchange Management Shell)

& $env:ExchangeInstallPath\Scripts\Install-AntiSpamAgents.ps1

Restart-Service MSExchangeTransport