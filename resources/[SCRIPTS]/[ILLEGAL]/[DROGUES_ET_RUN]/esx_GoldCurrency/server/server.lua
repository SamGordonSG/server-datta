--------------------------------
------- Created by Hamza -------
-------------------------------- 

local ESX = nil

local SmelteryTimer = {}
local ExchangeTimer = {}
local GoldJobTimer = {}

local NPC = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	while true do
		NPC = math.random(1,#Config.MissionNPC)
		TriggerClientEvent("esx_goldCurrency:spawnNPC",-1,Config.MissionNPC[NPC])
		Citizen.Wait(7200000*2)
	end
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	TriggerClientEvent("esx_goldCurrency:spawnNPC",playerId,Config.MissionNPC[NPC])
end)

-- server side for cooldown timer
RegisterServerEvent("esx_goldCurrency:MeltingCooldown")
AddEventHandler("esx_goldCurrency:MeltingCooldown",function(source)
	table.insert(SmelteryTimer,{MeltingTimer = GetPlayerIdentifier(source), time = ((Config.SmelteryTime * 1000))})
end)

-- server side for cooldown timer
RegisterServerEvent("esx_goldCurrency:ExhangeCooldown")
AddEventHandler("esx_goldCurrency:ExhangeCooldown",function(source)
	table.insert(ExchangeTimer,{ExchangeTimer = GetPlayerIdentifier(source), timeExchange = ((Config.ExchangeCooldown * 60000))})
end)

-- server side for cooldown timer
RegisterServerEvent("esx_goldCurrency:GoldJobCooldown")
AddEventHandler("esx_goldCurrency:GoldJobCooldown",function(source)
	table.insert(GoldJobTimer,{GoldJobTimer = GetPlayerIdentifier(source), timeGoldJob = (2 * 60000)}) -- cooldown timer for doing missions
end)

-- thread for syncing the cooldown timer
Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for k,v in pairs(SmelteryTimer) do
			if v.time <= 0 then
				RemoveSmelteryTimer(v.MeltingTimer)
			else
				v.time = v.time - 1000
			end
		end
		for k,v in pairs(ExchangeTimer) do
			if v.timeExchange <= 0 then
				RemoveExchangeTimer(v.ExchangeTimer)
			else
				v.timeExchange = v.timeExchange - 1000
			end
		end
		for k,v in pairs(GoldJobTimer) do
			if v.timeGoldJob <= 0 then
				RemoveGoldJobTimer(v.GoldJobTimer)
			else
				v.timeGoldJob = v.timeGoldJob - 1000
			end
		end
	end
end)

-- server side function to get cooldown timer
ESX.RegisterServerCallback("esx_goldCurrency:getGoldJobCoolDown",function(source,cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if not CheckGoldJobTimer(GetPlayerIdentifier(source)) then
		cb(false)
	else
		TriggerClientEvent("esx:showNotification",source,string.format("Un autre ~y~job~s~ sera ~g~disponible~s~ pour vous dans: ~b~%s~s~ minutes",GetGoldJobTimer(GetPlayerIdentifier(source))))
		cb(true)
	end
end)

-- server side function to get payment
RegisterServerEvent('esx_goldCurrency:missionAccepted')
AddEventHandler('esx_goldCurrency:missionAccepted', function()
	TriggerClientEvent("esx_goldCurrency:startMission",source,0)
end)

ESX.RegisterServerCallback("esx_goldCurrency:getPayment",function(source,cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local Players = ESX.GetPlayers()
	local blackMoney = 0
	blackMoney = xPlayer.getAccount('black_money').money
	local moneyCash = 0
	moneyCash = xPlayer.getMoney()
	if Config.UseBlackMoneyAsMissionCost == true then
		if blackMoney <= Config.MissionCost then
			TriggerClientEvent('esx:showNotification', source, "Vous n avez ~b~pas assez~s~ ~r~d argent sale~s~ pour payer ~r~les frais~s~ pour un ~y~job~s~")
			cb(false)
		else
			xPlayer.removeAccountMoney('black_money', Config.MissionCost)
			TriggerEvent("esx_goldCurrency:GoldJobCooldown",source)
			cb(true)
		end
	else
		if moneyCash <= Config.MissionCost then
			TriggerClientEvent('esx:showNotification', source, "Vous n avez ~b~pas assez~s~ ~g~d argent~s~ pour payer ~r~les frais~s~ pour un ~y~job~s~")
			cb(false)
		else
			xPlayer.removeMoney(Config.MissionCost)
			TriggerEvent("esx_goldCurrency:GoldJobCooldown",source)
			cb(true)
		end
	end
end)

-- server side function to accept the mission
ESX.RegisterServerCallback("esx_goldCurrency:getMissionavailability",function(source,cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local Players = ESX.GetPlayers()
	local policeOnline = 0
	for i = 1, #Players do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if xPlayer["job"]["name"] == Config.PoliceDatabaseName then
			policeOnline = policeOnline + 1
		end
	end
	if policeOnline >= Config.RequiredPoliceOnline then
		cb(true)
	else
		cb(false)
		TriggerClientEvent('esx:showNotification', source, "Il n y a ~r~pas~s~ assez de ~b~policier~s~ en ~y~ville~s~")
	end
end)

-- mission reward
RegisterServerEvent('esx_goldCurrency:reward')
AddEventHandler('esx_goldCurrency:reward', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local SecondItem = false
	
	-- item 1
	local itemAmount1 = ((math.random(Config.ItemMinAmount1,Config.ItemMaxAmount1)) * 100)
	local item1 = ESX.GetItemLabel(Config.ItemName1)
	
	-- item 2
	local itemAmount2 = math.random(Config.ItemMinAmount2,Config.ItemMaxAmount2)
	local item2 = ESX.GetItemLabel(Config.ItemName2)
	
	local chance = math.random(1,Config.RandomChance)
	if chance == 1 then
		SecondItem = true	
	end
	
	if Config.EnableSecondItemReward == true and SecondItem == true then
		xPlayer.addInventoryItem(Config.ItemName1,itemAmount1)
		xPlayer.addInventoryItem(Config.ItemName2,itemAmount2)
		if Config.EnableCustomNotification == true then
			TriggerClientEvent("esx_goldCurrency:missionComplete", source,itemAmount1,item1,itemAmount2,item2)
		else
			TriggerClientEvent('esx:showNotification', source, "~g~Mission Complete:~s~ Vous avez reçu ~b~"..itemAmount1.."x~s~ ~y~"..item1.."~s~ et "..itemAmount2.."x~s~ ~y~"..item2.."~s~")
		end
	else
		xPlayer.addInventoryItem(Config.ItemName1,itemAmount1)
		if Config.EnableCustomNotification == true then
			TriggerClientEvent("esx_goldCurrency:missionComplete", source,itemAmount1,item1)
		else
			TriggerClientEvent('esx:showNotification', source, "~g~Mission Complete:~s~ Vous avez reçu ~b~"..itemAmount1.."x~s~ ~y~"..item1.."~s~")
		end
	end
	
end)

RegisterServerEvent('esx_goldCurrency:GoldJobInProgress')
AddEventHandler('esx_goldCurrency:GoldJobInProgress', function(targetCoords, streetName)
	TriggerClientEvent('esx_goldCurrency:outlawNotify', -1,string.format("^3 Coup de feu entendu ^0 a ^5%s^0  et vol de voiture en cours",streetName))
	TriggerClientEvent('esx_goldCurrency:GoldJobInProgress', -1, targetCoords)
end)

-- sync mission data
RegisterServerEvent("esx_goldCurrency:syncMissionData")
AddEventHandler("esx_goldCurrency:syncMissionData",function(data)
	TriggerClientEvent("esx_goldCurrency:syncMissionData",-1,data)
end)

-- server side function for converting part
RegisterServerEvent('esx_goldCurrency:goldMelting')
AddEventHandler('esx_goldCurrency:goldMelting', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.getInventoryItem("goldwatch").count >= 100 then
		if xPlayer.getInventoryItem("goldbar").count <= 99 then
			if not CheckIfMelting(GetPlayerIdentifier(source)) then
				TriggerEvent("esx_goldCurrency:MeltingCooldown",source)
						
				xPlayer.removeInventoryItem("goldwatch",100)
			
				TriggerClientEvent("GoldWatchToGoldBar",source)
				Citizen.Wait((Config.SmelteryTime * 1000))
			
				xPlayer.addInventoryItem("goldbar",1)
			else
				TriggerClientEvent("esx:showNotification",source,string.format("Vous êtes ~b~déjà occupé~s~ à ~y~quelque chose~s~!",GetTimeForMelting(GetPlayerIdentifier(source))))
			end
		else
			TriggerClientEvent("esx:showNotification",source,"Vous ~r~n avez pas~s~ assez ~b~de place~s~  pour plus de ~y~lingot d or~s~")
		end
	else
		TriggerClientEvent("esx:showNotification",source,"Vous avez besoin ~r~d au moins~s~ 100x ~y~Montre en or~s~")
	end
end)

-- server side function for exchange part
RegisterServerEvent('esx_goldCurrency:goldExchange')
AddEventHandler('esx_goldCurrency:goldExchange', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	
	if not CheckIfExchanging(GetPlayerIdentifier(source)) then
		if xPlayer.getInventoryItem("goldbar").count >= 70 then
			TriggerEvent("esx_goldCurrency:ExhangeCooldown",source)
						
			xPlayer.removeInventoryItem("goldbar",70)
			
			TriggerClientEvent("GoldBarToCash",source)
			Citizen.Wait((Config.ExchangeTime * 1000))
			
			xPlayer.addMoney(17500)
		else
			TriggerClientEvent("esx:showNotification",source,"Vous avez besoin ~r~de minimum~s~ 70x ~y~Lingot d or~s~")
		end
	else
		TriggerClientEvent("esx:showNotification",source,string.format("Vous pouvez ~y~échanger de l'or~s~ a nouveau dans: ~b~%s minutes~s~",GetTimeForExchange(GetPlayerIdentifier(source))))
	end
end)

-- ## DO NOT TOUCH BELOW THIS!! ## --

-- Functions for Smeltery Timer
function RemoveSmelteryTimer(source)
	for k,v in pairs(SmelteryTimer) do
		if v.MeltingTimer == source then
			table.remove(SmelteryTimer,k)
		end
	end
end
function GetTimeForMelting(source)
	for k,v in pairs(SmelteryTimer) do
		if v.MeltingTimer == source then
			return math.ceil(v.time/1000)
		end
	end
end
function CheckIfMelting(source)
	for k,v in pairs(SmelteryTimer) do
		if v.MeltingTimer == source then
			return true
		end
	end
	return false
end
-- Functions for Exchange Timer:
function RemoveExchangeTimer(source)
	for k,v in pairs(ExchangeTimer) do
		if v.ExchangeTimer == source then
			table.remove(ExchangeTimer,k)
		end
	end
end
function GetTimeForExchange(source)
	for k,v in pairs(ExchangeTimer) do
		if v.ExchangeTimer == source then
			return math.ceil(v.timeExchange/60000)
		end
	end
end
function CheckIfExchanging(source)
	for k,v in pairs(ExchangeTimer) do
		if v.ExchangeTimer == source then
			return true
		end
	end
	return false
end
-- Functions for Mission Timer:
function RemoveGoldJobTimer(source)
	for k,v in pairs(GoldJobTimer) do
		if v.GoldJobTimer == source then
			table.remove(GoldJobTimer,k)
		end
	end
end
function GetGoldJobTimer(source)
	for k,v in pairs(GoldJobTimer) do
		if v.GoldJobTimer == source then
			return math.ceil(v.timeGoldJob/60000)
		end
	end
end
function CheckGoldJobTimer(source)
	for k,v in pairs(GoldJobTimer) do
		if v.GoldJobTimer == source then
			return true
		end
	end
	return false
end


