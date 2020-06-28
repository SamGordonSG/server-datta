-----------------------------------------
-- Created and modify by Anthony Maertens 
-- aka Pedro Almodovar/Dominic Stanfford
-----------------------------------------

ESX = nil
local PlayersTransforming  = {}
local PlayersSelling       = {}
local PlayersHarvesting = {}
local bread = 1
local souptomate = 1
local sacpatate = 1
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'brasseur', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'brasseur', _U('brasseur_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'brasseur', 'Brasseur', 'society_brasseur', 'society_brasseur', 'society_brasseur', {type = 'private'})

local function Harvest1(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "HoublonFarm" then
			local itemQuantity = xPlayer.getInventoryItem('houblon').count
			if itemQuantity >= 100 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(1000, function() 
					xPlayer.addInventoryItem('houblon', 1)
					Harvest1(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('esx_brasseurjob:startHarvest1')
AddEventHandler('esx_brasseurjob:startHarvest1', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('houblon_taken'))  
		Harvest1(_source,zone)
	end
end)


RegisterServerEvent('esx_brasseurjob:stopHarvest1')
AddEventHandler('esx_brasseurjob:stopHarvest1', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~récolter')
		PlayersHarvesting[_source]=true
	end
end)

local function Harvest2(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "OrgeFarm" then
			local itemQuantity = xPlayer.getInventoryItem('orge').count
			if itemQuantity >= 100 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(1000, function()
					xPlayer.addInventoryItem('orge', 1)
					Harvest2(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('esx_brasseurjob:startHarvest2')
AddEventHandler('esx_brasseurjob:startHarvest2', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('orge_taken'))  
		Harvest2(_source,zone)
	end
end)


RegisterServerEvent('esx_brasseurjob:stopHarvest2')
AddEventHandler('esx_brasseurjob:stopHarvest2', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~récolter')
		PlayersHarvesting[_source]=true
	end
end)

local function Harvest3(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "MaltFarm" then
			local itemQuantity = xPlayer.getInventoryItem('malt').count
			if itemQuantity >= 100 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(1000, function()
					xPlayer.addInventoryItem('malt', 1)
					Harvest3(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('esx_brasseurjob:startHarvest3')
AddEventHandler('esx_brasseurjob:startHarvest3', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('malt_taken'))  
		Harvest3(_source,zone)
	end
end)


RegisterServerEvent('esx_brasseurjob:stopHarvest3')
AddEventHandler('esx_brasseurjob:stopHarvest3', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~récolter')
		PlayersHarvesting[_source]=true
	end
end)


local function Transform(source, zone)

	if PlayersTransforming[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "TraitementHoublon" then
			local itemQuantity = xPlayer.getInventoryItem('houblon').count
			
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_houblon'))
				return
			else
				local rand = math.random(0,100)
				if (rand >= 98) then
					SetTimeout(1000, function()
						xPlayer.removeInventoryItem('houblon', 2)
						xPlayer.addInventoryItem('bierenoel', 1)
						TriggerClientEvent('esx:showNotification', source, _U('bierenoel'))
						Transform(source, zone)
					end)
				else
					SetTimeout(1000, function()
						xPlayer.removeInventoryItem('houblon', 2)
						xPlayer.addInventoryItem('biereblonde', 1)
				
						Transform(source, zone)
					end)
				end
			end
		elseif zone == "TraitementOrge" then
			local itemQuantity = xPlayer.getInventoryItem('orge').count
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_orge'))
				return
			else
				SetTimeout(1000, function()
					xPlayer.removeInventoryItem('orge', 2)
					xPlayer.addInventoryItem('bierebrune', 1)
		  
					Transform(source, zone)	  
				end)
			end
		elseif zone == "TraitementMalt" then
			local itemQuantity = xPlayer.getInventoryItem('malt').count
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_malt'))
				return
			else
				SetTimeout(1000, function()
					xPlayer.removeInventoryItem('malt', 2)
					xPlayer.addInventoryItem('whisky', 1)
		  
					Transform(source, zone)	  
				end)
			end
		end
	end	
end

RegisterServerEvent('esx_brasseurjob:startTransform')
AddEventHandler('esx_brasseurjob:startTransform', function(zone)
	local _source = source
  	
	if PlayersTransforming[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersTransforming[_source]=false
	else
		PlayersTransforming[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
		Transform(_source,zone)
	end
end)

RegisterServerEvent('esx_brasseurjob:stopTransform')
AddEventHandler('esx_brasseurjob:stopTransform', function()

	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~transformer vos produits')
		PlayersTransforming[_source]=true
		
	end
end)

local function Sell1(source, zone)

	local xPlayer  = ESX.GetPlayerFromId(source)
	if PlayersSelling[source] == true then
		
		if zone == 'SellFarm' then
			if xPlayer.getInventoryItem('biereblonde').count <= 0 then
				biereblonde = 0
			else
				biereblonde = 1
			end
			
			if xPlayer.getInventoryItem('bierenoel').count <= 0 then
				bierenoel = 0
			else
				bierenoel = 1
			end
		
			if biereblonde == 0 and bierenoel == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('biereblonde').count <= 0 and bierenoel == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_biereblonde_sale'))
				biereblonde = 0
				return
			elseif xPlayer.getInventoryItem('bierenoel').count <= 0 and biereblonde == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_bierenoel_sale'))
				bierenoel = 0
				return
			else
				if (bierenoel == 1) then
					SetTimeout(1000, function()
					    local argent = math.random(10,10)
						local money = math.random(20,20)
						xPlayer.removeInventoryItem('bierenoel', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brasseur', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addMoney(argent)
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. argent)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell1(source,zone)
					end)
				elseif (biereblonde == 1) then
					SetTimeout(1000, function()
					    local argent = math.random(10,10)
						local money = math.random(20,20)
						xPlayer.removeInventoryItem('biereblonde', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brasseur', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addMoney(argent)
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. argent)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell1(source,zone)
					end)
				end
				
			end
		end
	end
end

RegisterServerEvent('esx_brasseurjob:startSell1')
AddEventHandler('esx_brasseurjob:startSell1', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell1(_source, zone)
	end

end)

RegisterServerEvent('esx_brasseurjob:stopSell1')
AddEventHandler('esx_brasseurjob:stopSell1', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end
end)

local function Sell2(source, zone)

	local xPlayer  = ESX.GetPlayerFromId(source)
	if PlayersSelling[source] == true then
	
		
		if zone == 'SellFarmA' then
			if xPlayer.getInventoryItem('bierebrune').count <= 0 then
				bierebrune = 0
			else
				bierebrune = 1
			end			
		
			if bierebrune == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('bierebrune').count <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_bierebrune_sale'))
				bierebrune = 0
				return
			else
				if (bierebrune == 1) then
					SetTimeout(1000, function()
					    local argent = math.random(10,10)
						local money = math.random(20,20)
						xPlayer.removeInventoryItem('bierebrune', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brasseur', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addMoney(argent)
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. argent)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell2(source,zone)
					end)
				end
				
			end
		end
	end
end

RegisterServerEvent('esx_brasseurjob:startSell2')
AddEventHandler('esx_brasseurjob:startSell2', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell2(_source, zone)
	end

end)

RegisterServerEvent('esx_brasseurjob:stopSell2')
AddEventHandler('esx_brasseurjob:stopSell2', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end
end)	

local function Sell3(source, zone)

	local xPlayer  = ESX.GetPlayerFromId(source)
	if PlayersSelling[source] == true then
		
		if zone == 'SellFarmB' then
			if xPlayer.getInventoryItem('whisky').count <= 0 then
				whisky = 0
			else
				whisky = 1
			end			
		
			if whisky == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('whisky').count <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_whisky_sale'))
				whisky = 0
				return
			else
				if (whisky == 1) then
					SetTimeout(1000, function()
					    local argent = math.random(10,10)
						local money = math.random(20,20)
						xPlayer.removeInventoryItem('whisky', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brasseur', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addMoney(argent)
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. argent)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell3(source,zone)
					end)
				end
				
			end
		end
	end
end

RegisterServerEvent('esx_brasseurjob:startSell3')
AddEventHandler('esx_brasseurjob:startSell3', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell3(_source, zone)
	end

end)

RegisterServerEvent('esx_brasseurjob:stopSell3')
AddEventHandler('esx_brasseurjob:stopSell3', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end

end)

RegisterServerEvent('esx_brasseurjob:getStockItem')
AddEventHandler('esx_brasseurjob:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brasseur', function(inventory)
		local item = inventory.getItem(itemName)
		local sourceItem = xPlayer.getInventoryItem(itemName)

		-- is there enough in the society?
		if count > 0 and item.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('player_cannot_hold'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', count, item.label))
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_brasseurjob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brasseur', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_brasseurjob:putStockItems')
AddEventHandler('esx_brasseurjob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brasseur', function(inventory)
		local item = inventory.getItem(itemName)
		local playerItemCount = xPlayer.getInventoryItem(itemName).count

		if item.count >= 0 and count <= playerItemCount then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, item.label))
	end)
end)

ESX.RegisterServerCallback('esx_brasseurjob:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterUsableItem('biereblonde', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('biereblonde', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 80000)
	TriggerClientEvent('esx_basicneeds:onDrinkBeer', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_biereblonde'))
end)

ESX.RegisterUsableItem('bierebrune', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bierebrune', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 100000)
	TriggerClientEvent('esx_basicneeds:onDrinkBeer', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bierebrune'))
end)

ESX.RegisterUsableItem('bierenoel', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bierenoel', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 450000)
	TriggerClientEvent('esx_basicneeds:onDrinkBeer', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bierenoel'))
end)

ESX.RegisterUsableItem('biere', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('biere', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 150000)
	TriggerClientEvent('esx_basicneeds:onDrinkBeer', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_biere'))
end)

ESX.RegisterUsableItem('bieresa', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bieresa', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 450000)
	TriggerClientEvent('esx_basicneeds:onDrinkBeer', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bieresa'))
end)
