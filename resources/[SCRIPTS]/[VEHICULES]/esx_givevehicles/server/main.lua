-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------


ESX               = nil
local cars 		  = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_givevehicles:requestPlayerCars', function(source, cb, plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM owned_vehicles WHERE owner = @identifier', 
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local found = false

			for i=1, #result, 1 do

				local vehicleProps = json.decode(result[i].vehicle)

				if vehicleProps.plate == plate then
					found = true
					break
				end

			end

			if found then
				cb(true)
			else
				cb(false)
			end

		end
	)
end)

RegisterServerEvent('esx_givevehicles:setVehicleOwnedPlayerId')
AddEventHandler('esx_givevehicles:setVehicleOwnedPlayerId', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE owned_vehicles SET owner=@owner WHERE plate=@plate',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate
	},
	
	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, 'Vous avez reçu les papiers d\'un nouveau véhicule immatriculé ~g~' ..vehicleProps.plate..'~w~ !', vehicleProps.plate)

	end) 
end)

ESX.RegisterServerCallback('esx_givevehicles:requestPlayerCarsboat', function(source, cb, plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM owned_boats WHERE owner = @identifier', 
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local found = false

			for i=1, #result, 1 do

				local vehicleProps = json.decode(result[i].vehicle)

				if vehicleProps.plate == plate then
					found = true
					break
				end

			end

			if found then
				cb(true)
			else
				cb(false)
			end

		end
	)
end)

RegisterServerEvent('esx_givevehicles:setVehicleOwnedPlayerIdboat')
AddEventHandler('esx_givevehicles:setVehicleOwnedPlayerIdboat', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE owned_boats SET owner=@owner WHERE plate=@plate',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate
	},
	
	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, 'Vous avez reçu les papiers d\'un nouveau bateau immatriculé ~g~' ..vehicleProps.plate..'~w~ !', vehicleProps.plate)

	end) 
end)

ESX.RegisterServerCallback('esx_givevehicles:requestPlayerCarsair', function(source, cb, plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM owned_aircrafts WHERE owner = @identifier', 
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local found = false

			for i=1, #result, 1 do

				local vehicleProps = json.decode(result[i].vehicle)

				if vehicleProps.plate == plate then
					found = true
					break
				end

			end

			if found then
				cb(true)
			else
				cb(false)
			end

		end
	)
end)

RegisterServerEvent('esx_givevehicles:setVehicleOwnedPlayerIdair')
AddEventHandler('esx_givevehicles:setVehicleOwnedPlayerIdair', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE owned_aircrafts SET owner=@owner WHERE plate=@plate',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate
	},
	
	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, 'Vous avez reçu les papiers d\'un nouvel avion/hélico immatriculé ~g~' ..vehicleProps.plate..'~w~ !', vehicleProps.plate)

	end) 
end)



















------------------------------------------------------------------------

RegisterServerEvent('esx_givevehicles:setVehicleOwnedPlayerIdClee')
AddEventHandler('esx_givevehicles:setVehicleOwnedPlayerIdClee', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE open_car SET identifier=@identifier WHERE value=@value',
	{
		['@identifier']   = xPlayer.identifier,
		['@value']   = vehicleProps.plate
	},
	
	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, 'Vous avez reçu les clés de votre nouvelle voiture immatriculée ~g~' ..vehicleProps.plate..'~w~ !', vehicleProps.plate)

	end) 
end)