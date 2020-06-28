ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


if Config.StoreOnServerStart then
	AddEventHandler('onMySQLReady', function()

		MySQL.Async.execute("UPDATE owned_vehicles SET `stored`=true WHERE `stored`=false", {})

	end)

	print('esx_vehiclescompany: stored vehicle')
end