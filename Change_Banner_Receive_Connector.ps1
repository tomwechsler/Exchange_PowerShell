#Please start the EMS (Exchange Management Shell)

#List all receive Connectors
Get-ReceiveConnector

#List more details
Get-ReceiveConnector | fl *

#Infos about the banner
Get-ReceiveConnector | Select-Object Banner

#Nothing is not nothing!

#Open an cmd session
telnet
open ex01 25
#We get an answer
#220 ex01.contosotom.ch Microsoft ESMTP MAIL Service ready at Wed, 30 Dec 2020 12:41:08 +0000

#This example changes the SMTP banner on the Receive connector named Default Frontend EX01 to the value 220 contosotom.ch
Set-ReceiveConnector -Identity "Default Frontend EX01" -Banner "220 consosotom.ch"

#The replacement SMTP banner text string must always start with 220 (the default "Service ready" SMTP response code is 220).

#This example removes the custom SMTP banner, which returns the SMTP banner to the default value.
Set-ReceiveConnector -Identity "Default Frontend EX01" -Banner $null
