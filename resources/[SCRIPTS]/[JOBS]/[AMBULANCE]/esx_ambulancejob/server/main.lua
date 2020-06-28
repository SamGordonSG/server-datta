-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'ambulance', Config.MaxInService)
end

RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if true then -- DEFIBR
	  xPlayer.addMoney(Config.ReviveReward)
	  TriggerClientEvent('esx_ambulancejob:revive', target)
	else
		print(('esx_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))  
	end
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	TriggerClientEvent('esx_ambulancejob:heal', target, type)
end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Config.EarlyRespawn and Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)

		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money
		local finePayable = false

		if bankBalance >= Config.EarlyRespawnFineAmount then
			finePayable = true
		else
			finePayable = false
		end

		cb(finePayable)
	end)

	ESX.RegisterServerCallback('esx_ambulancejob:payFine', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_fine', Config.EarlyRespawnFineAmount))
		xPlayer.removeAccountMoney('bank', Config.EarlyRespawnFineAmount)
		cb()
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
   local qtty = xPlayer.getInventoryItem(item).count
   cb(qtty)
end)

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(_source)
   xPlayer.removeInventoryItem(item, 1)
   if item == 'bandage' then
	   TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
   elseif item == 'medikit' then
	   TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
   end
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(item)
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(_source)
   local limit = xPlayer.getInventoryItem(item).limit
   local delta = 1
   local qtty = xPlayer.getInventoryItem(item).count
   if limit ~= -1 then
	   delta = limit - qtty
   end
	
   xPlayer.addInventoryItem(item, 1)

   TriggerEvent("esx:enterambulanceitemuse",xPlayer.name,item)

end)

ESX.RegisterServerCallback('esx_ambulancejob:getOtherPlayerData', function(source, cb, target)

   if Config.EnableESXIdentity then

	   local xPlayer = ESX.GetPlayerFromId(target)
	   local identifier = GetPlayerIdentifiers(target)[1]
	   local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
		   ['@identifier'] = identifier
	   })

	   local firstname = result[1].firstname
	   local lastname  = result[1].lastname
	   local sex       = result[1].sex
	   local dob       = result[1].dateofbirth
	   local height    = result[1].height
	   
	   local data = {
		   name        = GetPlayerName(target),
		   job         = xPlayer.job,
		   firstname   = firstname,
		   lastname    = lastname,
		   sex         = sex,
		   dob         = dob,
		   height      = height
	   }

	   TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
		   if status ~= nil then
			   data.drunk = math.floor(status.percent)
		   end
	   end)

	   if Config.EnableLicenses then
		   TriggerEvent('esx_license:getLicenses', target, function(licenses)
			   data.licenses = licenses
			   cb(data)
		   end)

	   else
		   cb(data)
	   end
   else
	   local xPlayer = ESX.GetPlayerFromId(target)
	   local data = {
	   name       = GetPlayerName(target),
		   job        = xPlayer.job
	   }
	   TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
		   if status ~= nil then
			   data.drunk = math.floor(status.percent)
		   end
	   end)
	   TriggerEvent('esx_license:getLicenses', target, function(licenses)
		   data.licenses = licenses
	   end)
	   cb(data)
   end
end)

RegisterServerEvent('esx_ambulancejob:handcuff')
AddEventHandler('esx_ambulancejob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:handcuff', target)
	else
		TriggerClientEvent('esx_ambulancejob:handcuff', target)
	end
end)

RegisterServerEvent('esx_ambulancejob:drag')
AddEventHandler('esx_ambulancejob:drag', function(target)
	TriggerClientEvent('esx_ambulancejob:drag', target, source)
end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
end)

RegisterServerEvent('esx_ambulancejob:OutVehicle')
AddEventHandler('esx_ambulancejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:OutVehicle', target)
	else
		print(('esx_ambulancejob: %s attempted to drag out from vehicle (not ems)!'):format(xPlayer.identifier))
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getFineList', function(source, cb, category)
   MySQL.Async.fetchAll(
	   'SELECT * FROM fine_types_ambulance WHERE category = @category',
	   {
		   ['@category'] = category
	   },
	   function(fines)
		   cb(fines)
	   end
   )
end)

TriggerEvent('es:addGroupCommand', 'revive', 'admin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			print('esx_ambulancejob: ' .. GetPlayerName(source) .. ' is reviving a player!')
			TriggerClientEvent('esx_ambulancejob:revive', tonumber(args[1]))
		end
	else
		TriggerClientEvent('esx_ambulancejob:revive', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = _U('revive_help'), params = { { name = 'id' } } })

ESX.RegisterUsableItem('medikit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('medikit', 1)
	TriggerClientEvent('esx_ambulancejob:heal', _source, 'big')
	TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
end)

ESX.RegisterUsableItem('bandage', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('bandage', 1)
	TriggerClientEvent('esx_ambulancejob:heal', _source, 'small')
	TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
end)

ESX.RegisterUsableItem('pills', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pills', 1)
	TriggerClientEvent('esx_ambulancejob:heal', _source, 'extrasmall')
	TriggerClientEvent('esx:showNotification', _source, "Vous avez pris un Anti-Douleur, la douleur s'estompe peu à peu")
end)

ESX.RegisterUsableItem('pommade', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pommade', 1)
	TriggerClientEvent('esx_ambulancejob:heal', _source, 'small')
	TriggerClientEvent('esx:showNotification', _source, 'Vous vous êtes tartiné de pommade')
end)

RegisterServerEvent('esx_ambulancejob:firstSpawn')
AddEventHandler('esx_ambulancejob:firstSpawn', function()
	local _source    = source
	local identifier = GetPlayerIdentifiers(_source)[1]
	MySQL.Async.fetchScalar('SELECT isDead FROM users WHERE identifier=@identifier',
	{
		['@identifier'] = identifier
	}, function(isDead)
		if isDead == 1 then
			print('esx_ambulancejob: ' .. GetPlayerName(_source) .. ' (' .. identifier .. ') attempted combat logging!')
			TriggerClientEvent('esx_ambulancejob:requestDeath', _source)
		end
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local _source = source
	MySQL.Sync.execute("UPDATE users SET isDead=@isDead WHERE identifier=@identifier",
	{
		['@identifier'] = GetPlayerIdentifiers(_source)[1],
		['@isDead'] = isDead
	})
end)

ESX.RegisterServerCallback('esx_ambulancejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		cb(inventory.items)
	end)
end)


RegisterServerEvent('esx_ambulancejob:getStockItem')
AddEventHandler('esx_ambulancejob:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		local item = inventory.getItem(itemName)
		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)
	end)
end)


RegisterServerEvent('esx_ambulancejob:putStockItems')
AddEventHandler('esx_ambulancejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		local item = inventory.getItem(itemName)
		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)
	end)
end)


ESX.RegisterServerCallback('esx_ambulancejob:getOutVehicleJob', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll(
		'SELECT * FROM open_car WHERE identifier = @owner',
		{
			['@owner'] = xPlayer.identifier
		},
		function(result2)
			MySQL.Async.fetchAll(
				'SELECT * FROM owned_vehicles WHERE owner = @owner AND state = true AND garagesociety = true',
				{
					['@owner'] = 'society:ambulance',
					--['@society'] = 'society:' .. xPlayer.job.name,
					['@state'] = true,
				},
				function(result)
					local vehicles = {}
					for i=1, #result, 1 do
						local found = false
						local vehicleData = json.decode(result[i].vehicle)
						for j=1, #result2, 1 do
							if result2[j].value == vehicleData.plate then
								found = true						
							end
						end
						if found == true then					
							table.insert(vehicles, vehicleData)
						end
					end
					cb(vehicles)
				end
			)
		end
	)
end)


------------------------------------WEAPON--------------------------------

RegisterServerEvent('esx_ambulancejob:giveWeapon')
AddEventHandler('esx_ambulancejob:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weapon, ammo)
end)

ESX.RegisterServerCallback('esx_ambulancejob:getVaultWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_ambulance', function(store)
		local weapons = store.get('weapons')
		if weapons == nil then
			weapons = {}
		end
		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('esx_ambulancejob:addVaultWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeWeapon(weaponName)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_ambulance', function(store)
		local weapons = store.get('weapons')
		if weapons == nil then
			weapons = {}
		end
		local foundWeapon = false
		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
			end
		end
		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end
		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('esx_ambulancejob:removeVaultWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_ambulance', function(store)
		local weapons = store.get('weapons')
		if weapons == nil then
			weapons = {}
		end
		local foundWeapon = false
		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
			end
		end
		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 0
			})
		end
		store.set('weapons', weapons)
		cb()
	end)
end)

----------------------------------------BUY-------------------------------------


ESX.RegisterServerCallback('esx_ambulancejob:buy', function(source, cb, amount)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)
end)


ESX.RegisterServerCallback('esx_ambulancejob:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory
	cb({
		items      = items
	})
end)
