RegisterServerEvent('esx_infoillegal:Crack')
AddEventHandler('esx_infoillegal:Crack', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= Config.PriceCrackF) then
			user.removeMoney(Config.PriceCrackF)
			TriggerClientEvent("esx_infoillegal:CrackFarm", source)
		else
			TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('NoCash'))
		end
	end)
end)

RegisterServerEvent('esx_infoillegal:TCrack')
AddEventHandler('esx_infoillegal:TCrack', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= Config.PriceCrackT) then
			user.removeMoney(Config.PriceCrackT)
			TriggerClientEvent("esx_infoillegal:CrackTreatment", source)			
		else
			TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('NoCash'))
		end
	end)
end)

RegisterServerEvent('esx_infoillegal:RCrack')
AddEventHandler('esx_infoillegal:RCrack', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= Config.PriceCrackR) then
			user.removeMoney(Config.PriceCrackR)
			TriggerClientEvent("esx_infoillegal:CrackResell", source)				
		else
			TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('NoCash'))
		end
	end)
end)

RegisterServerEvent('esx_infoillegal:Opium')
AddEventHandler('esx_infoillegal:Opium', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= Config.PriceOpiumF) then
			user.removeMoney(Config.PriceOpiumF)
			TriggerClientEvent("esx_infoillegal:OpiumFarm", source)
		else
			TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('NoCash'))
		end
	end)
end)

RegisterServerEvent('esx_infoillegal:TOpium')
AddEventHandler('esx_infoillegal:TOpium', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= Config.PriceOpiumT) then
			user.removeMoney(Config.PriceOpiumT)
			TriggerClientEvent("esx_infoillegal:OpiumTreatment", source)			
		else
			TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('NoCash'))
		end
	end)
end)

RegisterServerEvent('esx_infoillegal:ROpium')
AddEventHandler('esx_infoillegal:ROpium', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= Config.PriceOpiumR) then
			user.removeMoney(Config.PriceOpiumR)
			TriggerClientEvent("esx_infoillegal:OpiumResell", source)				
		else
			TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('NoCash'))
		end
	end)
end)

RegisterServerEvent('esx_infoillegal:Coke')
AddEventHandler('esx_infoillegal:Coke', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= Config.PriceCokeF) then
			user.removeMoney(Config.PriceCokeF)
			TriggerClientEvent("esx_infoillegal:CokeFarm", source)
		else
			TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('NoCash'))
		end
	end)
end)

RegisterServerEvent('esx_infoillegal:TCoke')
AddEventHandler('esx_infoillegal:TCoke', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= Config.PriceCokeT) then
			user.removeMoney(Config.PriceCokeT)
			TriggerClientEvent("esx_infoillegal:CokeTreatment", source)			
		else
			TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('NoCash'))
		end
	end)
end)

RegisterServerEvent('esx_infoillegal:RCoke')
AddEventHandler('esx_infoillegal:RCoke', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= Config.PriceCokeR) then
			user.removeMoney(Config.PriceCokeR)
			TriggerClientEvent("esx_infoillegal:CokeResell", source)				
		else
			TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('NoCash'))
		end
	end)
end)

RegisterServerEvent('esx_infoillegal:Ecstasy')
AddEventHandler('esx_infoillegal:Ecstasy', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= Config.PriceEcstasyF) then
			user.removeMoney(Config.PriceEcstasyF)
			TriggerClientEvent("esx_infoillegal:EcstasyFarm", source)
		else
			TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('NoCash'))
		end
	end)
end)

RegisterServerEvent('esx_infoillegal:TEcstasy')
AddEventHandler('esx_infoillegal:TEcstasy', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= Config.PriceEcstasyT) then
			user.removeMoney(Config.PriceEcstasyT)
			TriggerClientEvent("esx_infoillegal:EcstasyTreatment", source)			
		else
			TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('NoCash'))
		end
	end)
end)

RegisterServerEvent('esx_infoillegal:REcstasy')
AddEventHandler('esx_infoillegal:REcstasy', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= Config.PriceEcstasyR) then
			user.removeMoney(Config.PriceEcstasyR)
			TriggerClientEvent("esx_infoillegal:EcstasyResell", source)				
		else
			TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('NoCash'))
		end
	end)
end)

RegisterServerEvent('esx_infoillegal:Nothere')
AddEventHandler('esx_infoillegal:Nothere', function()
	TriggerClientEvent("esx_infoillegal:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('Nothere'))
end)