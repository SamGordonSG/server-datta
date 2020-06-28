-----------------------------------------
-- Created and modify by L'ile Légale RP
-- SenSi and Kaminosekai
-----------------------------------------
ESX = nil
local PlayersTransforming, PlayersSelling, PlayersHarvesting = {}, {}, {}
local citronvert, cachaca, cassonade, caipirinha = 1, 1, 1, 1

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local function Harvest(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "CitronFarm" then
			local itemQuantity = xPlayer.getInventoryItem('citronvert').count
			if itemQuantity >= 100 then
				xPlayer.showNotification(_U('not_enough_place'))
				return
			else
				SetTimeout(800, function()
					xPlayer.addInventoryItem('citronvert', 1)
					Harvest(source, zone)
				end)
			end
		end

		if zone == "CachacaFarm" then
			local itemQuantity = xPlayer.getInventoryItem('cachaca').count
			if itemQuantity >= 100 then
				xPlayer.showNotification(_U('not_enough_place'))
				return
			else
				SetTimeout(800, function()
					xPlayer.addInventoryItem('cachaca', 1)
					Harvest(source, zone)
				end)
			end
		end

		if zone == "CassonadeFarm" then
			local itemQuantity = xPlayer.getInventoryItem('cassonade').count
			if itemQuantity >= 100 then
				xPlayer.showNotification(_U('not_enough_place'))
				return
			else
				SetTimeout(800, function()
					xPlayer.addInventoryItem('cassonade', 1)
					Harvest(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('esx_runbaha:startHarvest')
AddEventHandler('esx_runbaha:startHarvest', function(zone)
	local _source = source
  	
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('para_taken'))  
		Harvest(_source,zone)
end)

RegisterServerEvent('esx_runbaha:stopHarvest')
AddEventHandler('esx_runbaha:stopHarvest', function()
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
		if zone == "TraitementCaipirinha" then
			local cassonadeQuantity = xPlayer.getInventoryItem('cassonade').count
			local citronvertQuantity = xPlayer.getInventoryItem('citronvert').count
			local cachacaQuantity = xPlayer.getInventoryItem('cachaca').count

			if cassonadeQuantity <= 0 then
				xPlayer.showNotification(_U('not_enough_para'))
				return
			elseif citronvertQuantity <= 0 then
				xPlayer.showNotification(_U('not_enough_para'))
				return
			elseif cachacaQuantity <= 0 then
				xPlayer.showNotification(_U('not_enough_para'))
				return
			else
				SetTimeout(500, function()
					xPlayer.removeInventoryItem('cassonade', 1)
					xPlayer.removeInventoryItem('citronvert', 1)
					xPlayer.removeInventoryItem('cachaca', 1)
					xPlayer.addInventoryItem('caipirinha', 1)
					xPlayer.showNotification(_U('caipirinha'))
					Transform(source, zone)
				end)
			end
		end
	end	
end

RegisterServerEvent('esx_runbaha:startTransform')
AddEventHandler('esx_runbaha:startTransform', function(zone)
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

RegisterServerEvent('esx_runbaha:stopTransform')
AddEventHandler('esx_runbaha:stopTransform', function()
	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~ mixer votre coktail')
		PlayersTransforming[_source]=true
	end
end)

local function Sell(source, zone)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		
		if zone == 'SellFarm' then
			if xPlayer.getInventoryItem('caipirinha').count <= 0 then
				caipirinha = 0
			else
				caipirinha = 1
			end
		
			if caipirinha == 0 then
				xPlayer.showNotification(_U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('caipirinha').count <= 0 then
				xPlayer.showNotification(_U('no_dafa_sale'))
				caipirinha = 0
				return
			else
				if (caipirinha == 1) then
					SetTimeout(500, function()
						local money = math.random(30,45)
						xPlayer.removeInventoryItem('caipirinha', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bahama_mamas', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						xPlayer.addMoney(tonumber(money/2))
						
						Sell(source,zone)
					end)
				end
			end
		end
	end
end

RegisterServerEvent('esx_runbaha:startSell')
AddEventHandler('esx_runbaha:startSell', function(zone)
	local _source = source

	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell(_source, zone)
	end
end)

RegisterServerEvent('esx_runbaha:stopSell')
AddEventHandler('esx_runbaha:stopSell', function()
	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end
end)

ESX.RegisterServerCallback('esx_runbaha:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})
end)

ESX.RegisterUsableItem('caipirinha', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('caipirinha', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 300000)
	TriggerClientEvent('esx_status:remove', source, 'hunger', 50000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 50000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
end)