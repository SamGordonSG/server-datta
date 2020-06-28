ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("chargePlayer")
AddEventHandler("chargePlayer", function(chargeAmount)
	 local xPlayer        = ESX.GetPlayerFromId(source)
	 local societyAccount = nil

	 TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
	 societyAccount = account
	 end)
 
	 societyAccount.addMoney(chargeAmount)
     xPlayer.removeAccountMoney("bank",chargeAmount)
     CancelEvent()
end)

RegisterServerEvent("devAddPlayer")
AddEventHandler("devAddPlayer", function(devAddAmount)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		user.addMoney(devAddAmount)
		CancelEvent()
	end)
end)