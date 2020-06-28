--================================================================================================--
--==                                VARIABLES - DO NOT EDIT                                     ==--
--================================================================================================--
ESX                         = nil
inMenu                      = true
local atbank = false
local bankMenu = true

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end
--===============================================
--==           Base ESX Threading              ==
--===============================================
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
--===============================================
--==             Core Threading                ==
--===============================================


-- Le menu est ouvert en appuyant sur la touche "E" tandis que vous êtes dans la banque.
if bankMenu then
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			if nearBank() or nearATM() then
				DisplayHelpText("Appuyez sur ~INPUT_PICKUP~ pour accèder à vos comptes ~b~")
				if IsControlJustPressed(1, 38) then
					inMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({type = 'openGeneral'})
					TriggerServerEvent('bank:balance')
					local ped = GetPlayerPed(-1)
				end
			end
			if IsControlJustPressed(1, 322) then
				inMenu = false
					SetNuiFocus(false, false)
					SendNUIMessage({type = 'close'})
				end
		end
	end)
end



-- Lorsque vous êtes à la banque et à proximité du guichet automatique, le menu s'ouvre en tapant "/bank".
--[[RegisterCommand('bank', function()
	if bankMenu then
		if nearBank() or nearATM() then
			Citizen.Wait(5)
				openUI()
				TriggerServerEvent('bank:balance')
				local ped = GetPlayerPed(-1)
			end
		end
		if IsControlJustPressed(1, 194) then
			closeUI()			
		end		
]]--end)

--===============================================
--==             Map Blips	                   ==
--===============================================
function CreateBank(coords)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, 108)
	SetBlipScale(blip, 0.9)
	SetBlipColour(blip, 2)
	SetBlipDisplay(blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("BANQUE")
	EndTextCommandSetBlipName(blip)

	return blip
end

function CreateATM(coords)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, 108)
	SetBlipScale(blip, 0.9)
	SetBlipColour(blip, 2)
	SetBlipDisplay(blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("ATM")
	EndTextCommandSetBlipName(blip)

	return blip
end
--===============================================
--==            Blip Functions	                   ==
--===============================================
if Config.ShowNearestBanks then
	Citizen.CreateThread(function()
		local currentBankBlip = 0

		while true do
			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords

			for _, bankCoords in pairs(Config.Bank) do
				local dstcheck = GetDistanceBetweenCoords(coords, bankCoords)

				if dstcheck < closest then
					closest = dstcheck
					closestCoords = bankCoords
				end
			end

			if DoesBlipExist(currentBankBlip) then
				RemoveBlip(currentBankBlip)
			end

			currentBankBlip = CreateBank(closestCoords)

			Citizen.Wait(10000)
		end
	end)
elseif Config.ShowAllBanks then
	Citizen.CreateThread(function()
		for _, bankCoords in pairs(Config.Bank) do
			CreateBank(bankCoords)
		end
	end)
end

if Config.ShowNearestATMs then
	Citizen.CreateThread(function()
		local currentAtmBlip = 0

		while true do
			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords

			for _, atmCoords in pairs(Config.ATM) do
				local dstcheck = GetDistanceBetweenCoords(coords, atmCoords)

				if dstcheck < closest then
					closest = dstcheck
					closestCoords = atmCoords
				end
			end

			if DoesBlipExist(currentAtmBlip) then
				RemoveBlip(currentAtmBlip)
			end

			currentAtmBlip = CreateATM(closestCoords)

			Citizen.Wait(10000)
		end
	end)
elseif Config.ShowAllATMs then
	Citizen.CreateThread(function()
		for _, atmCoords in pairs(Config.ATM) do
			CreateATM(bankCoords)
		end
	end)
end
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance)
	local id = PlayerId()
	local playerName =  GetPlayerName(id)

	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
		})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('bank:deposit', tonumber(data.amount))
	TriggerServerEvent('bank:balance')
end)
--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('bank:withdraw', tonumber(data.amountw))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==          Quick Events                 ==
--==============================================

RegisterNUICallback('quickCash', function()
	TriggerServerEvent('bank:fastw')
	TriggerServerEvent('bank:balance')
end)

RegisterNUICallback('cash', function()
	TriggerServerEvent('bank:fastwt')
	TriggerServerEvent('bank:balance')
end)

RegisterNUICallback('depfast', function()
	TriggerServerEvent('bank:fastdep')
	TriggerServerEvent('bank:balance')
end)


--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)
--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:transfer', data.to, data.amountt)
	TriggerServerEvent('bank:balance')
end)
--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)
--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	closeUI()
end)

AddEventHandler('onResourceStop', function (resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	closeUI()
end)

AddEventHandler('onResourceStart', function (resourceName)
	if(GetCurrentResourceName() ~= resourceName) then
		return
	end
	closeUI()
end)
--===============================================
--==            Capture Bank Distance          ==
--===============================================
function nearBank()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Bank) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		

		if distance <= 3 then
			return true
		end
	end
end

function nearATM()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.ATM) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 2 then
			return true
		end
	end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--===============================================
--==            Animations          ==
--===============================================
function closeUI()
	inMenu = false
	SetNuiFocus(false, false)
	if Config.Animation then 
		playAnim('amb@prop_human_atm@male@exit', 'exit', Config.AnimationTime)
		Citizen.Wait(Config.AnimationTime)
	end
	SendNUIMessage({type = 'closeAll'})
end

function openUI()
	if Config.Animation then 
		playAnim('amb@prop_human_atm@male@enter', 'enter', Config.AnimationTime)
		Citizen.Wait(Config.AnimationTime)
	end
	inMenu = true
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openGeneral'})
end
