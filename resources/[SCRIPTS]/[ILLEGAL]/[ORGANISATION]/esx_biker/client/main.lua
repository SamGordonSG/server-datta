-------------------------------------------------
--Created and modified by Dominic Stanfford 
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

local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastPartNum               = nil
local LastEntity                = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local IsHandcuffed              = false
local IsDragged                 = false
local CopPed                    = 0
local done 						= false

ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function SetVehicleMaxMods(vehicle)

  local props = {
    modEngine       = 2,
    modBrakes       = 2,
    modTransmission = 2,
    modSuspension   = 3,
    modTurbo        = true,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(org, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[org].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[org].male)
		else
				ESX.ShowNotification(_U('no_outfit'))
			end

		else
			if Config.Uniforms[org].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[org].female)
		else
				ESX.ShowNotification(_U('no_outfit'))
			end

		end
	end)
end

function OpenCloakroomMenu()

	local playerPed = PlayerPedId()
	local org = PlayerData.org.gradeorg_name

	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' }
	}

	if org == 'soldato' then
		table.insert(elements, {label = _U('biker_wear'), value = 'recruit_wear'})
	elseif org == 'capo' then
		table.insert(elements, {label = _U('biker_wear'), value = 'sergeant_wear'})
	elseif org == 'consigliere' then
		table.insert(elements, {label = _U('biker_wear'), value = 'lieutenant_wear'})
	elseif org == 'boss' then
		table.insert(elements, {label = _U('biker_wear'), value = 'boss_wear'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			
			if Config.EnableNonFreemodePeds then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, orgSkin)
					local isMale = skin.sex == 0

					TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, orgSkin)
							TriggerEvent('skinchanger:loadSkin', skin)
							TriggerEvent('esx:restoreLoadout')
						end)
					end)

				end)
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, orgSkin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			if Config.MaxInService ~= -1 then

				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService then

						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'biker')

						TriggerServerEvent('esx_service:disableService', 'biker')
						ESX.ShowNotification(_U('service_out'))
					end
				end, 'biker')
			end

		end

		if Config.MaxInService ~= -1 and data.current.value ~= 'citizen_wear' then
			local serviceOk = 'waiting'

			ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				if not isInService then

					ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
						if not canTakeService then
							ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
						else

							serviceOk = true
							playerInService = true

							local notification = {
								title    = _U('service_anonunce'),
								subject  = '',
								msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
								iconType = 1
							}
	
							TriggerServerEvent('esx_service:notifyAllInService', notification, 'biker')
							ESX.ShowNotification(_U('service_in'))
						end
					end, 'biker')

				else
					serviceOk = true
				end
			end, 'biker')

			while type(serviceOk) == 'string' do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not serviceOk then
				return
			end
		end

		if
			data.current.value == 'recruit_wear' or
			data.current.value == 'sergeant_wear' or
			data.current.value == 'lieutenant_wear' or
			data.current.value == 'boss_wear'
		then
			setUniform(data.current.value, playerPed)
		end

		if data.current.value == 'freemode_ped' then
			local modelHash = ''

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, orgSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)

					TriggerEvent('esx:restoreLoadout')
				end)
			end)

		end



	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function OpenArmoryMenu(station)

	if Config.EnableArmoryManagement then
  
	  local elements = {
		--{label = _U('get_weapon'),     value = 'get_weapon'},
		--{label = _U('put_weapon'),     value = 'put_weapon'},
		{label = _U('remove_object'),  value = 'organisation_inventory'},
		{label = _U('deposit_object'), value = 'player_inventory'},
		{label = 'BOSS : Déposer Arme',  value = 'put_weapon2'},
		{label = 'BOSS : Déposer Objet',  value = 'put_stock2'}
	  }
  
	  if PlayerData.org.name == 'biker' and PlayerData.org.gradeorg_name == 'boss' then
		  table.insert(elements,
		  {label = 'BOSS : Prendre Arme', value = 'get_weapon2'})
		  end	
	  if PlayerData.org.name == 'biker' and PlayerData.org.gradeorg_name == 'boss' then
		  table.insert(elements,
		  {label = 'BOSS : Prendre Objet', value = 'get_stock2'})
		  end	
	  if PlayerData.org.gradeorg_name == 'boss' then
		table.insert(elements, {label = _U('buy_weapons'), value = 'buy_weapons'})
	  end
  
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'armory',
		{
		  title    = _U('armory'),
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
			OpenBuyWeaponsMenu(station)
		  end
  
		  if data.current.value == 'player_inventory' then
			OpenPlayerInventoryMenu()
		  end
  
		  if data.current.value == 'organisation_inventory' then
			OpenOrganisationInventoryMenu()
		  end
		  
		  if data.current.value == 'get_weapon2' then
			OpenGetWeaponMenu2()
		  end
  
		  if data.current.value == 'put_weapon2' then
			OpenPutWeaponMenu2()
		  end
		  
		  if data.current.value == 'get_stock2' then
			OpenOrganisationInventoryMenu2()
		  end
		  
		  if data.current.value == 'put_stock2' then
			OpenPlayerInventoryMenu2()
		  end
		  
		  
		  
  
		end,
		function(data, menu)
  
		  menu.close()
  
		  CurrentAction     = 'menu_armory'
		  CurrentActionMsg  = _U('open_armory')
		  CurrentActionData = {station = station}
		end
	  )
  
	else
  
	  local elements = {}
  
	  for i=1, #Config.BikerStations[station].AuthorizedWeapons, 1 do
		local weapon = Config.BikerStationss[station].AuthorizedWeapons[i]
		table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})
	  end
  
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'armory',
		{
		  title    = _U('armory'),
		  align    = 'left',
		  elements = elements,
		},
		function(data, menu)
		  local weapon = data.current.value
		  TriggerServerEvent('esx_biker:giveWeapon', weapon,  1000)
		end,
		function(data, menu)
  
		  menu.close()
  
		  CurrentAction     = 'menu_armory'
		  CurrentActionMsg  = _U('open_armory')
		  CurrentActionData = {station = station}
  
		end
	  )
  
	end
  
  end

function OpenVehicleSpawnerMenu(station, partNum)

	local vehicles = Config.BikerStations[station].Vehicles
	ESX.UI.Menu.CloseAll()

	if Config.EnableOrganisationOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_organisation:getVehiclesInGarage', function(garageVehicles)

			for i=1, #garageVehicles, 1 do
				table.insert(elements, {label = GetDisplayNameFromVehicleModel(garageVehicles[i].model) .. ' [' .. garageVehicles[i].plate .. ']', value = garageVehicles[i]})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title    = _U('vehicle_menu'),
				align    = 'top-left',
				elements = elements
			}, function(data, menu)
				menu.close()

				local vehicleProps = data.current.value

				ESX.Game.SpawnVehicle(vehicleProps.model, vehicles[partNum].SpawnPoint, vehicles[partNum].Heading, function(vehicle)
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				end)

				TriggerServerEvent('esx_organisation:removeVehicleFromGarage', 'biker', vehicleProps)
			end, function(data, menu)
				menu.close()

				CurrentAction     = 'menu_vehicle_spawner'
				CurrentActionMsg  = _U('vehicle_spawner')
				CurrentActionData = {station = station, partNum = partNum}
			end)

		end, 'biker')

	else

		local elements = {}

		local sharedVehicles = Config.AuthorizedVehicles.Shared
		for i=1, #sharedVehicles, 1 do
			table.insert(elements, { label = sharedVehicles[i].label, model = sharedVehicles[i].model})
		end

		local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.org.gradeorg_name]
		for i=1, #authorizedVehicles, 1 do
			table.insert(elements, { label = authorizedVehicles[i].label, model = authorizedVehicles[i].model})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		{
			title    = _U('vehicle_menu'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			local model   = data.current.model
			local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x, vehicles[partNum].SpawnPoint.y, vehicles[partNum].SpawnPoint.z, 3.0, 0, 71)

			if not DoesEntityExist(vehicle) then

				local playerPed = PlayerPedId()

				if Config.MaxInService == -1 then

					ESX.Game.SpawnVehicle(model, vehicles[partNum].SpawnPoint, vehicles[partNum].Heading, function(vehicle)
						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						SetVehicleMaxMods(vehicle)
					end)
				else

					ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
						if isInService then

							ESX.Game.SpawnVehicle(model, vehicles[partNum].SpawnPoint, vehicles[partNum].Heading, function(vehicle)
								TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
								SetVehicleMaxMods(vehicle)
							end)
						else
							ESX.ShowNotification(_U('service_not'))
						end
					end, 'biker')
				end

			else
				ESX.ShowNotification(_U('vehicle_out'))
			end

		end, function(data, menu)
			menu.close()

			CurrentAction     = 'menu_vehicle_spawner'
			CurrentActionMsg  = _U('vehicle_spawner')
			CurrentActionData = {station = station, partNum = partNum}
		end)

	end
end

function OpenBikerActionsMenu()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'biker_actions',
    {
      title    = _U('biker'),
      align    = 'top-left',
      elements = {
        {label = _U('citizen_interaction'), value = 'citizen_interaction'},
        {label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
      },
    },
    function(data, menu)

      if data.current.value == 'citizen_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = _U('citizen_interaction'),
            align    = 'top-left',
            elements = {
              {label = _U('id_card'),       value = 'identity_card'},
              {label = _U('search'),        value = 'body_search'},
              --{label = _U('handcuff'),    value = 'handcuff'},
              --{label = _U('drag'),      value = 'drag'},
              {label = _U('put_in_vehicle'),  value = 'put_in_vehicle'},
              {label = _U('out_the_vehicle'), value = 'out_the_vehicle'}
            },
          },
          function(data2, menu2)

            local player, distance = ESX.Game.GetClosestPlayer()

            if distance ~= -1 and distance <= 3.0 then

              if data2.current.value == 'identity_card' then
                OpenIdentityCardMenu(player)
              end

              if data2.current.value == 'body_search' then
                OpenBodySearchMenu(player)
              end

              if data2.current.value == 'handcuff' then
                TriggerServerEvent('esx_biker:handcuff', GetPlayerServerId(player))
              end

              if data2.current.value == 'drag' then
                TriggerServerEvent('esx_biker:drag', GetPlayerServerId(player))
              end

              if data2.current.value == 'put_in_vehicle' then
                TriggerServerEvent('esx_biker:putInVehicle', GetPlayerServerId(player))
              end

              if data2.current.value == 'out_the_vehicle' then
                  TriggerServerEvent('esx_biker:OutVehicle', GetPlayerServerId(player))
              end

            else
              ESX.ShowNotification(_U('no_players_nearby'))
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'vehicle_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'vehicle_interaction',
          {
            title    = _U('vehicle_interaction'),
            align    = 'top-left',
            elements = {
              {label = _U('vehicle_info'), value = 'vehicle_infos'},
              --{label = _U('pick_lock'),    value = 'hijack_vehicle'},
            },
          },
          function(data2, menu2)

            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

            if DoesEntityExist(vehicle) then

              local vehicleData = ESX.Game.GetVehicleProperties(vehicle)

              if data2.current.value == 'vehicle_infos' then
                OpenVehicleInfosMenu(vehicleData)
              end

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

    end,
    function(data, menu)

      menu.close()

    end
  )

end

function OpenIdentityCardMenu(player)

	ESX.TriggerServerCallback('esx_biker:getOtherPlayerData', function(data)

		local elements    = {}
		local nameLabel   = _U('name', data.name)
		local jobLabel    = nil
		local sexLabel    = nil
		local dobLabel    = nil
		local heightLabel = nil
		local idLabel     = nil
	
		if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
			jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
		else
			jobLabel = _U('job', data.job.label)
		end
	
		if Config.EnableESXIdentity then
	
			nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)
			
		if data.sex ~= nil then
			if string.lower(data.sex) == 'h' or string.lower(data.sex) == 'H' or string.lower(data.sex) == 'm' or string.lower(data.sex) == 'M' then
				sexLabel = _U('sex', _U('male'))
			elseif string.lower(data.sex) == 'f' or string.lower(data.sex) == 'F' then
				sexLabel = _U('sex', _U('female'))
			else
				sexLabel = _U('sex', _U('unknown'))
			end

		else
				sexLabel = _U('sex', _U('unknown'))
			end
			
		if data.sex ~= nil then
				if string.lower(data.sex) == 'm' then
					sexLabel = _U('sex', _U('male'))
				else
					sexLabel = _U('sex', _U('female'))
				end
			else
				sexLabel = _U('sex', _U('unknown'))
			end
	
			if data.dob ~= nil then
				dobLabel = _U('dob', data.dob)
			else
				dobLabel = _U('dob', _U('unknown'))
			end
	
			if data.height ~= nil then
				heightLabel = _U('height', data.height)
			else
				heightLabel = _U('height', _U('unknown'))
			end
	
			if data.name ~= nil then
				idLabel = _U('id', data.name)
			else
				idLabel = _U('id', _U('unknown'))
			end
	
		end
	
		local elements = {
			{label = nameLabel, value = nil},
			{label = jobLabel,  value = nil},
		}
	
		if Config.EnableESXIdentity then
			table.insert(elements, {label = sexLabel, value = nil})
			table.insert(elements, {label = dobLabel, value = nil})
			table.insert(elements, {label = heightLabel, value = nil})
			table.insert(elements, {label = idLabel, value = nil})
		end
	
		if data.drunk ~= nil then
			table.insert(elements, {label = _U('bac', data.drunk), value = nil})
		end
	
		if data.licenses ~= nil then
	
			table.insert(elements, {label = _U('license_label'), value = nil})
	
			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label, value = nil})
			end
	
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
		{
			title    = _U('citizen_interaction'),
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	
	end, GetPlayerServerId(player))

end

function OpenBodySearchMenu(player)

  ESX.TriggerServerCallback('esx_biker:getOtherPlayerData', function(data)

    local elements = {}

    local blackMoney = 0

    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == 'black_money' then
        blackMoney = data.accounts[i].money
      end
    end

    table.insert(elements, {
      label          = _U('dirty') .. blackMoney,
      value          = 'black_money',
      itemType       = 'item_account',
      amount         = blackMoney
    })

    table.insert(elements, {label = _U('guns_label'), value = nil})

    for i=1, #data.weapons, 1 do
		table.insert(elements, {
			label    = _U('weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
			value    = data.weapons[i].name,
			itemType = 'item_weapon',
			amount   = data.weapons[i].ammo
		})
	end

    table.insert(elements, {label = _U('inventory_label'), value = nil})

    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(elements, {
          label          = _U('inv') .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
          value          = data.inventory[i].name,
          itemType       = 'item_standard',
          amount         = data.inventory[i].count,
        })
      end
    end


    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'body_search',
      {
        title    = _U('search'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        local itemType = data.current.itemType
        local itemName = data.current.value
        local amount   = data.current.amount

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, GetPlayerServerId(player))

end

function OpenVehicleInfosMenu(vehicleData)

  ESX.TriggerServerCallback('esx_biker:getVehicleInfos', function(infos)

    local elements = {}

    table.insert(elements, {label = _U('plate') .. infos.plate, value = nil})

    if infos.owner == nil then
      table.insert(elements, {label = _U('owner_unknown'), value = nil})
    else
      table.insert(elements, {label = _U('owner') .. infos.owner, value = nil})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_infos',
      {
        title    = _U('vehicle_info'),
        align    = 'top-left',
        elements = elements,
      },
      nil,
      function(data, menu)
        menu.close()
      end
    )

  end, vehicleData.plate)

end

function OpenGetWeaponMenu()

  ESX.TriggerServerCallback('esx_biker:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {
        title    = _U('get_weapon_menu'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('esx_biker:removeArmoryWeapon', function()
          OpenGetWeaponMenu()
        end, data.current.value)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenGetWeaponMenu2()

	ESX.TriggerServerCallback('esx_biker:getArmoryWeapons2', function(weapons)
  
	  local elements = {}
  
	  for i=1, #weapons, 1 do
		if weapons[i].count > 0 then
		  table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
		end
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'armory_get_weapon',
		{
		  title    = _U('get_weapon_menu'),
		  align    = 'left',
		  elements = elements
		},
		function(data, menu)
  
		  menu.close()
  
		  ESX.TriggerServerCallback('esx_biker:removeArmoryWeapon2', function()
			OpenGetWeaponMenu2()
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
    'default', GetCurrentResourceName(), 'armory_put_weapon',
    {
      title    = _U('put_weapon_menu'),
      align    = 'top-left',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('esx_biker:addArmoryWeapon', function()
        OpenPutWeaponMenu()
      end, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenPutWeaponMenu2()

	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()
  
	for i=1, #weaponList, 1 do
  
	  local weaponHash = GetHashKey(weaponList[i].name)
  
	  if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
		table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
	  end
  
	end
  
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'armory_put_weapon',
	  {
		title    = _U('put_weapon_menu'),
		align    = 'left',
		elements = elements
	  },
	  function(data, menu)
  
		menu.close()
  
		ESX.TriggerServerCallback('esx_biker:addArmoryWeapon2', function()
		  OpenPutWeaponMenu2()
		end, data.current.value, true)
  
	  end,
	  function(data, menu)
		menu.close()
	  end
	)
  
  end

function OpenBuyWeaponsMenu(station)

  ESX.TriggerServerCallback('esx_biker:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #Config.BikerStations[station].AuthorizedWeapons, 1 do

      local weapon = Config.BikerStations[station].AuthorizedWeapons[i]
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
      'default', GetCurrentResourceName(), 'armory_buy_weapons',
      {
        title    = _U('buy_weapon_menu'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        ESX.TriggerServerCallback('esx_biker:buy', function(hasEnoughMoney)

          if hasEnoughMoney then
            ESX.TriggerServerCallback('esx_biker:addArmoryWeapon2', function()
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

function OpenOrganisationInventoryMenu()

	ESX.TriggerServerCallback('esx_biker:getOrganisationInventory', function(inventory)
  
	  local elements = {}
  
	 -- table.insert(elements, {label = _U('dirty_money') .. inventory.blackMoney, type = 'item_account', value = 'black_money'})
  
	  for i=1, #inventory.items, 1 do
  
		local item = inventory.items[i]
  
		if item.count > 0 then
		  table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
		end
  
	  end
  
	  for i=1, #inventory.weapons, 1 do
		local weapon = inventory.weapons[i]
		table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name) .. ' [' .. weapon.ammo .. ']', type = 'item_weapon', value = weapon.name, ammo = weapon.ammo})
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'organisation_inventory',
		{
		  title    = _U('inventory'),
		  align    = 'left',
		  elements = elements,
		},
		function(data, menu)
  
		  if data.current.type == 'item_weapon' then
  
			menu.close()
  
			TriggerServerEvent('esx_biker:getItem',  data.current.type, data.current.value, data.current.ammo)
  
			ESX.SetTimeout(300, function()
			  OpenOrganisationInventoryMenu()
			end)
  
		  else
  
			ESX.UI.Menu.Open(
			  'dialog', GetCurrentResourceName(), 'get_item_count',
			  {
				title = _U('amount'),
			  },
			  function(data2, menu)
  
				local quantity = tonumber(data2.value)
  
				if quantity == nil then
				  ESX.ShowNotification(_U('amount_invalid'))
				else
  
				  menu.close()
  
				  TriggerServerEvent('esx_biker:getItem', data.current.type, data.current.value, quantity)
  
				  ESX.SetTimeout(300, function()
					OpenOrganisationInventoryMenu()
				  end)
  
				end
  
			  end,
			  function(data2,menu)
				menu.close()
			  end
			)
  
		  end
  
		end,
		function(data, menu)
		  menu.close()
		end
	  )
  
	end)
	
  
  end
  -----------------------------------------
  function OpenOrganisationInventoryMenu2()
  
	ESX.TriggerServerCallback('esx_biker:getOrganisationInventory2', function(inventory)
  
	  local elements = {}
  
	  table.insert(elements, {label = _U('dirty_money') .. inventory.blackMoney, type = 'item_account', value = 'black_money'})
  
	  for i=1, #inventory.items, 1 do
  
		local item = inventory.items[i]
  
		if item.count > 0 then
		  table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
		end
  
	  end
  
	  for i=1, #inventory.weapons, 1 do
		local weapon = inventory.weapons[i]
		table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name) .. ' [' .. weapon.ammo .. ']', type = 'item_weapon', value = weapon.name, ammo = weapon.ammo})
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'organisation_inventory',
		{
		  title    = _U('inventory'),
		  align    = 'left',
		  elements = elements,
		},
		function(data, menu)
  
		  if data.current.type == 'item_weapon' then
  
			menu.close()
  
			TriggerServerEvent('esx_biker:getItem2',  data.current.type, data.current.value, data.current.ammo)
  
			ESX.SetTimeout(300, function()
			  OpenOrganisationInventoryMenu2()
			end)
  
		  else
  
			ESX.UI.Menu.Open(
			  'dialog', GetCurrentResourceName(), 'get_item_count',
			  {
				title = _U('amount'),
			  },
			  function(data2, menu)
  
				local quantity = tonumber(data2.value)
  
				if quantity == nil then
				  ESX.ShowNotification(_U('amount_invalid'))
				else
  
				  menu.close()
  
				  TriggerServerEvent('esx_biker:getItem2', data.current.type, data.current.value, quantity)
  
				  ESX.SetTimeout(300, function()
					OpenOrganisationInventoryMenu2()
				  end)
  
				end
  
			  end,
			  function(data2,menu)
				menu.close()
			  end
			)
  
		  end
  
		end,
		function(data, menu)
		  menu.close()
		end
	  )
  
	end)
	
  
  end
  -----------------------------------------
  
  function OpenPlayerInventoryMenu()
  
	ESX.TriggerServerCallback('esx_biker:getPlayerInventory', function(inventory)
  
	  local elements = {}
  
	  table.insert(elements, {label = _U('dirty_money') .. inventory.blackMoney, type = 'item_account', value = 'black_money'})
  
	  for i=1, #inventory.items, 1 do
  
		local item = inventory.items[i]
  
		if item.count > 0 then
		  table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
		end
  
	  end
  
	  local playerPed  = GetPlayerPed(-1)
	  local weaponList = ESX.GetWeaponList()
  
	  for i=1, #weaponList, 1 do
  
		local weaponHash = GetHashKey(weaponList[i].name)
  
		if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
		  local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
		  table.insert(elements, {label = weaponList[i].label .. ' [' .. ammo .. ']', type = 'item_weapon', value = weaponList[i].name, ammo = ammo})
		end
  
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'player_inventory',
		{
		  title    = _U('inventory'),
		  align    = 'left',
		  elements = elements,
		},
		function(data, menu)
  
		  if data.current.type == 'item_weapon' then
  
			menu.close()
  
			TriggerServerEvent('esx_biker:putItem',  data.current.type, data.current.value, data.current.ammo)
  
			ESX.SetTimeout(300, function()
			  OpenPlayerInventoryMenu()
			end)
  
		  else
  
			ESX.UI.Menu.Open(
			  'dialog', GetCurrentResourceName(), 'put_item_count',
			  {
				title = _U('amount'),
			  },
			  function(data2, menu)
  
				menu.close()
  
				TriggerServerEvent('esx_biker:putItem', data.current.type, data.current.value, tonumber(data2.value))
  
				ESX.SetTimeout(300, function()
				  OpenPlayerInventoryMenu()
				end)
  
			  end,
			  function(data2,menu)
				menu.close()
			  end
			)
  
		  end
  
		end,
		function(data, menu)
		  menu.close()
		end
	  )
  
	end)
  
  end
  
  function OpenPlayerInventoryMenu2()
  
	ESX.TriggerServerCallback('esx_biker:getPlayerInventory', function(inventory)
  
	  local elements = {}
  
	  table.insert(elements, {label = _U('dirty_money') .. inventory.blackMoney, type = 'item_account', value = 'black_money'})
  
	  for i=1, #inventory.items, 1 do
  
		local item = inventory.items[i]
  
		if item.count > 0 then
		  table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
		end
  
	  end
  
	  local playerPed  = GetPlayerPed(-1)
	  local weaponList = ESX.GetWeaponList()
  
	  for i=1, #weaponList, 1 do
  
		local weaponHash = GetHashKey(weaponList[i].name)
  
		if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
		  local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
		  table.insert(elements, {label = weaponList[i].label .. ' [' .. ammo .. ']', type = 'item_weapon', value = weaponList[i].name, ammo = ammo})
		end
  
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'player_inventory',
		{
		  title    = _U('inventory'),
		  align    = 'left',
		  elements = elements,
		},
		function(data, menu)
  
		  if data.current.type == 'item_weapon' then
  
			menu.close()
  
			TriggerServerEvent('esx_biker:putItem2',  data.current.type, data.current.value, data.current.ammo)
  
			ESX.SetTimeout(300, function()
			  OpenPlayerInventoryMenu2()
			end)
  
		  else
  
			ESX.UI.Menu.Open(
			  'dialog', GetCurrentResourceName(), 'put_item_count',
			  {
				title = _U('amount'),
			  },
			  function(data2, menu)
  
				menu.close()
  
				TriggerServerEvent('esx_biker:putItem2', data.current.type, data.current.value, tonumber(data2.value))
  
				ESX.SetTimeout(300, function()
				  OpenPlayerInventoryMenu2()
				end)
  
			  end,
			  function(data2,menu)
				menu.close()
			  end
			)
  
		  end
  
		end,
		function(data, menu)
		  menu.close()
		end
	  )
  
	end)
  
  end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setOrg')
AddEventHandler('esx:setOrg', function(org)
  PlayerData.org = org
end)

AddEventHandler('esx_biker:hasEnteredMarker', function(station, part, partNum)

  if part == 'Cloakroom' then
    CurrentAction     = 'menu_cloakroom'
    CurrentActionMsg  = _U('open_cloackroom')
    CurrentActionData = {}
  end

  if part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = _U('open_armory')
    CurrentActionData = {station = station}
  end

  if part == 'VehicleSpawner' then
    CurrentAction     = 'menu_vehicle_spawner'
    CurrentActionMsg  = _U('vehicle_spawner')
    CurrentActionData = {station = station, partNum = partNum}
  end

  if part == 'VehicleDeleter' then

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed, false)

      if DoesEntityExist(vehicle) then
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = {vehicle = vehicle}
      end

    end

  end

  if part == 'BossActions' then
    CurrentAction     = 'menu_boss_actions'
    CurrentActionMsg  = _U('open_bossmenu')
    CurrentActionData = {}
  end

end)

AddEventHandler('esx_biker:hasExitedMarker', function(station, part, partNum)
  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)

RegisterNetEvent('esx_biker:handcuff')
AddEventHandler('esx_biker:handcuff', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsHandcuffed then

      RequestAnimDict('mp_arresting')

      while not HasAnimDictLoaded('mp_arresting') do
        Wait(100)
      end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)

    else

      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)

    end

  end)
end)

RegisterNetEvent('esx_biker:drag')
AddEventHandler('esx_biker:drag', function(cop)
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

RegisterNetEvent('esx_biker:putInVehicle')
AddEventHandler('esx_biker:putInVehicle', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end

    end

  end

end)

RegisterNetEvent('esx_biker:OutVehicle')
AddEventHandler('esx_biker:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2

  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if IsHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, Keys['W'], true) -- W
			DisableControlAction(0, Keys['A'], true) -- A
			DisableControlAction(0, Keys['X'], true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			DisableControlAction(0, Keys['F5'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job
			DisableControlAction(0, Keys['F9'], true) -- Org

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Display markers
Citizen.CreateThread(function()
  while true do

    Wait(0)

    if PlayerData.org ~= nil and PlayerData.org.name == 'biker' then

      local playerPed = GetPlayerPed(-1)
      local coords    = GetEntityCoords(playerPed)

      for k,v in pairs(Config.BikerStations) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.Vehicles, 1 do
          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        if Config.EnablePlayerManagement and PlayerData.org ~= nil and PlayerData.org.name == 'biker' and PlayerData.org.gradeorg_name == 'boss' then

          for i=1, #v.BossActions, 1 do
            if not v.BossActions[i].disabled and GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.DrawDistance then
              DrawMarker(Config.MarkerType, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
          end

        end

      end

    end

  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

  while true do

    Wait(0)

    if PlayerData.org ~= nil and PlayerData.org.name == 'biker' then

      local playerPed      = GetPlayerPed(-1)
      local coords         = GetEntityCoords(playerPed)
      local isInMarker     = false
      local currentStation = nil
      local currentPart    = nil
      local currentPartNum = nil

      for k,v in pairs(Config.BikerStations) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Cloakroom'
            currentPartNum = i
          end
        end

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Armory'
            currentPartNum = i
          end
        end

        for i=1, #v.Vehicles, 1 do

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].SpawnPoint.x,  v.Vehicles[i].SpawnPoint.y,  v.Vehicles[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawnPoint'
            currentPartNum = i
          end

        end

        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleDeleter'
            currentPartNum = i
          end
        end

        if Config.EnablePlayerManagement and PlayerData.org ~= nil and PlayerData.org.name == 'biker' and PlayerData.org.gradeorg_name == 'boss' then

          for i=1, #v.BossActions, 1 do
            if GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.MarkerSize.x then
              isInMarker     = true
              currentStation = k
              currentPart    = 'BossActions'
              currentPartNum = i
            end
          end

        end

      end

      local hasExited = false

      if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then

        if
          (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
          (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
        then
          TriggerEvent('esx_biker:hasExitedMarker', LastStation, LastPart, LastPartNum)
          hasExited = true
        end

        HasAlreadyEnteredMarker = true
        LastStation             = currentStation
        LastPart                = currentPart
        LastPartNum             = currentPartNum

        TriggerEvent('esx_biker:hasEnteredMarker', currentStation, currentPart, currentPartNum)
      end

      if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

        HasAlreadyEnteredMarker = false

        TriggerEvent('esx_biker:hasExitedMarker', LastStation, LastPart, LastPartNum)
      end

    end

  end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0,  Keys['E']) and PlayerData.org ~= nil and PlayerData.org.name == 'biker' and (GetGameTimer() - GUI.Time) > 150 then

        if CurrentAction == 'menu_cloakroom' then
          OpenCloakroomMenu()
        end

        if CurrentAction == 'menu_armory' then
          OpenArmoryMenu(CurrentActionData.station)
        end

        if CurrentAction == 'menu_vehicle_spawner' then
          OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
        end

        if CurrentAction == 'delete_vehicle' then

					if Config.EnableOrganisationOwnedVehicles then
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_organisation:putVehicleInGarage', 'biker', vehicleProps)
					end
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					end

        if CurrentAction == 'menu_boss_actions' then

          ESX.UI.Menu.CloseAll()

          TriggerEvent('esx_organisation:openBossMenu', 'biker', function(data, menu)

            menu.close()

            CurrentAction     = 'menu_boss_actions'
            CurrentActionMsg  = _U('open_bossmenu')
            CurrentActionData = {}

          end)

        end

        if CurrentAction == 'remove_entity' then
          DeleteEntity(CurrentActionData.entity)
        end

        CurrentAction = nil
        GUI.Time      = GetGameTimer()

      end

    end

   if IsControlPressed(0,  Keys['F9']) and PlayerData.org ~= nil and PlayerData.org.name == 'biker' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'biker_actions') and (GetGameTimer() - GUI.Time) > 150 then
     OpenBikerActionsMenu()
     GUI.Time = GetGameTimer()
    end

  end
end)
