--------------------------------
------- Created by Hamza -------
-------------------------------- 

local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Server Event for Buying:
RegisterServerEvent("esx_PawnShop:BuyItem")
AddEventHandler("esx_PawnShop:BuyItem", function(amountToBuy,totalBuyPrice,itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	if xPlayer.getMoney() >= totalBuyPrice then
		xPlayer.removeMoney(totalBuyPrice)
		xPlayer.addInventoryItem(itemName, amountToBuy)
		TriggerClientEvent("esx:showNotification",source,"Vous avez payez ~g~$"..totalBuyPrice.."~s~ pour "..amountToBuy.."x ~y~"..itemLabel.."~s~")
	else
		TriggerClientEvent("esx:showNotification",source,"Pas assez d'argent")
	end
end)

-- Server Event for Selling:
RegisterServerEvent("esx_PawnShop:SellItem")
AddEventHandler("esx_PawnShop:SellItem", function(amountToSell,totalSellPrice,itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	if xPlayer.getInventoryItem(itemName).count >= amountToSell then
		xPlayer.addMoney(totalSellPrice)
		xPlayer.removeInventoryItem(itemName, amountToSell)
		TriggerClientEvent("esx:showNotification",source,"Vous avez vendu "..amountToSell.."x ~y~"..itemLabel.."~s~ pour ~g~$"..totalSellPrice.."~s~")
	else
		TriggerClientEvent("esx:showNotification",source,"Pas assez d'objets")
	end
end)
