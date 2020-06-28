-------------------------------------------------
--Modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData				= {}
local FirstSpawn				= true
local IsDead					= false
local HasAlreadyEnteredMarker	= false
local LastZone					= nil
local CurrentAction				= nil
local CurrentActionMsg			= ''
local CurrentActionData			= {}
local IsBusy					= false
local IsHandcuffed				= false
local DragStatus              = {}
DragStatus.IsDragged          = false
local EmsPed                    = 0

ESX								= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 3,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 3,
		modArmor = 		  4,
		modTurbo        = true,
		windowTint = 1,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end

function RespawnPed(ped, coords)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(_type)
	local playerPed = GetPlayerPed(-1)
	local maxHealth = GetEntityMaxHealth(playerPed)
	if _type == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth , math.floor(health + maxHealth/8))
		SetEntityHealth(playerPed, newHealth)
	elseif _type == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	elseif _type == 'extrasmall' then 
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth , math.floor(health + maxHealth/12))
		SetEntityHealth(playerPed, newHealth)
	end
	ESX.ShowNotification(_U('healed'))
end)


function StartRespawnTimer()
	Citizen.SetTimeout(Config.RespawnDelayAfterRPDeath, function()
		if IsDead then
			RemoveItemsAfterRPDeath()
		end
	end)
end

function StartDistressSignal()
	Citizen.CreateThread(function()
		local timer = Config.RespawnDelayAfterRPDeath

		while timer > 0 and IsDead do
			Citizen.Wait(2)
			timer = timer - 30

			SetTextFont(4)
			SetTextProportional(1)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropShadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_send'))
			EndTextCommandDisplayText(0.175, 0.805)

			if IsControlPressed(0, Keys['G']) then
				SendDistressSignal()
				break
			end
		end
	end)
end

function SendDistressSignal()
	local playerPed = GetPlayerPed(-1)
	local coords	= GetEntityCoords(playerPed)

	ESX.ShowNotification(_U('distress_sent'))
	TriggerServerEvent('esx_phone:send', 'ambulance', _U('distress_message'), false, {
		x = coords.x,
		y = coords.y,
		z = coords.z
	})
end

function ShowDeathTimer()
	local respawnTimer = Config.RespawnDelayAfterRPDeath
	local allowRespawn = Config.RespawnDelayAfterRPDeath/2
	local fineAmount = Config.EarlyRespawnFineAmount
	local payFine = false

	if Config.EarlyRespawn and Config.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(finePayable)
			if finePayable then
				payFine = true
			else
				payFine = false
			end
		end)
	end

	Citizen.CreateThread(function()
		while respawnTimer > 0 and IsDead do
			Citizen.Wait(0)

			raw_seconds = respawnTimer/1000
			raw_minutes = raw_seconds/60
			minutes = stringsplit(raw_minutes, ".")[1]
			seconds = stringsplit(raw_seconds-(minutes*60), ".")[1]

			SetTextFont(4)
			SetTextProportional(0)
			SetTextScale(0.0, 0.5)
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()

			local text = _U('please_wait', minutes, seconds)

			if Config.EarlyRespawn then
				if not Config.EarlyRespawnFine and respawnTimer <= allowRespawn then
					text = text .. _U('press_respawn')
				elseif Config.EarlyRespawnFine and respawnTimer <= allowRespawn and payFine then
					text = text .. _U('respawn_now_fine', fineAmount)
				else
					text = text
				end
			end

			SetTextCentre(true)
			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)

			if Config.EarlyRespawn then
				if not Config.EarlyRespawnFine then
					if IsControlPressed(0, Keys['E']) then
						RemoveItemsAfterRPDeath()
						break
					end
				elseif Config.EarlyRespawnFine then
					if respawnTimer <= allowRespawn and payFine then
						if IsControlPressed(0, Keys['E']) then
							PayFine()
							break
						end
					end
				end
			end
			respawnTimer = respawnTimer - 15
		end
	end)
end

function RemoveItemsAfterRPDeath()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', 0)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)
		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			ESX.SetPlayerData('lastPosition', Config.Zones.HospitalInteriorInside1.Pos)
			ESX.SetPlayerData('loadout', {})

			TriggerServerEvent('esx:updateLastPosition', Config.Zones.HospitalInteriorInside1.Pos)
			RespawnPed(GetPlayerPed(-1), Config.Zones.HospitalInteriorInside1.Pos)

			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end)
end

--------add effect when the player come back after death-----
--[[local time = 0
local shakeEnable = false

RegisterNetEvent('shakeCam')
AddEventHandler('shakeCam', function(status)
	if(status == true)then
		ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
		shakeEnable = true
	elseif(status == false)then
		ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0)
		shakeEnable = false
		time = 0
	end
end)

-----Enable/disable the effect by pills
Citizen.CreateThread(function()
	while true do
		Wait(100)
		if(shakeEnable)then
			time = time + 100
			if(time > 5000)then -- 5 seconds
				TriggerEvent('shakeCam', false)
			end
		end
	end
]]--end)

-------------------------------------------------------

function PayFine()
	ESX.TriggerServerCallback('esx_ambulancejob:payFine', function()
	RemoveItemsAfterRPDeath()
	end)
end

function OnPlayerDeath()
	IsDead = true
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', 1)
	
	if IsControlPressed(0,  Keys['BACKSPACE']) then
            ClearPedTasksImmediately(GetPlayerPed(-1))
            end

	if Config.ShowDeathTimer == true then
		ShowDeathTimer()
	end

	StartRespawnTimer()
	StartDistressSignal()

	ClearPedTasksImmediately(GetPlayerPed(-1))
	StartScreenEffect('DeathFailOut', 0, false)
end

function TeleportFadeEffect(entity, coords)

	Citizen.CreateThread(function()

		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		ESX.Game.Teleport(entity, coords, function()
			DoScreenFadeIn(800)
		end)

	end)

end

function WarpPedInClosestVehicle(ped)

	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle({
		x = coords.x,
		y = coords.y,
		z = coords.z
	})

	if distance ~= -1 and distance <= 5.0 then

		local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
		local freeSeat = nil

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat ~= nil then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end

	else
		ESX.ShowNotification(_U('no_vehicles'))
	end

end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('ems_wear'))
			end
			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('ems_wear'))
			end
			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

function OpenCloakroomMenu()
	local playerPed = GetPlayerPed(-1)
	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' },
		{ label = _U('ems_chef_ems'), value = 'chef_wear' },
		{ label = _U('bullet_wear'), value = 'bullet_wear' }
	}
	if PlayerData.job.grade_name == 'ambulance' then
		table.insert(elements, {label = _U('ems_wear'), value = 'ambulance_wear'})
	end
	if PlayerData.job.grade_name == 'doctor' then
		table.insert(elements, {label = _U('ems_wear'), value = 'doctor_wear'})
	end
	if PlayerData.job.grade_name == 'chief_doctor' then
		table.insert(elements, {label = _U('ems_wear'), value = 'chief_doctor_wear'})
	end
  	if PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('ems_wear'), value = 'boss_wear'})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
			{css='vestiaire',
				title    = _U('cloakroom'),
				align    = 'left',
				elements = elements,
			},
			function(data, menu)
				cleanPlayer(playerPed)
				if data.current.value == 'citizen_wear' then
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        				local model = nil
					if skin.sex == 0 then
						model = GetHashKey("mp_m_freemode_01")
					else
						model = GetHashKey("mp_f_freemode_01")
					end
					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(1)
					end
					SetPlayerModel(PlayerId(), model)
					SetModelAsNoLongerNeeded(model)
					TriggerEvent('skinchanger:loadSkin', skin)
					TriggerEvent('esx:restoreLoadout')
					local playerPed = GetPlayerPed(-1)
					SetPedArmour(playerPed, 0)
					ClearPedBloodDamage(playerPed)
					ResetPedVisibleDamage(playerPed)
					ClearPedLastWeaponDamage(playerPed)
				end)
			end
			if data.current.value == 'chef_wear' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						local model = GetHashKey("s_m_y_pilot_01")
						local clothesSkin = {
							['tshirt_1'] = 2, ['tshirt_2'] = 0,
							['torso_1'] = 0, ['torso_2'] = 0,
							['decals_1'] = 0, ['decals_2'] = 0,
							['arms'] = 0,
							['pants_1'] = 0, ['pants_2'] = 0,
							['shoes_1'] = 0, ['shoes_2'] = 0,
							['helmet_1'] = 0, ['helmet_2'] = 0,
							['glass_1'] = 0, ['glass_2'] = 0,
							['chain_1'] = 0, ['chain_2'] = 0,
							['ears_1'] = 0, ['ears_2'] = 0
						}
						RequestModel(model)
						while not HasModelLoaded(model) do
							RequestModel(model)
							Citizen.Wait(1)
						end
						SetPlayerModel(PlayerId(), model)
						SetModelAsNoLongerNeeded(model)
						TriggerEvent('skinchanger:loadSkin', skin)
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
						TriggerEvent('esx:restoreLoadout')
					else
						local model = GetHashKey("s_m_y_pilot_01")
						local clothesSkin = {
							['tshirt_1'] = 2, ['tshirt_2'] = 0,
							['torso_1'] = 0, ['torso_2'] = 0,
							['decals_1'] = 0, ['decals_2'] = 0,
							['arms'] = 0,
							['pants_1'] = 0, ['pants_2'] = 0,
							['shoes_1'] = 0, ['shoes_2'] = 0,
							['helmet_1'] = 0, ['helmet_2'] = 0,
							['glass_1'] = 0, ['glass_2'] = 0,
							['chain_1'] = 0, ['chain_2'] = 0,
							['ears_1'] = 0, ['ears_2'] = 0
						}
						RequestModel(model)
						while not HasModelLoaded(model) do
							RequestModel(model)
							Citizen.Wait(0)
						end
						SetPlayerModel(PlayerId(), model)
						SetModelAsNoLongerNeeded(model)
						TriggerEvent('skinchanger:loadSkin', skin)
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
						TriggerEvent('esx:restoreLoadout')
					end
				end)
			end
			if
				data.current.value == 'ambulance_wear' or
				data.current.value == 'doctor_wear' or
				data.current.value == 'chief_doctor_wear' or
				data.current.value == 'chef_wear' or
				data.current.value == 'boss_wear'or
				data.current.value == 'bullet_wear' 
			then
				setUniform(data.current.value, playerPed)
			end
			CurrentAction     = 'menu_cloakroom'
			CurrentActionMsg  = _U('open_cloackroom')
			CurrentActionData = {}
		end,
		function(data, menu)
			menu.close()
			CurrentAction     = 'menu_cloakroom'
			CurrentActionMsg  = _U('open_cloackroom')
			CurrentActionData = {}
		end
	)
end

function OpenVehicleSpawnerMenu()

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

			for i=1, #vehicles, 1 do
				table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
			end

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_spawner',
			{
			css = 'vehicle',
				title		= _U('veh_menu'),
				align		= 'top-left',
				elements = elements,
			}, function(data, menu)
				menu.close()

				local vehicleProps = data.current.value
				ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 355.0, function(vehicle)
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					local playerPed = GetPlayerPed(-1)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				end)
				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'ambulance', vehicleProps)

			end, function(data, menu)
				menu.close()
				CurrentAction		= 'vehicle_spawner_menu'
				CurrentActionMsg	= _U('veh_spawn')
				CurrentActionData	= {}
			end
			)
		end, 'ambulance')

	else -- not society vehicles

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vehicle_spawner',
		{
		css = 'vehicle',
			title		= _U('veh_menu'),
			align		= 'top-left',
			elements	= Config.AuthorizedVehicles
		}, function(data, menu)
			menu.close()
			local platenum = math.random(10, 9999)
			local platePrefix = Config.platePrefix
			ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint.Pos, 355.0, function(vehicle)
				local playerPed = GetPlayerPed(-1)
				TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
				SetVehicleDirtLevel(vehicle, 0)
				SetVehicleMaxMods(vehicle)
				SetVehicleNumberPlateText(vehicle, platePrefix .. platenum)
				plate = GetVehicleNumberPlateText(vehicle)
				plate = string.gsub(plate, " ", "")
				TriggerServerEvent('esx_vehiclelock:registerkeyjob', plate, 'no') -- vehicle lock
			end)
		end, function(data, menu)
			menu.close()
			CurrentAction		= 'vehicle_spawner_menu'
			CurrentActionMsg	= _U('veh_spawn')
			CurrentActionData	= {}
		end
		)
	end
end

--------------------------coffre-----------------------------------
function OpenVaultMenu()
	if Config.EnableVaultManagement then
		local elements = {
			{label = _U('put_weapon'), value = 'put_weapon'},
			{label = _U('put_stock'), value = 'put_stock'},
			{label = _U('get_weapon'), value = 'get_weapon'},
			{label = _U('get_stock'), value = 'get_stock'},
		}
		if PlayerData.job.grade_name == 'boss' then
			table.insert(elements, {label = _U('buy_weapons'), value = 'buy_weapons'})
		end
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vault',
			{css='entreprise',
				title    = _U('vault'),
				align    = 'left',
				elements = elements,
			},
			function(data, menu)
				if data.current.value == 'get_weapon' then
					OpenGetWeaponMenu()
				end
				if data.current.value == 'put_weapon' then
					OpenPutWeaponMenu()
				end
				if data.current.value == 'buy_weapons' then
					OpenBuyWeaponsMenu()
				end
				if data.current.value == 'put_stock' then
					OpenPutStocksMenu()
				end
				if data.current.value == 'get_stock' then
					OpenGetStocksMenu()
				end
			end,
			function(data, menu)
				menu.close()
				CurrentAction     = 'menu_vault'
				CurrentActionMsg  = _U('open_vault')
				CurrentActionData = {}
			end
		)
	else
		local elements = {}
		for i=1, #Config.AuthorizedWeapons, 1 do
			local weapon = Config.AuthorizedWeapons[i]
			table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})
		end
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vault',
			{css='entreprise',
				title    = _U('vault'),
				align    = 'left',
				elements = elements,
			},
			function(data, menu)
				local weapon = data.current.value
				TriggerServerEvent('esx_ambulancejob:giveWeapon', weapon,  1000)
			end,
			function(data, menu)
				menu.close()
				CurrentAction     = 'menu_vault'
				CurrentActionMsg  = _U('open_vault')
				CurrentActionData = {}
			end
		)
	end
end

---------------STOCKS-----------------
function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_ambulancejob:getStockItems', function(items)
		print(json.encode(items))
		local elements = {}
		for i=1, #items, 1 do
			table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
		end
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'stocks_menu',
			{css='entreprise',
				title    = _U('ambulance_stock'),
				elements = elements
			},
			function(data, menu)
				local itemName = data.current.value
				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
					{
						title = _U('quantity')
					},
					function(data2, menu2)
						local count = tonumber(data2.value)
						if count == nil then
							ESX.ShowNotification(_U('invalid_quantity'))
						else
							menu2.close()
							menu.close()
							OpenGetStocksMenu()
							TriggerServerEvent('esx_ambulancejob:getStockItem', itemName, count)
						end
					end,
					function(data2, menu2)
						menu2.close()
					end
				)
			end,
			function(data, menu)
				menu.close()
			end
		)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_ambulancejob:getPlayerInventory', function(inventory)
		local elements = {}
		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]
			if item.count > 0 then
				table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
			end
		end
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'stocks_menu',
			{
				title    = _U('inventory'),
				elements = elements
			},
			function(data, menu)
				local itemName = data.current.value
				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
					{
						title = _U('quantity')
					},
					function(data2, menu2)
						local count = tonumber(data2.value)
						if count == nil then
							ESX.ShowNotification(_U('invalid_quantity'))
						else
							menu2.close()
							menu.close()
							OpenPutStocksMenu()
							TriggerServerEvent('esx_ambulancejob:putStockItems', itemName, count)
						end
					end,
					function(data2, menu2)
						menu2.close()
					end
				)
			end,
			function(data, menu)
				menu.close()
			end
		)
	end)
end

----------------ARMES COFFRES-------------------

function OpenGetWeaponMenu()
	ESX.TriggerServerCallback('esx_ambulancejob:getVaultWeapons', function(weapons)
		local elements = {}
		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
			end
		end
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vault_get_weapon',
			{css='entreprise',
				title    = _U('get_weapon_menu'),
				align    = 'left',
				elements = elements,
			},
			function(data, menu)
				menu.close()
				ESX.TriggerServerCallback('esx_ambulancejob:removeVaultWeapon', function()
					OpenGetWeaponMenu()
				end, data.current.value)
			end,
			function(data, menu)
				menu.close()
			end
		)
	end)
end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = GetPlayerPed(-1)
	local weaponList = ESX.GetWeaponList()
	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)
		if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
			table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
		end
	end
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vault_put_weapon',
		{
			title    = _U('put_weapon_menu'),
			align    = 'left',
			elements = elements,
		},
		function(data, menu)
			menu.close()
			ESX.TriggerServerCallback('esx_ambulancejob:addVaultWeapon', function()
				OpenPutWeaponMenu()
			end, data.current.value)
		end,
		function(data, menu)
			menu.close()
		end
	)
end

---------------------------buy----------------------
function OpenBuyWeaponsMenu(station)
	ESX.TriggerServerCallback('esx_ambulancejob:getVaultWeapons', function(weapons)
		local elements = {}
		for i=1, #Config.AuthorizedWeapons, 1 do
			local weapon = Config.AuthorizedWeapons[i]
			local count  = 0
			for i=1, #weapons, 1 do
				if weapons[i].name == weapon.name then
					count = weapons[i].count
				break
			end
		end
		table.insert(elements, {label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price, value = weapon.name, price = weapon.price})
	end
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vault_buy_weapons',
		{css='entreprise',
			title    = _U('buy_weapon_menu'),
			align    = 'left',
			elements = elements,
		},
		function(data, menu)
			ESX.TriggerServerCallback('esx_ambulancejob:buy', function(hasEnoughMoney)
				if hasEnoughMoney then
					ESX.TriggerServerCallback('esx_ambulancejob:addVaultWeapon', function()
						OpenBuyWeaponsMenu(station)
					end, data.current.value)
				else
					ESX.ShowNotification(_U('not_enough_money'))
				end
			end, data.current.price)
		end,
		function(data, menu)
			menu.close()
		end
	)
	end)
end

--------------------------------------Action Menu-------------------------------------

function OpenMobileAmbulanceActionsMenu()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mobile_ambulance_actions',
		{css='metier',
			title    = _U('ambulance'),
			align    = 'left',
			elements = {
				{label = _U('citizen_interaction'), value = 'citizen_interaction'},
				{label = _U('object_spawner'),      value = 'object_spawner'},
				{label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
			},
		},
		function(data, menu)
			if data.current.value == 'citizen_interaction' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'citizen_interaction',
						{css='metier',
							title    = _U('citizen_interaction'),
							align    = 'left',
							elements = {
								{label = _U('id_card'),       value = 'identity_card'},
								{label = _U('ems_menu_revive'),     value = 'revive'},
								{label = _U('ems_menu_small'),      value = 'small'},
								{label = _U('ems_menu_big'),        value = 'big'},
								{label = 'Facture libre',			value = 'fineopen'},
								{label = _U('fine'),              value = 'fine'},
							}
						},
						function(data, menu)
							if data.current.value == 'revive' then
								menu.close()
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer == -1 or closestDistance > 5.0 then
									ESX.ShowNotification(_U('no_players'))
								else
									ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(qtty)
									if qtty > 0 then
										local closestPlayerPed = GetPlayerPed(closestPlayer)
										local health = GetEntityHealth(closestPlayerPed)
										if health == 0 then
											local playerPed = GetPlayerPed(-1)
											Citizen.CreateThread(function()
												ESX.ShowNotification(_U('revive_inprogress'))
												TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
												Wait(10000)
												ClearPedTasks(playerPed)
												if GetEntityHealth(closestPlayerPed) == 0 then
													TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
													TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
													ESX.ShowNotification(_U('revive_complete'))
												else
													ESX.ShowNotification(_U('isdead'))
												end
											end)
										else
											ESX.ShowNotification(_U('unconscious'))
										end
									else
										ESX.ShowNotification(_U('not_enough_medikit'))
									end
								end, 'medikit')
							end
						end
						if data.current.value == 'small' then
							menu.close()
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer == -1 or closestDistance > 3.0 then
								ESX.ShowNotification(_U('no_players'))
							else
								ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(qtty)
									if qtty > 0 then
										local playerPed = GetPlayerPed(-1)
										Citizen.CreateThread(function()
											ESX.ShowNotification(_U('heal_inprogress'))
											TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
											Wait(10000)
											ClearPedTasks(playerPed)
											TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
											TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
											ESX.ShowNotification(_U('heal_complete'))
										end)
									else
										ESX.ShowNotification(_U('not_enough_bandage'))
									end
								end, 'bandage')
							end
						end
						if data.current.value == 'big' then
							menu.close()
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer == -1 or closestDistance > 3.0 then
								ESX.ShowNotification(_U('no_players'))
							else
								ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(qtty)
								if qtty > 0 then
									local playerPed = GetPlayerPed(-1)
									Citizen.CreateThread(function()
										ESX.ShowNotification(_U('heal_inprogress'))
										TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
										Wait(10000)
										ClearPedTasks(playerPed)
										TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
										TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
										ESX.ShowNotification(_U('heal_complete'))
									end)
								else
							ESX.ShowNotification(_U('not_enough_medikit'))
						end
					end, 'medikit')
				end
			end
			local player, distance = ESX.Game.GetClosestPlayer()			
			if distance ~= -1 and distance <= 3.0 then
				if data.current.value == 'identity_card' then
					OpenIdentityCardMenu(player)
				end			   			  
				if data.current.value == 'drag' then
					TriggerServerEvent('esx_ambulancejob:drag', GetPlayerServerId(player))
				end
				if data.current.value == 'put_in_vehicle' then
					TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(player))
				end
				if data.current.value == 'out_the_vehicle' then
					TriggerServerEvent('esx_ambulancejob:OutVehicle', GetPlayerServerId(player))
				end
				if data.current.value == 'fine' then
					OpenFineMenu(player)
				end
				if data.current.value == 'fineopen' then					
					ESX.UI.Menu.Open(
						'dialog', GetCurrentResourceName(), 'billing',
						{
							title = _U('invoice_amount')
						},
						function(data, menu)
							local amount = tonumber(data.value)
							if amount == nil or amount < 0 then
								ESX.ShowNotification(_U('amount_invalid'))
							else
								menu.close()
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer == -1 or closestDistance > 3.0 then
									ESX.ShowNotification(_U('no_players_nearby'))
								else
									TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ambulance', 'Facture soins', amount)
								end
							end
						end,
						function(data, menu)
							menu.close()
						end
					)	
					end
				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end,
			function(data, menu)
				menu.close()
			end)
		end
		if data.current.value == 'vehicle_interaction' then
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'vehicle_interaction',
				{css='metier',
					title    = _U('vehicle_interaction'),
					align    = 'left',
					elements = {
						{label = _U('pick_lock'),    value = 'hijack_vehicle'},
					},
				},
				function(data2, menu2)
					local playerPed = GetPlayerPed(-1)
					local coords    = GetEntityCoords(playerPed)
					local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)
					if DoesEntityExist(vehicle) then
						local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
						if data2.current.value == 'hijack_vehicle' then
							local playerPed = GetPlayerPed(-1)
							local coords    = GetEntityCoords(playerPed)
							if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
								local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)
								if DoesEntityExist(vehicle) then
									Citizen.CreateThread(function()
										TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
										Wait(20000)
										ClearPedTasksImmediately(playerPed)
										SetVehicleDoorsLocked(vehicle, 1)
										SetVehicleDoorsLockedForAllPlayers(vehicle, false)
										TriggerEvent('esx:showNotification', _U('vehicle_unlocked'))
									end)
								end
							end
						end
					else
						ESX.ShowNotification(_U('no_vehicles_nearby'))
					end
				end,
				function(data2, menu2)
					menu2.close()
				end
			)
		end
		if data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'citizen_interaction',
				{css='metier',
					title    = _U('traffic_interaction'),
					align    = 'left',
					elements = {
						{label = _U('cone'),     value = 'prop_roadcone02a'},
						{label = _U('barrier'), value = 'prop_barrier_work06a'},
						{label = _U('chair'), value = 'prop_wheelchair_01'},
						{label = _U('trousse'), value = 'prop_ld_health_pack'},
						--{label = _U('stretcher'), value = 'prop_ld_binbag_01'}
					},
				},
				function(data2, menu2)
					local model     = data2.current.value
					local playerPed = GetPlayerPed(-1)
					local coords    = GetEntityCoords(playerPed)
					local forward   = GetEntityForwardVector(playerPed)
					local x, y, z   = table.unpack(coords + forward * 1.0)
					if model == 'prop_roadcone02a' then
						z = z - 1.0
					end
					if model == 'prop_wheelchair_01' then
						z = z - 0.5
					end
					if model == 'prop_ld_binbag_01' then
						z = z - 0.5
					end
					if model == 'prop_ld_health_pack' then
						z = z - 1.0
					end
					ESX.Game.SpawnObject(model, {
						x = x,
						y = y,
						z = z
					}, function(obj)
						SetEntityHeading(obj, GetEntityHeading(playerPed))
						PlaceObjectOnGroundProperly(obj)
					end)
				end,
				function(data2, menu2)
					menu2.close()
				end
			)
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

AddEventHandler('esx_ambulancejob:hasEnteredEntityZone', function(entity)
	local playerPed = GetPlayerPed(-1)
	if PlayerData.job ~= nil  and PlayerData.job.name == 'ambulance'  and (not IsPedInAnyVehicle(playerPed, false)) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('press_remove_obj')
		CurrentActionData = {entity = entity}
	end
end)

AddEventHandler('esx_ambulancejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work06a',
		'prop_wheelchair_01',
		'prop_ld_health_pack',
		'prop_ld_binbag_01'
	}
	while true do
		Citizen.Wait(10)
		local playerPed = GetPlayerPed(-1)
		local coords    = GetEntityCoords(playerPed)
		local closestDistance = -1
		local closestEntity = nil
		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0,  GetHashKey(trackedEntities[i]), false, false, false)
			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  objCoords.x,  objCoords.y,  objCoords.z,  true)
				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end
		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_ambulancejob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity ~= nil then
				TriggerEvent('esx_ambulancejob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

------------------------------------ID card------------------------------
function OpenIdentityCardMenu(player)
	if Config.EnableESXIdentity then
		ESX.TriggerServerCallback('esx_ambulancejob:getOtherPlayerData', function(data)

      local sexLabel    = nil
      local sex         = nil
      local dobLabel    = nil
      local heightLabel = nil
      local idLabel     = nil

      if data.sex ~= nil then
        if (data.sex == 'm') or (data.sex == 'M') then
          sex = 'Male'
        else
          sex = 'Female'
        end
        sexLabel = 'Sex : ' .. sex
      else
        sexLabel = 'Sex : Unknown'
      end

      if data.dob ~= nil then
        dobLabel = 'DOB : ' .. data.dob
      else
        dobLabel = 'DOB : Unknown'
      end

      if data.height ~= nil then
        heightLabel = 'Height : ' .. data.height
      else
        heightLabel = 'Height : Unknown'
      end

      if data.name ~= nil then
        idLabel = 'ID : ' .. data.name
      else
        idLabel = 'ID : Unknown'
      end

      local elements = {
        {label = _U('name') .. data.firstname .. " " .. data.lastname, value = nil},
        {label = sexLabel,    value = nil},
        {label = dobLabel,    value = nil},
        {label = heightLabel, value = nil},
        {label = idLabel,     value = nil},
      }

      if data.drunk ~= nil then
        table.insert(elements, {label = _U('bac') .. data.drunk .. '%', value = nil})
      end



      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {css='metier',
          title    = _U('citizen_interaction'),
          align    = 'left',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  else

    ESX.TriggerServerCallback('esx_ambulancejob:getOtherPlayerData', function(data)

        local elements = {
          {label = _U('name') .. data.name, value = nil},
        }

      if data.drunk ~= nil then
        table.insert(elements, {label = _U('bac') .. data.drunk .. '%', value = nil})
      end


      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {css='metier',
          title    = _U('citizen_interaction'),
          align    = 'left',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  end

end
----------------------------------------------------
function OpenFineMenu(player)

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'fine',
    {
      css='metier',
      title    = _U('fine'),
      align    = 'left',
      elements = {
        {label = 'Soins',   value = 0},
		{label = 'Déplacement',   value = 1},
		{label ='Réanimation',   value = 2},
		--{label = _U('ambulance_zone'),   value = 3},
		{label = 'Examens',   value = 3},
      },
    },
    function(data, menu)

      OpenFineCategoryMenu(player, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenFineCategoryMenu(player, category)

  ESX.TriggerServerCallback('esx_ambulancejob:getFineList', function(fines)

    local elements = {}

    for i=1, #fines, 1 do
      table.insert(elements, {
        label     = fines[i].label .. ' $' .. fines[i].amount,
        value     = fines[i].id,
        amount    = fines[i].amount,
        fineLabel = fines[i].label
      })
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'fine_category',
      {css='metier',
        title    = _U('fine'),
        align    = 'left',
        elements = elements,
      },
      function(data, menu)

        local label  = data.current.fineLabel
        local amount = data.current.amount

        menu.close()

        if Config.EnablePlayerManagement then
          TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_ambulance', _U('fine_total') .. label, amount)
        else
          TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', _U('fine_total') .. label, amount)
        end

        ESX.SetTimeout(300, function()
          OpenFineCategoryMenu(player, category)
        end)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, category)

end


RegisterNetEvent('esx_ambulancejob:handcuff')
AddEventHandler('esx_ambulancejob:handcuff', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if IsHandcuffed then

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			FreezeEntityPosition(playerPed, true)
			DisplayRadar(false)

			if Config.EnableHandcuffTimer then

				if HandcuffTimer.Active then
					ESX.ClearTimeout(HandcuffTimer.Task)
				end

				StartHandcuffTimer()
			end

		else

			if Config.EnableHandcuffTimer and HandcuffTimer.Active then
				ESX.ClearTimeout(HandcuffTimer.Task)
			end

			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
			DisplayRadar(true)
		end
	end)
end)

RegisterNetEvent('esx_ambulancejob:drag')
AddEventHandler('esx_ambulancejob:drag', function(emsID)
	if not IsHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.EmsId     = tonumber(emsID)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsDead or IsHandcuffed then
			DisableControlAction(2, 1, true) -- Disable pan
			DisableControlAction(2, 2, true) -- Disable tilt
			DisableControlAction(2, 24, true) -- Attack
			DisableControlAction(2, 257, true) -- Attack 2
			DisableControlAction(2, 25, true) -- Aim
			DisableControlAction(2, 263, true) -- Melee Attack 1
			DisableControlAction(2, Keys['R'], true) -- Reload
			DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
			DisableControlAction(2, Keys['SPACE'], true) -- Jump
			DisableControlAction(2, Keys['Q'], true) -- Cover
			DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(2, Keys['F'], true) -- Also 'enter'?
			DisableControlAction(2, Keys['F1'], true) -- Disable phone
			DisableControlAction(2, Keys['F2'], true) -- Inventory
			DisableControlAction(2, Keys['F3'], true) -- Animations
			DisableControlAction(2, Keys['F5'], true) -- Menu Perso
			DisableControlAction(2, Keys['F6'], true) -- Menu Métier
			DisableControlAction(2, Keys['F9'], true) -- Menu Orga
			DisableControlAction(2, Keys['F10'], true) -- Menu Tablette
			DisableControlAction(2, Keys['L'], true) -- Menu Coffre Véhicule
			DisableControlAction(2, Keys['E'], true) -- Touche E
			DisableControlAction(2, Keys['U'], true) -- Clé Voiture
			DisableControlAction(2, Keys['V'], true) -- Disable changing view
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen
			DisableControlAction(2, 59, true) -- Disable steering in vehicle
			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
			--DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.EmsId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then

			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatus.IsDragged = false
			end

		end

	end
end)

RegisterNetEvent('esx_ambulancejob:OutVehicle')
AddEventHandler('esx_ambulancejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'pharmacy',
	{css='inventaire',
		title		= _U('pharmacy_menu_title'),
		align		= 'top-left',
		elements = {
			{label = _U('pharmacy_take') .. ' ' .. _('medikit'), value = 'medikit'},
			{label = _U('pharmacy_take') .. ' ' .. _('bandage'), value = 'bandage'},
			{label = 'Prendre 1x des Anti-Douleur', value = 'pills'},
			{label = 'Prendre 1x tube de pommade', value = 'pommade'},
		},
	}, function(data, menu)
		TriggerServerEvent('esx_ambulancejob:giveItem', data.current.value)

	end, function(data, menu)
		menu.close()
		CurrentAction		= 'pharmacy'
		CurrentActionMsg	= _U('open_pharmacy')
		CurrentActionData	= {}
	end
	)
end

AddEventHandler('playerSpawned', function()
	IsDead = false

	if FirstSpawn then
		TriggerServerEvent('esx_ambulancejob:firstSpawn')
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		FirstSpawn = false
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)

	local specialContact = {
	name		= 'Ambulance',
	number		= 'ambulance',
	base64Icon	= 'data:image/png;base64,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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)

end)

AddEventHandler('esx:onPlayerDeath', function(reason)
	OnPlayerDeath()
end)

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()

	local playerPed = GetPlayerPed(-1)
	local coords	= GetEntityCoords(playerPed)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', 0)

	Citizen.CreateThread(function()

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(0)
	end

	ESX.SetPlayerData('lastPosition', {
		x = coords.x,
		y = coords.y,
		z = coords.z
	})

	TriggerServerEvent('esx:updateLastPosition', {
		x = coords.x,
		y = coords.y,
		z = coords.z
	})

	RespawnPed(playerPed, {
		x = coords.x,
		y = coords.y,
		z = coords.z
	})

	StopScreenEffect('DeathFailOut')

	DoScreenFadeIn(800)

	end)

end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(zone)

	if (zone == 'BossActions') and PlayerData.job.grade_name == 'boss' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	  end

	if zone == 'HospitalInteriorEntering1' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.HospitalInteriorInside1.Pos)
	end

	if zone == 'HospitalInteriorExit1' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.HospitalInteriorOutside1.Pos)
	end

	if zone == 'HospitalInteriorEntering2' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.HospitalInteriorInside2.Pos)
	end
	
	if zone == 'HelicopterSpawn' then
	local heli = Config.HelicopterSpawner

		if not IsAnyVehicleNearPoint(heli.SpawnPoint.x, heli.SpawnPoint.y, heli.SpawnPoint.z, 3.0) then
			ESX.Game.SpawnVehicle('polmav', {
				x = heli.SpawnPoint.x,
				y = heli.SpawnPoint.y,
				z = heli.SpawnPoint.z
			}, heli.Heading, function(vehicle)
				SetVehicleModKit(vehicle, 0)
				SetVehicleLivery(vehicle, 1)
			end)

		end
    end
	if zone == 'HospitalInteriorExit2' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.HospitalInteriorOutside2.Pos)
	end

	if zone == 'ParkingDoorGoOutInside' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.ParkingDoorGoOutOutside.Pos)
	end

	if zone == 'ParkingDoorGoInOutside' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.ParkingDoorGoInInside.Pos)
	end

	if zone == 'StairsGoTopBottom' then
		CurrentAction		= 'fast_travel_goto_top'
		CurrentActionMsg	= _U('fast_travel')
		CurrentActionData	= {pos = Config.Zones.StairsGoTopTop.Pos}
	end

	if zone == 'StairsGoBottomTop' then
		CurrentAction		= 'fast_travel_goto_bottom'
		CurrentActionMsg	= _U('fast_travel')
		CurrentActionData	= {pos = Config.Zones.StairsGoBottomBottom.Pos}
	end

	if zone == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	  end
	
	  if Config.EnableVaultManagement then
		  if zone == 'Vaults' then
			CurrentAction     = 'menu_vault'
			CurrentActionMsg  = _U('open_vault')
			CurrentActionData = {}
		  end
	  end

	if zone == 'VehicleSpawner' then
		CurrentAction		= 'vehicle_spawner_menu'
		CurrentActionMsg	= _U('veh_spawn')
		CurrentActionData	= {}
		
	end

	if zone == 'Pharmacy' then
		CurrentAction		= 'pharmacy'
		CurrentActionMsg	= _U('open_pharmacy')
		CurrentActionData	= {}
	end

	if zone == 'VehicleDeleter' or 'VehicleDeleter2' then

		local playerPed = GetPlayerPed(-1)
		local coords	= GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then

			local vehicle, distance = ESX.Game.GetClosestVehicle({
				x = coords.x,
				y = coords.y,
				z = coords.z
			})

			if distance ~= -1 and distance <= 1.0 then
				CurrentAction		= 'delete_vehicle'
				CurrentActionMsg	= _U('store_veh')
				CurrentActionData	= {vehicle = vehicle}

			end

		end

	end

end)

function FastTravel(pos)
		TeleportFadeEffect(GetPlayerPed(-1), pos)
end

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create blips
Citizen.CreateThread(function()

	local blip = AddBlipForCoord(Config.Blip.Pos.x, Config.Blip.Pos.y, Config.Blip.Pos.z)

	SetBlipSprite(blip, Config.Blip.Sprite)
	SetBlipDisplay(blip, Config.Blip.Display)
	SetBlipScale(blip, Config.Blip.Scale)
	SetBlipColour(blip, Config.Blip.Colour)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('hospital'))
	EndTextCommandSetBlipName(blip)

end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				elseif k ~=  'BossAction' and k ~= 'Vaults' and k ~= 'Cloakroom' and k ~= 'VehicleSpawner' and k ~= 'VehicleDeleter' and k ~= 'Pharmacy' and k ~= 'StairsGoTopBottom' and k ~= 'StairsGoBottomTop' then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		local coords		= GetEntityCoords(GetPlayerPed(-1))
		local isInMarker	= false
		local currentZone	= nil
		for k,v in pairs(Config.Zones) do
			if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.MarkerSize.x) then
					isInMarker	= true
					currentZone = k
				end
			elseif k ~= 'Cloakroom' and k ~= 'Vaults'and k ~= 'BossAction' and k ~= 'VehicleSpawner' and k ~= 'VehicleDeleter' and k ~= 'Pharmacy' and k ~= 'StairsGoTopBottom' and k ~= 'StairsGoBottomTop' then
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.MarkerSize.x) then
					isInMarker	= true
					currentZone = k
				end
			end
		end
		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_ambulancejob:hasExitedMarker', lastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then

				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				end
				  
				if (CurrentAction == 'menu_boss_actions') and PlayerData.job.grade_name == 'boss' then
		  
					ESX.UI.Menu.CloseAll()
		  
					TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
		  
					  menu.close()
					  CurrentAction     = 'menu_boss_actions'
					  CurrentActionMsg  = _U('open_bossmenu')
					  CurrentActionData = {}
		  
					end, {wash = false})
		  
				end
				  
				if CurrentAction == 'menu_vault' then
					OpenVaultMenu()
				end

				if CurrentAction == 'vehicle_spawner_menu' then
					OpenVehicleSpawnerMenu()
				end

				if CurrentAction == 'pharmacy' then
					OpenPharmacyMenu()
				end

				if CurrentAction == 'fast_travel_goto_top' or CurrentAction == 'fast_travel_goto_bottom' then
					FastTravel(CurrentActionData.pos)
				end

				if CurrentAction == 'delete_vehicle' then
					if Config.EnableSocietyOwnedVehicles then
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'ambulance', vehicleProps)
					end
					TriggerServerEvent('esx_vehiclelock:deletekey2', plate, 'no')
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end
                if CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end
				CurrentAction = nil

			end

		end

		if IsControlJustReleased(0, Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' and not IsDead then
			OpenMobileAmbulanceActionsMenu()
		end

	end
end)

RegisterNetEvent('esx_ambulancejob:requestDeath')
AddEventHandler('esx_ambulancejob:requestDeath', function()
	if Config.AntiCombatLog then
		Citizen.Wait(5000)
		SetEntityHealth(GetPlayerPed(-1), 0)
	end
end)

-- Load unloaded IPLs
--[[if Config.LoadIpl then
	Citizen.CreateThread(function()
		LoadMpDlcMaps()
		EnableMpDlcMaps(true)
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
]]--end

-- String string
function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

if IsControlPressed(0,  Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' and (GetGameTimer() - GUI.Time) > 150 then
	OpenMobileAmbulanceActionsMenu()
	GUI.Time = GetGameTimer()
end

---------------------------------------------------------------------------------------------------------
--NB : gestion des menu
---------------------------------------------------------------------------------------------------------

RegisterNetEvent('NB:openMenuAmbulance')
AddEventHandler('NB:openMenuAmbulance', function()
	OpenMobileAmbulanceActionsMenu()
end)

RegisterNetEvent('NB:openMenuAmublance')
AddEventHandler('NB:openMenuAmbulance', function()
    if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'citizen_interaction') then
        ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'citizen_interaction')
    end
end)