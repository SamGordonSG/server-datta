ESX = nil
local GUI, CurrentActionData, blipillegal = {}, {}, {}
local HasAlreadyEnteredMarker = false
local LastZone, CurrentAction, CurrentActionMsg
GUI.Time = 0
local times, randomnumber, count = 0, 0, 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()


end)

RegisterNetEvent("esx_infoillegal:notify")
AddEventHandler("esx_infoillegal:notify", function(icon, type, sender, title, text)
    Citizen.CreateThread(function()
		Wait(1)
		SetNotificationTextEntry("STRING");
		AddTextComponentString(text);
		SetNotificationMessage(icon, icon, true, type, sender, title, text);
		DrawNotification(false, true);
    end)
end)

function OpenInfoIllegalMenu()
  local elements = { }
	  table.insert(elements, {label = _U('crack') .. Config.PriceCrackF .. _U('crack1'),    value = 'crack'})
	  table.insert(elements, {label = _U('tcrack') .. Config.PriceCrackT .. _U('tcrack1'),    value = 'tcrack'})
	  table.insert(elements, {label = _U('rcrack') .. Config.PriceCrackR .. _U('rcrack1'),    value = 'rcrack'})
	  table.insert(elements, {label = _U('opium') .. Config.PriceOpiumF .. _U('opium1'),    value = 'opium'})
	  table.insert(elements, {label = _U('topium') .. Config.PriceOpiumT .. _U('topium1'),    value = 'topium'})
	  table.insert(elements, {label = _U('ropium') .. Config.PriceOpiumR .. _U('ropium1'),    value = 'ropium'})
	  table.insert(elements, {label = _U('coke') .. Config.PriceCokeF .. _U('coke1'),    value = 'coke'})
	  table.insert(elements, {label = _U('tcoke') .. Config.PriceCokeT .. _U('tcoke1'),    value = 'tcoke'})
	  table.insert(elements, {label = _U('rcoke') .. Config.PriceCokeR .. _U('rcoke1'),    value = 'rcoke'})
	  table.insert(elements, {label = _U('ecstasy') .. Config.PriceEcstasyF .. _U('ecstasy1'),    value = 'ecstasy'})
	  table.insert(elements, {label = _U('tecstasy') .. Config.PriceEcstasyT .. _U('tecstasy1'),    value = 'tecstasy'})
	  table.insert(elements, {label = _U('recstasy') .. Config.PriceEcstasyR .. _U('recstasy1'),    value = 'recstasy'})

  ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'info', {
        title    = _U('info'),
        align    = 'top-left',
        elements = elements,
        }, function(data, menu)

        if data.current.value == 'crack' then
           TriggerServerEvent("esx_infoillegal:Crack")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'tcrack' then
           TriggerServerEvent("esx_infoillegal:TCrack")
		   ESX.UI.Menu.CloseAll()
        end
		if data.current.value == 'rcrack' then
           TriggerServerEvent("esx_infoillegal:RCrack")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'opium' then
           TriggerServerEvent("esx_infoillegal:Opium")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'topium' then
           TriggerServerEvent("esx_infoillegal:TOpium")
		   ESX.UI.Menu.CloseAll()
        end
		if data.current.value == 'ropium' then
           TriggerServerEvent("esx_infoillegal:ROpium")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'coke' then
           TriggerServerEvent("esx_infoillegal:Coke")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'tcoke' then
           TriggerServerEvent("esx_infoillegal:TCoke")
		   ESX.UI.Menu.CloseAll()
        end
		if data.current.value == 'rcoke' then
           TriggerServerEvent("esx_infoillegal:RCoke")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'ecstasy' then
           TriggerServerEvent("esx_infoillegal:Ecstasy")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'tecstasy' then
           TriggerServerEvent("esx_infoillegal:TEcstasy")
		   ESX.UI.Menu.CloseAll()
        end
		if data.current.value == 'recstasy' then
           TriggerServerEvent("esx_infoillegal:REcstasy")
		   ESX.UI.Menu.CloseAll()
        end

      CurrentAction     = 'menu_info_illegal'
      CurrentActionData = {}
    end, function(data, menu)

      menu.close()

      CurrentAction     = 'menu_info_illegal'
      CurrentActionData = {}
    end)
end

RegisterNetEvent("esx_infoillegal:CrackFarm")
AddEventHandler("esx_infoillegal:CrackFarm", function()
	if Config.GPS then
		x, y, z = Config.CrackFarm.x, Config.CrackFarm.y, Config.CrackFarm.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('GPS'))
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RecCrack'))
	end
end)

RegisterNetEvent("esx_infoillegal:CrackTreatment")
AddEventHandler("esx_infoillegal:CrackTreatment", function()
	if Config.GPS then
		x, y, z = Config.CrackTreatment.x, Config.CrackTreatment.y, Config.CrackTreatment.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('GPS'))
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiCrack1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiCrack'))
	end
end)

RegisterNetEvent("esx_infoillegal:CrackResell")
AddEventHandler("esx_infoillegal:CrackResell", function()
	if Config.GPS then
		x, y, z = Config.CrackResell.x, Config.CrackResell.y, Config.CrackResell.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('GPS'))
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevCrack1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevCrack'))
	end
end)

RegisterNetEvent("esx_infoillegal:OpiumFarm")
AddEventHandler("esx_infoillegal:OpiumFarm", function()
	if Config.GPS then
		x, y, z = Config.OpiumFarm.x, Config.OpiumFarm.y, Config.OpiumFarm.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('GPS'))
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RecOpium'))
	end
end)

RegisterNetEvent("esx_infoillegal:OpiumTreatment")
AddEventHandler("esx_infoillegal:OpiumTreatment", function()
	if Config.GPS then
		x, y, z = Config.OpiumTreatment.x, Config.OpiumTreatment.y, Config.OpiumTreatment.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('GPS'))
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiOpium1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiOpium'))
	end
end)

RegisterNetEvent("esx_infoillegal:OpiumResell")
AddEventHandler("esx_infoillegal:OpiumResell", function()
	if Config.GPS then
		x, y, z = Config.OpiumResell.x, Config.OpiumResell.y, Config.OpiumResell.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('GPS'))
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevOpium1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevOpium'))
	end
end)

RegisterNetEvent("esx_infoillegal:CokeFarm")
AddEventHandler("esx_infoillegal:CokeFarm", function()
	if Config.GPS then
		x, y, z = Config.CokeFarm.x, Config.CokeFarm.y, Config.CokeFarm.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('GPS'))
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RecCoke'))
	end
end)

RegisterNetEvent("esx_infoillegal:CokeTreatment")
AddEventHandler("esx_infoillegal:CokeTreatment", function()
	if Config.GPS then
		x, y, z = Config.CokeTreatment.x, Config.CokeTreatment.y, Config.CokeTreatment.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('GPS'))
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiCoke1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiCoke'))
	end
end)

RegisterNetEvent("esx_infoillegal:CokeResell")
AddEventHandler("esx_infoillegal:CokeResell", function()
	if Config.GPS then
		x, y, z = Config.CokeResell.x, Config.CokeResell.y, Config.CokeResell.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('GPS'))
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevCoke1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevCoke'))
	end
end)

RegisterNetEvent("esx_infoillegal:EcstasyFarm")
AddEventHandler("esx_infoillegal:EcstasyFarm", function()
	if Config.GPS then
		x, y, z = Config.EcstasyFarm.x, Config.EcstasyFarm.y, Config.EcstasyFarm.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('GPS'))
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RecEcstasy'))
	end
end)

RegisterNetEvent("esx_infoillegal:EcstasyTreatment")
AddEventHandler("esx_infoillegal:EcstasyTreatment", function()
	if Config.GPS then
		x, y, z = Config.EcstasyTreatment.x, Config.EcstasyTreatment.y, Config.EcstasyTreatment.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('GPS'))
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiEcstasy1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiEcstasy'))
	end
end)

RegisterNetEvent("esx_infoillegal:EcstasyResell")
AddEventHandler("esx_infoillegal:EcstasyResell", function()
	if Config.GPS then
		x, y, z = Config.EcstasyResell.x, Config.EcstasyResell.y, Config.EcstasyResell.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('GPS'))
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevEcstasy1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevEcstasy'))
	end
end)

AddEventHandler('esx_infoillegal:hasEnteredMarker', function(zone)
	CurrentAction     = 'menu_info_illegal'
	CurrentActionMsg  = _U('press_menu')
	CurrentActionData = {zone = zone}
end)

AddEventHandler('esx_infoillegal:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		heure = tonumber(GetClockHours())
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		
		

		if Config.Hours then
			
			if heure > Config.openHours and heure < Config.closeHours then	
				if Config.Blip then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
						Config.Blip = false
					
					elseif times == 0 then
						count = 0
							for k,v in pairs(Config.Zones) do
								count = count + 1
							end
						randomnumber = math.random(1,count)
							for k,v in pairs(Config.Zones)do
								if k == randomnumber then
									blipillegal[k] = AddBlipForCoord(v.x, v.y, v.z)
									SetBlipSprite (blipillegal[k], 133)
									SetBlipDisplay(blipillegal[k], 4)
									SetBlipScale  (blipillegal[k], 1.0)
									SetBlipColour (blipillegal[k], 5)
									SetBlipAsShortRange(blipillegal[k], true)

									BeginTextCommandSetBlipName('STRING')
									AddTextComponentString(_U('illegalblip'))
									EndTextCommandSetBlipName(blipillegal[k])
								end
							end
							times = 1
						end
					end
			else
				if times == 1 then
					for k, v in pairs(Config.Zones) do
						RemoveBlip(blipillegal[k])
					
					end
					times = 0
				end
			end
		else
			if times == 0 then
				for k,v in pairs(Config.Zones)do
					blipillegal[k] = AddBlipForCoord(v.x, v.y, v.z)
					SetBlipSprite (blipillegal[k], 133)
					SetBlipDisplay(blipillegal[k], 4)
					SetBlipScale  (blipillegal[k], 1.0)
					SetBlipColour (blipillegal[k], 5)
					SetBlipAsShortRange(blipillegal[k], true)

					BeginTextCommandSetBlipName('STRING')
					AddTextComponentString(_U('illegalblip'))
					EndTextCommandSetBlipName(blipillegal[k])
				end
				times = 1
			end
		end

		-- Enter / Exit marker events
			for k,v in pairs(Config.Zones) do
				if k == randomnumber then
					if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.MarkerSize.x / 2) then
						isInMarker  = true
						currentZone = k
					end
				end
			end

		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_infoillegal:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_infoillegal:hasExitedMarker', LastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if CurrentAction ~= nil then
		heure	= tonumber(GetClockHours())
		if heure > Config.openHours and heure < Config.closeHours then
		  SetTextComponentFormat('STRING')
		  AddTextComponentString(CurrentActionMsg)
		  DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, 38) and (GetGameTimer() - GUI.Time) > 1000 then
				heure		= tonumber(GetClockHours())
				GUI.Time 	= GetGameTimer()
				
				if CurrentAction == 'menu_info_illegal' then
					if Config.Hours then
						if heure > Config.openHours and heure < Config.closeHours then	
							OpenInfoIllegalMenu()
						else
							TriggerServerEvent('esx_infoillegal:Nothere')
						end
					else
						OpenInfoIllegalMenu()
					end
				end
				CurrentAction = nil
			end
		end
    end
  end
end)
