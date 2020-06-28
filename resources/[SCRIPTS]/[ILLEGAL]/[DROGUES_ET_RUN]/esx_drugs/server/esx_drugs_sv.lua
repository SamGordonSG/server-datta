ESX 						   = nil
local CopsConnected       	   = 0
local PlayersHarvestingCoke    = {}
local PlayersTransformingCoke  = {}
local PlayersSellingCoke       = {}
local PlayersHarvestingMeth    = {}
------------------------------------------------------
------------------------------------------------------
local PlayersHarvestingMethlab = {}
local PlayersHarvestingAcetone = {}
local PlayersHarvestingLithium = {}
------------------------------------------------------
------------------------------------------------------
local PlayersTransformingMeth  = {}
local PlayersSellingMeth       = {}
local PlayersHarvestingOpium   = {}
local PlayersTransformingOpium = {}
local PlayersSellingOpium      = {}
local PlayersHarvestingCrack       = {}
local PlayersTransformingCrack     = {}
local PlayersSellingCrack          = {}
local PlayersHarvestingKetamine    = {}
local PlayersTransformingKetamine  = {}
local PlayersSellingKetamine       = {}
local PlayersHarvestingEcstasy     = {}
local PlayersTransformingEcstasy   = {}
local PlayersSellingEcstasy        = {}
local PlayersHarvestingBillet      = {}
local PlayersTransformingBillet    = {}
local PlayersSellingBillet         = {}
----------------------------------------------------
----------------------------------------------------
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

--coke
local function HarvestCoke(source)

	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingCoke[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local coke = xPlayer.getInventoryItem('coke')

			if coke.limit ~= -1 and coke.count >= coke.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_coke'))
			else
				xPlayer.addInventoryItem('coke', 1)
				HarvestCoke(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestCoke')
AddEventHandler('esx_drugs:startHarvestCoke', function()

	local _source = source

	PlayersHarvestingCoke[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestCoke(_source)

end)

RegisterServerEvent('esx_drugs:stopHarvestCoke')
AddEventHandler('esx_drugs:stopHarvestCoke', function()

	local _source = source

	PlayersHarvestingCoke[_source] = false

end)

local function TransformCoke(source)

	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	SetTimeout(Config.TimeToProcess, function()

		if PlayersTransformingCoke[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local cokeQuantity = xPlayer.getInventoryItem('coke').count
			local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count

			if poochQuantity > 100 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif cokeQuantity < 1 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_coke'))
			else
				xPlayer.removeInventoryItem('coke', 1)
				xPlayer.addInventoryItem('coke_pooch', 2)
			
				TransformCoke(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformCoke')
AddEventHandler('esx_drugs:startTransformCoke', function()

	local _source = source

	PlayersTransformingCoke[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformCoke(_source)

end)

RegisterServerEvent('esx_drugs:stopTransformCoke')
AddEventHandler('esx_drugs:stopTransformCoke', function()

	local _source = source

	PlayersTransformingCoke[_source] = false

end)

local function SellCoke(source)

	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	SetTimeout(Config.TimeToSell, function()

		if PlayersSellingCoke[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('coke_pooch', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 305)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 315)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 325)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 335)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 345)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected >= 5 then
					xPlayer.addAccountMoney('black_money', 355)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				end
				
				SellCoke(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellCoke')
AddEventHandler('esx_drugs:startSellCoke', function()

	local _source = source

	PlayersSellingCoke[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellCoke(_source)

end)

RegisterServerEvent('esx_drugs:stopSellCoke')
AddEventHandler('esx_drugs:stopSellCoke', function()

	local _source = source

	PlayersSellingCoke[_source] = false

end)

--Crack
local function HarvestCrack(source)

	if CopsConnected < Config.RequiredCopsCrack then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCrack))
		return
	end

	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingCrack[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local crack = xPlayer.getInventoryItem('crack')

			if crack.limit ~= -1 and crack.count >= crack.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_crack'))
			else
				xPlayer.addInventoryItem('crack', 1)
				HarvestCrack(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestCrack')
AddEventHandler('esx_drugs:startHarvestCrack', function()

	local _source = source

	PlayersHarvestingCrack[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestCrack(_source)

end)

RegisterServerEvent('esx_drugs:stopHarvestCrack')
AddEventHandler('esx_drugs:stopHarvestCrack', function()

	local _source = source

	PlayersHarvestingCrack[_source] = false

end)

local function TransformCrack(source)

	if CopsConnected < Config.RequiredCopsCrack then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCrack))
		return
	end

	SetTimeout(Config.TimeToProcess, function()

		if PlayersTransformingCrack[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local crackQuantity = xPlayer.getInventoryItem('crack').count
			local poochQuantity = xPlayer.getInventoryItem('crack_pooch').count

			if poochQuantity > 100 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif crackQuantity < 1 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_crack'))
			else
				xPlayer.removeInventoryItem('crack', 5)
				xPlayer.addInventoryItem('crack_pooch', 1)
			
				TransformCrack(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformCrack')
AddEventHandler('esx_drugs:startTransformCrack', function()

	local _source = source

	PlayersTransformingCrack[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformCrack(_source)

end)

RegisterServerEvent('esx_drugs:stopTransformCrack')
AddEventHandler('esx_drugs:stopTransformCrack', function()

	local _source = source

	PlayersTransformingCrack[_source] = false

end)

local function SellCrack(source)

	if CopsConnected < Config.RequiredCopsCrack then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCrack))
		return
	end

	SetTimeout(Config.TimeToSell, function()

		if PlayersSellingCrack[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('crack_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('crack_pooch', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 125)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_crack'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 135)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_crack'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 145)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_crack'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 155)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_crack'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 165)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_crack'))
				elseif CopsConnected >= 5 then
					xPlayer.addAccountMoney('black_money', 175)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_crack'))
				end
				
				SellCrack(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellCrack')
AddEventHandler('esx_drugs:startSellCrack', function()

	local _source = source

	PlayersSellingCrack[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellCrack(_source)

end)

RegisterServerEvent('esx_drugs:stopSellCrack')
AddEventHandler('esx_drugs:stopSellCrack', function()

	local _source = source

	PlayersSellingCrack[_source] = false

end)

--meth
local function HarvestMeth(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end
	
	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingMeth[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local meth = xPlayer.getInventoryItem('meth')

			if meth.limit ~= -1 and meth.count >= meth.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_meth'))
			else
				xPlayer.addInventoryItem('meth', 1)
				HarvestMeth(source)
			end

		end
	end)
end
------------------------------------------------------
------------------------------------------------------
local function HarvestMethlab(source)

	if CopsConnected < Config.RequiredCopsMethlab then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMethlab))
		return
	end
	
	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingMethlab[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local methlab = xPlayer.getInventoryItem('methlab')

			if methlab.limit ~= -1 and methlab.count >= methlab.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_methlab'))
			else
				xPlayer.addInventoryItem('methlab', 1)
				HarvestMethlab(source)
			end

		end
	end)
end

local function HarvestAcetone(source)

	if CopsConnected < Config.RequiredCopsAcetone then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsAcetone))
		return
	end
	
	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingAcetone[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local acetone = xPlayer.getInventoryItem('acetone')

			if acetone.limit ~= -1 and acetone.count >= acetone.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_acetone'))
			else
				xPlayer.addInventoryItem('acetone', 1)
				HarvestAcetone(source)
			end

		end
	end)
end

local function HarvestLithium(source)

	if CopsConnected < Config.RequiredCopsLithium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsLithium))
		return
	end
	
	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingLithium[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local lithium = xPlayer.getInventoryItem('lithium')

			if lithium.limit ~= -1 and lithium.count >= lithium.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_lithium'))
			else
				xPlayer.addInventoryItem('lithium', 1)
				HarvestLithium(source)
			end

		end
	end)
end
------------------------------------------------------
------------------------------------------------------

RegisterServerEvent('esx_drugs:startHarvestMeth')
AddEventHandler('esx_drugs:startHarvestMeth', function()

	local _source = source

	PlayersHarvestingMeth[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestMeth(_source)

end)

------------------------------------------------------
------------------------------------------------------
RegisterServerEvent('esx_drugs:startHarvestMethlab')
AddEventHandler('esx_drugs:startHarvestMethlab', function()

	local _source = source

	PlayersHarvestingMethlab[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestMethlab(_source)

end)

RegisterServerEvent('esx_drugs:startHarvestAcetone')
AddEventHandler('esx_drugs:startHarvestAcetone', function()

	local _source = source

	PlayersHarvestingAcetone[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestAcetone(_source)

end)

RegisterServerEvent('esx_drugs:startHarvestLithium')
AddEventHandler('esx_drugs:startHarvestLithium', function()

	local _source = source

	PlayersHarvestingLithium[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestLithium(_source)

end)
------------------------------------------------------
------------------------------------------------------

RegisterServerEvent('esx_drugs:stopHarvestMeth')
AddEventHandler('esx_drugs:stopHarvestMeth', function()

	local _source = source

	PlayersHarvestingMeth[_source] = false

end)

------------------------------------------------------
------------------------------------------------------
RegisterServerEvent('esx_drugs:stopHarvestMethlab')
AddEventHandler('esx_drugs:stopHarvestMethlab', function()

	local _source = source

	PlayersHarvestingMethlab[_source] = false

end)

RegisterServerEvent('esx_drugs:stopHarvestAcetone')
AddEventHandler('esx_drugs:stopHarvestAcetone', function()

	local _source = source

	PlayersHarvestingAcetone[_source] = false

end)

RegisterServerEvent('esx_drugs:stopHarvestLithium')
AddEventHandler('esx_drugs:stopHarvestLithium', function()

	local _source = source

	PlayersHarvestingLithium[_source] = false

end)
------------------------------------------------------
------------------------------------------------------

local function TransformMeth(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end

	SetTimeout(Config.TimeToProcess, function()

		if PlayersTransformingMeth[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local methQuantity = xPlayer.getInventoryItem('meth').count
			local poochQuantity = xPlayer.getInventoryItem('meth_pooch').count

			if poochQuantity > 35 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif methQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_meth'))
			else
				xPlayer.removeInventoryItem('meth', 5)
				xPlayer.addInventoryItem('meth_pooch', 1)
				
				TransformMeth(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformMeth')
AddEventHandler('esx_drugs:startTransformMeth', function()

	local _source = source

	PlayersTransformingMeth[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformMeth(_source)

end)

RegisterServerEvent('esx_drugs:stopTransformMeth')
AddEventHandler('esx_drugs:stopTransformMeth', function()

	local _source = source

	PlayersTransformingMeth[_source] = false

end)

local function SellMeth(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end

	SetTimeout(Config.TimeToSell, function()

		if PlayersSellingMeth[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('meth_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', _source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('meth_pooch', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 240)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 250)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 260)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 270)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 280)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				elseif CopsConnected == 5 then
					xPlayer.addAccountMoney('black_money', 290)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				elseif CopsConnected >= 6 then
					xPlayer.addAccountMoney('black_money', 300)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				end
				
				SellMeth(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellMeth')
AddEventHandler('esx_drugs:startSellMeth', function()

	local _source = source

	PlayersSellingMeth[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellMeth(_source)

end)

RegisterServerEvent('esx_drugs:stopSellMeth')
AddEventHandler('esx_drugs:stopSellMeth', function()

	local _source = source

	PlayersSellingMeth[_source] = false

end)

--ketamine
local function HarvestKetamine(source)

	if CopsConnected < Config.RequiredCopsKetamine then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsKetamine))
		return
	end
	
	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingKetamine[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local ketamine = xPlayer.getInventoryItem('ketamine')

			if ketamine.limit ~= -1 and ketamine.count >= ketamine.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_ketamine'))
			else
				xPlayer.addInventoryItem('ketamine', 1)
				HarvestKetamine(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestKetamine')
AddEventHandler('esx_drugs:startHarvestKetamine', function()

	local _source = source

	PlayersHarvestingKetamine[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestKetamine(_source)

end)

RegisterServerEvent('esx_drugs:stopHarvestKetamine')
AddEventHandler('esx_drugs:stopHarvestKetamine', function()

	local _source = source

	PlayersHarvestingKetamine[_source] = false

end)

local function TransformKetamine(source)

	if CopsConnected < Config.RequiredCopsKetamine then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsKetamine))
		return
	end

	SetTimeout(Config.TimeToProcess, function()

		if PlayersTransformingKetamine[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local ketamineQuantity = xPlayer.getInventoryItem('ketamine').count
			local poochQuantity = xPlayer.getInventoryItem('ketamine_pooch').count

			if poochQuantity > 35 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif ketamineQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_ketamine'))
			else
				xPlayer.removeInventoryItem('ketamine', 5)
				xPlayer.addInventoryItem('ketamine_pooch', 1)
				
				TransformKetamine(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformKetamine')
AddEventHandler('esx_drugs:startTransformKetamine', function()

	local _source = source

	PlayersTransformingKetamine[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformKetamine(_source)

end)

RegisterServerEvent('esx_drugs:stopTransformKetamine')
AddEventHandler('esx_drugs:stopTransformKetamine', function()

	local _source = source

	PlayersTransformingKetamine[_source] = false

end)

local function SellKetamine(source)

	if CopsConnected < Config.RequiredCopsKetamine then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsKetamine))
		return
	end

	SetTimeout(Config.TimeToSell, function()

		if PlayersSellingKetamine[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('ketamine_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', _source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('ketamine_pooch', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 425)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_ketamine'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 440)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_ketamine'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 455)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_ketamine'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 470)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_ketamine'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 485)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_ketamine'))
				elseif CopsConnected == 5 then
					xPlayer.addAccountMoney('black_money', 500)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_ketamine'))
				elseif CopsConnected >= 6 then
					xPlayer.addAccountMoney('black_money', 515)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_ketamine'))
				end
				
				SellKetamine(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellKetamine')
AddEventHandler('esx_drugs:startSellKetamine', function()

	local _source = source

	PlayersSellingKetamine[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellKetamine(_source)

end)

RegisterServerEvent('esx_drugs:stopSellKetamine')
AddEventHandler('esx_drugs:stopSellKetamine', function()

	local _source = source

	PlayersSellingKetamine[_source] = false

end)

--ecstasy
local function HarvestEcstasy(source)

	if CopsConnected < Config.RequiredCopsEcstasy then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsEcstasy))
		return
	end

	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingEcstasy[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local ecstasy = xPlayer.getInventoryItem('ecstasy')

			if ecstasy.limit ~= -1 and ecstasy.count >= ecstasy.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_ecstasy'))
			else
				xPlayer.addInventoryItem('ecstasy', 1)
				HarvestEcstasy(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestEcstasy')
AddEventHandler('esx_drugs:startHarvestEcstasy', function()

	local _source = source

	PlayersHarvestingEcstasy[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestEcstasy(_source)

end)

RegisterServerEvent('esx_drugs:stopHarvestEcstasy')
AddEventHandler('esx_drugs:stopHarvestEcstasy', function()

	local _source = source

	PlayersHarvestingEcstasy[_source] = false

end)

local function TransformEcstasy(source)

	if CopsConnected < Config.RequiredCopsEcstasy then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsEcstasy))
		return
	end

	SetTimeout(Config.TimeToProcess, function()

		if PlayersTransformingEcstasy[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)
			local ecstasyQuantity = xPlayer.getInventoryItem('ecstasy').count
			local poochQuantity = xPlayer.getInventoryItem('ecstasy_pooch').count

			if poochQuantity > 35 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif ecstasyQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_ecstasy'))
			else
				xPlayer.removeInventoryItem('ecstasy', 5)
				xPlayer.addInventoryItem('ecstasy_pooch', 1)
				
				TransformEcstasy(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformEcstasy')
AddEventHandler('esx_drugs:startTransformEcstasy', function()

	local _source = source

	PlayersTransformingEcstasy[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformEcstasy(_source)

end)

RegisterServerEvent('esx_drugs:stopTransformEcstasy')
AddEventHandler('esx_drugs:stopTransformEcstasy', function()

	local _source = source

	PlayersTransformingEcstasy[_source] = false

end)

local function SellEcstasy(source)

	if CopsConnected < Config.RequiredCopsEcstasy then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsEcstasy))
		return
	end

	SetTimeout(Config.TimeToSell, function()

		if PlayersSellingEcstasy[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('ecstasy_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('ecstasy_pooch', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 365)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_ecstasy'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 375)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_ecstasy'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 385)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_ecstasy'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 395)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_ecstasy'))
				elseif CopsConnected >= 4 then
					xPlayer.addAccountMoney('black_money', 405)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_ecstasy'))
				end
				
				SellEcstasy(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellEcstasy')
AddEventHandler('esx_drugs:startSellEcstasy', function()

	local _source = source

	PlayersSellingEcstasy[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellEcstasy(_source)

end)

RegisterServerEvent('esx_drugs:stopSellEcstasy')
AddEventHandler('esx_drugs:stopSellEcstasy', function()

	local _source = source

	PlayersSellingEcstasy[_source] = false

end)

--opium

local function HarvestOpium(source)

	if CopsConnected < Config.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingOpium[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local opium = xPlayer.getInventoryItem('opium')

			if opium.limit ~= -1 and opium.count >= opium.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_opium'))
			else
				xPlayer.addInventoryItem('opium', 1)
				HarvestOpium(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestOpium')
AddEventHandler('esx_drugs:startHarvestOpium', function()

	local _source = source

	PlayersHarvestingOpium[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestOpium(_source)

end)

RegisterServerEvent('esx_drugs:stopHarvestOpium')
AddEventHandler('esx_drugs:stopHarvestOpium', function()

	local _source = source

	PlayersHarvestingOpium[_source] = false

end)

local function TransformOpium(source)

	if CopsConnected < Config.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	SetTimeout(Config.TimeToProcess, function()

		if PlayersTransformingOpium[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)

			local opiumQuantity = xPlayer.getInventoryItem('opium').count
			local poochQuantity = xPlayer.getInventoryItem('opium_pooch').count

			if poochQuantity > 35 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif opiumQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_opium'))
			else
				xPlayer.removeInventoryItem('opium', 5)
				xPlayer.addInventoryItem('opium_pooch', 1)
			
				TransformOpium(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformOpium')
AddEventHandler('esx_drugs:startTransformOpium', function()

	local _source = source

	PlayersTransformingOpium[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformOpium(_source)

end)

RegisterServerEvent('esx_drugs:stopTransformOpium')
AddEventHandler('esx_drugs:stopTransformOpium', function()

	local _source = source

	PlayersTransformingOpium[_source] = false

end)

local function SellOpium(source)

	if CopsConnected < Config.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	SetTimeout(Config.TimeToSell, function()

		if PlayersSellingOpium[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('opium_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('opium_pooch', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 180)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 190)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 200)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 210)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 220)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
				elseif CopsConnected >= 5 then
					xPlayer.addAccountMoney('black_money', 230)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
				end
				
				SellOpium(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellOpium')
AddEventHandler('esx_drugs:startSellOpium', function()

	local _source = source

	PlayersSellingOpium[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellOpium(_source)

end)

RegisterServerEvent('esx_drugs:stopSellOpium')
AddEventHandler('esx_drugs:stopSellOpium', function()

	local _source = source

	PlayersSellingOpium[_source] = false

end)

-- billet

local function HarvestBillet(source)

	if CopsConnected < Config.RequiredCopsBillet then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsBillet))
		return
	end

	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingBillet[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local billet = xPlayer.getInventoryItem('billet')

			if billet.limit ~= -1 and billet.count >= billet.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_billet'))
			else
				xPlayer.addInventoryItem('billet', 1)
				HarvestBillet(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestBillet')
AddEventHandler('esx_drugs:startHarvestBillet', function()

	local _source = source

	PlayersHarvestingBillet[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestBillet(_source)

end)

RegisterServerEvent('esx_drugs:stopHarvestBillet')
AddEventHandler('esx_drugs:stopHarvestBillet', function()

	local _source = source

	PlayersHarvestingBillet[_source] = false

end)

local function TransformBillet(source)

	if CopsConnected < Config.RequiredCopsBillet then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsBillet))
		return
	end

	SetTimeout(Config.TimeToProcess, function()

		if PlayersTransformingBillet[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)

			local billetQuantity = xPlayer.getInventoryItem('billet').count
			local poochQuantity = xPlayer.getInventoryItem('billet_pooch').count

			if poochQuantity > 35 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif billetQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_billet'))
			else
				xPlayer.removeInventoryItem('billet', 5)
				xPlayer.addInventoryItem('billet_pooch', 1)
			
				TransformBillet(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformBillet')
AddEventHandler('esx_drugs:startTransformBillet', function()

	local _source = source

	PlayersTransformingBillet[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformBillet(_source)

end)

RegisterServerEvent('esx_drugs:stopTransformBillet')
AddEventHandler('esx_drugs:stopTransformBillet', function()

	local _source = source

	PlayersTransformingBillet[_source] = false

end)

local function SellBillet(source)

	if CopsConnected < Config.RequiredCopsBillet then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsBillet))
		return
	end

	SetTimeout(Config.TimeToSell, function()

		if PlayersSellingBillet[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('billet_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('billet_pooch', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 270)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_billet'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 290)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_billet'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 310)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_billet'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 330)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_billet'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 350)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_billet'))
				elseif CopsConnected >= 5 then
					xPlayer.addAccountMoney('black_money', 370)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_billet'))
				end
				
				SellBillet(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellBillet')
AddEventHandler('esx_drugs:startSellBillet', function()

	local _source = source

	PlayersSellingBillet[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellBillet(_source)

end)

RegisterServerEvent('esx_drugs:stopSellBillet')
AddEventHandler('esx_drugs:stopSellBillet', function()

	local _source = source

	PlayersSellingBillet[_source] = false

end)
-------------------------------------------------------------------------------

RegisterServerEvent('esx_drugs:GetUserInventory')
AddEventHandler('esx_drugs:GetUserInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
	TriggerClientEvent('esx_drugs:ReturnInventory', 
		_source, 
	xPlayer.getInventoryItem('coke').count,
		xPlayer.getInventoryItem('coke_pooch').count,
		xPlayer.getInventoryItem('meth').count,
		xPlayer.getInventoryItem('meth_pooch').count,
		----------------------------------------------
		xPlayer.getInventoryItem('crack').count, 
		xPlayer.getInventoryItem('crack_pooch').count,
		xPlayer.getInventoryItem('ketamine').count, 
		xPlayer.getInventoryItem('ketamine_pooch').count, 
		xPlayer.getInventoryItem('ecstasy').count, 
		xPlayer.getInventoryItem('ecstasy_pooch').count,
		----------------------------------------------
		xPlayer.getInventoryItem('billet').count, 
		xPlayer.getInventoryItem('billet_pooch').count,
		----------------------------------------------
		xPlayer.getInventoryItem('opium').count, 
		xPlayer.getInventoryItem('opium_pooch').count,
		xPlayer.job.name,
		currentZone
	)
	end
end)

ESX.RegisterUsableItem('coke_pooch', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('coke_pooch', 1)

	TriggerClientEvent('esx_drugs:onPoth', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_coke'))
end)

ESX.RegisterUsableItem('meth_pooch', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('meth_pooch', 1)

	TriggerClientEvent('esx_drugs:onPotj', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_meth'))
end)

ESX.RegisterUsableItem('crack_pooch', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('crack_pooch', 1)

	TriggerClientEvent('esx_drugs:onPotj', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_crack'))
end)

ESX.RegisterUsableItem('ketamine_pooch', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('ketamine_pooch', 1)

	TriggerClientEvent('esx_drugs:onPoth', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_ketamine'))
end)

ESX.RegisterUsableItem('exstasy_pooch', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('exstasy_pooch', 1)

	TriggerClientEvent('esx_drugs:onPot', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_exstasy'))
end)

ESX.RegisterUsableItem('opium_pooch', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('opium_pooch', 1)

	TriggerClientEvent('esx_drugs:onPot', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_opium'))
end)