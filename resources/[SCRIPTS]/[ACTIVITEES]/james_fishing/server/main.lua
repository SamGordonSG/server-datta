ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local cachedData = {}

ESX.RegisterUsableItem(Config.FishingItems["rod"]["name"], function(source)
	TriggerClientEvent("james_fishing:tryToFish", source)
end)

ESX.RegisterServerCallback("james_fishing:receiveFish", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end

	player.removeInventoryItem(Config.FishingItems["bait"]["name"], 1)
	player.addInventoryItem(Config.FishingItems["fish"]["name"], 1)
	
	callback(true)
end)

ESX.RegisterServerCallback("james_fishing:sellFish", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end

	local fishItem = Config.FishingItems["fish"]

	local fishCount = player.getInventoryItem(fishItem["name"])["count"]
	local fishPrice = fishItem["price"]

	if fishCount > 0 then
		player.addMoney(fishCount * fishPrice)
		player.removeInventoryItem(fishItem["name"], fishCount)

		callback(fishCount * fishPrice, fishCount)
	else
		callback(false)
	end
end)