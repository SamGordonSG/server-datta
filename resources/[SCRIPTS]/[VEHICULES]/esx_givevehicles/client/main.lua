-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------


ESX               = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("esx_givevehicles:car")
AddEventHandler("esx_givevehicles:car", function()

CarCoche()

end)

function CarCoche()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
	end
	
	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	

	ESX.TriggerServerCallback('esx_givevehicles:requestPlayerCars', function(isOwnedVehicle)

		if isOwnedVehicle then
		
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

          if closestPlayer == -1 or closestDistance > 3.0 then
		  	ESX.ShowNotification('Aucun citoyen à proximité !')
          else
			ESX.ShowNotification('Vous avez donné les papiers de votre voiture immatriculée ~g~'..vehicleProps.plate..' ~w~!')
			TriggerServerEvent('esx_givevehicles:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
			TriggerServerEvent('esx_givevehicles:setVehicleOwnedPlayerIdClee', GetPlayerServerId(closestPlayer), vehicleProps)
          end
		else
	       ESX.ShowNotification('Aucun véhicule à proximité ou le vehicule vous appartient pas')
		end
	end, GetVehicleNumberPlateText(vehicle))
end

RegisterNetEvent("esx_givevehicles:boat")
AddEventHandler("esx_givevehicles:boat", function()

BoatCoche()

end)

function BoatCoche()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
	end
	
	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	

	ESX.TriggerServerCallback('esx_givevehicles:requestPlayerCarsboat', function(isOwnedVehicle)

		if isOwnedVehicle then
		
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

          if closestPlayer == -1 or closestDistance > 3.0 then
		  	ESX.ShowNotification('Aucun citoyen à proximité !')
          else
			ESX.ShowNotification('Vous avez donné les papiers de votre bateau immatriculé ~g~'..vehicleProps.plate..' ~w~!')
			TriggerServerEvent('esx_givevehicles:setVehicleOwnedPlayerIdboat', GetPlayerServerId(closestPlayer), vehicleProps)
			TriggerServerEvent('esx_givevehicles:setVehicleOwnedPlayerIdClee', GetPlayerServerId(closestPlayer), vehicleProps)
          end
		else
	       ESX.ShowNotification('Aucun véhicule à proximité ou le bateau vous appartient pas')
		end
	end, GetVehicleNumberPlateText(vehicle))
end


RegisterNetEvent("esx_givevehicles:air")
AddEventHandler("esx_givevehicles:air", function()

AirCoche()

end)

function AirCoche()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
	end
	
	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	

	ESX.TriggerServerCallback('esx_givevehicles:requestPlayerCarsair', function(isOwnedVehicle)

		if isOwnedVehicle then
		
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

          if closestPlayer == -1 or closestDistance > 3.0 then
		  	ESX.ShowNotification('Aucun citoyen à proximité !')
          else
			ESX.ShowNotification('Vous avez donné les papiers de votre avion/hélico immatriculé ~g~'..vehicleProps.plate..' ~w~!')
			TriggerServerEvent('esx_givevehicles:setVehicleOwnedPlayerIdair', GetPlayerServerId(closestPlayer), vehicleProps)
			TriggerServerEvent('esx_givevehicles:setVehicleOwnedPlayerIdClee', GetPlayerServerId(closestPlayer), vehicleProps)
          end
		else
	       ESX.ShowNotification('Aucun véhicule à proximité ou l\' avion/hélico vous appartient pas')
		end
	end, GetVehicleNumberPlateText(vehicle))
end