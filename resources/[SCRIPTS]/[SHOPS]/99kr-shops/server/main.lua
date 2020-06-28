--[[ Gets the ESX library ]]--
ESX = nil 
TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

RegisterNetEvent('99kr-shops:Caissier')
AddEventHandler('99kr-shops:Caissier', function(price, basket, account)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if account == "cash" then
        xPlayer.removeMoney(price)
    else
        xPlayer.removeAccountMoney(account, price)
    end
    
    for i=1, #basket do
        xPlayer.addInventoryItem(basket[i]["value"], basket[i]["amount"])
    end
    
    pNotify('Vous avez acheté des produits pour <span style="color: green">$' .. price .. '</span>', 'success', 3000)

end)

ESX.RegisterServerCallback('99kr-shops:CheckMoney', function(source, cb, price, account)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local money
    if account == "cash" then
        money = xPlayer.getMoney()
    else
        money = xPlayer.getAccount(account)["money"]
    end

    if money >= price then
        cb(true)
    end
    cb(false)
end)

pNotify = function(message, messageType, messageTimeout)
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = message,
		type = messageType,
		queue = "shop_sv",
		timeout = messageTimeout,
		layout = "topRight"
	})
end

local win1 = 60  -- lottery ticket
local win2 = 120 
local win3 = 240

-- locales --
local winText = "Vous avez gagné ~g~$"
local ticketEmpty = "Vous n avez rien ~r~gagné"
-------------

ESX.RegisterUsableItem('lotteryticket', function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local rndm = math.random(1,11)
	xPlayer.removeInventoryItem('lotteryticket', 1)

	if rndm == 1 then              -- WIN 1
		xPlayer.addMoney(win1)
		TriggerClientEvent('99kr-burglary:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
		TriggerClientEvent('esx:showNotification', src, winText .. win1)
	end

	if rndm == 2 then              -- WIN 2
		xPlayer.addMoney(win2)
		TriggerClientEvent('99kr-burglary:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
		TriggerClientEvent('esx:showNotification', src, winText .. win2)
	end

	if rndm == 3 then              -- WIN 3
		xPlayer.addMoney(win3)
		TriggerClientEvent('99kr-burglary:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
		TriggerClientEvent('esx:showNotification', src, winText .. win3)
	end

	if rndm >= 4 then
		TriggerClientEvent('99kr-burglary:Sound', src, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET")
		TriggerClientEvent('esx:showNotification', src, ticketEmpty)
	end

end)