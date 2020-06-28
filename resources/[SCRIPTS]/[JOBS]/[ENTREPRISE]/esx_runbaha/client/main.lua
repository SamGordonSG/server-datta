-----------------------------------------
-- Created and modify by L'ile Légale RP
-- SenSi and Kaminosekai
-----------------------------------------
local PlayerData, GUI, CurrentActionData, JobBlips = {}, {}, {}, {}
local HasAlreadyEnteredMarker, publicBlip = false, false
local LastZone, CurrentAction, CurrentActionMsg
ESX = nil
GUI.Time = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

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


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	blips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlips()
	blips()
end)

AddEventHandler('esx_runbaha:hasEnteredMarker', function(zone)
	if zone == 'CitronFarm' and PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas'  then
		CurrentAction     = 'citron_harvest'
		CurrentActionMsg  = _U('press_collect')
		CurrentActionData = {zone= zone}
	end
	if zone == 'CachacaFarm' and PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas'  then
		CurrentAction     = 'cachaca_harvest'
		CurrentActionMsg  = _U('press_collect')
		CurrentActionData = {zone= zone}
	end
	if zone == 'CassonadeFarm' and PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas'  then
		CurrentAction     = 'cassonade_harvest'
		CurrentActionMsg  = _U('press_collect')
		CurrentActionData = {zone= zone}
	end
		
	if zone == 'TraitementCaipirinha' and PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas'  then
		CurrentAction     = 'caipirinha_traitement'
		CurrentActionMsg  = _U('press_traitement')
		CurrentActionData = {zone= zone}
	end		
		
	if zone == 'SellFarm' and PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas'  then
		CurrentAction     = 'farm_resell'
		CurrentActionMsg  = _U('press_sell')
		CurrentActionData = {zone = zone}
	end

end)

AddEventHandler('esx_runbaha:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	if (zone == 'CitronFarm') and PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas' then
		TriggerServerEvent('esx_runbaha:stopHarvest')
	end  
	if (zone == 'CassonadeFarm') and PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas' then
		TriggerServerEvent('esx_runbaha:stopHarvest')
	end  
	if (zone == 'CachacaFarm') and PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas' then
		TriggerServerEvent('esx_runbaha:stopHarvest')
	end  
	if (zone == 'TraitementCaipirinha') and PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas' then
		TriggerServerEvent('esx_runbaha:stopTransform')
	end
	if (zone == 'SellFarm') and PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas' then
		TriggerServerEvent('esx_runbaha:stopSell')
	end
	CurrentAction = nil
end)

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
		RemoveBlip(JobBlips[i])
		JobBlips[i] = nil
		end
	end
end

-- Create Blips
function blips()
    if PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas' then

		for k,v in pairs(Config.Zones)do
			if v.Type == 1 then
				local blip2 = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)

				SetBlipSprite (blip2, 93)
				SetBlipDisplay(blip2, 4)
				SetBlipScale  (blip2, 1.0)
				SetBlipColour (blip2, 48)
				SetBlipAsShortRange(blip2, true)

				BeginTextCommandSetBlipName('STRING')
				AddTextComponentString(v.Name)
				EndTextCommandSetBlipName(blip2)
				table.insert(JobBlips, blip2)
			end
		end
	end
end

-- Display markers
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			if PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas' then
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Wait(0)

		if PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas' then

			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_runbaha:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_runbaha:hasExitedMarker', LastZone)
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

			if IsControlPressed(0,  38) and PlayerData.job ~= nil and PlayerData.job.name == 'bahama_mamas' and (GetGameTimer() - GUI.Time) > 300 then
				if CurrentAction == 'citron_harvest' then
					TriggerServerEvent('esx_runbaha:startHarvest', CurrentActionData.zone)
				end
				if CurrentAction == 'cassonade_harvest' then
					TriggerServerEvent('esx_runbaha:startHarvest', CurrentActionData.zone)
				end
				if CurrentAction == 'cachaca_harvest' then
					TriggerServerEvent('esx_runbaha:startHarvest', CurrentActionData.zone)
				end
				if CurrentAction == 'caipirinha_traitement' then
					TriggerServerEvent('esx_runbaha:startTransform', CurrentActionData.zone)
				end
				if CurrentAction == 'farm_resell' then
					TriggerServerEvent('esx_runbaha:startSell', CurrentActionData.zone)
				end
				
				CurrentAction = nil
				GUI.Time      = GetGameTimer()
			end
		end
	end
end)