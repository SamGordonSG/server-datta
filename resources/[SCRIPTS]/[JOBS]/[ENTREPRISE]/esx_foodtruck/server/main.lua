-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------

ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'foodtruck', 'Client FoodTruck', true, true)
TriggerEvent('esx_society:registerSociety', 'foodtruck', 'Foodtruck', 'society_foodtruck', 'society_foodtruck', 'society_foodtruck', {type = 'private'})

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'foodtruck', Config.MaxInService)
end


ESX.RegisterServerCallback('foodtruck:getArmoryWeapons', function(source, cb)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_foodtruck', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('foodtruck:addArmoryWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.removeWeapon(weaponName)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_foodtruck', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = weapons[i].count + 1
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 1
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)
-----------------------------------
RegisterServerEvent('esx_foodtruck:sellItem')
AddEventHandler('esx_foodtruck:sellItem', function(itemName, price, itemLabel)

    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)

    local qtty = xPlayer.getInventoryItem(itemName).count
    local societyAccount = nil

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_foodtruck', function(account)
        societyAccount = account
      end)

    if societyAccount ~= nil and qtty >= 1 then
        xPlayer.removeInventoryItem(itemName, 1)


        local playerMoney  = math.floor(price / 100 * 10)
        local societyMoney = math.floor(price / 100 * 90)

        xPlayer.addMoney(playerMoney)
        societyAccount.addMoney(societyMoney)

        TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = "<b style='color:grey'>O'Taco</b><br><br>💶 votre société a gagné  " .. societyMoney .. " $ !<br><br><b style='color:grey'>O'Taco'</b>", type = "info", time = 7000})
        TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = "<b style='color:grey'>O'Taco</b><br><br>💶 vous avez gagné  " .. playerMoney .. "  $ !<br><br><b style='color:grey'>O'Taco'</b>", type = "info", time = 7000})

    else
        TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = "<b style='color:grey'>O'Taco</b><br><br>❌ vous n\'avez pas de " .. itemLabel .. "<br><br><b style='color:grey'>O'Taco'</b>", type = "error", time = 7000})
    end

end)
-----------------------------------

ESX.RegisterServerCallback('foodtruck:removeArmoryWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addWeapon(weaponName, 1000)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_foodtruck', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 0
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

ESX.RegisterServerCallback('foodtruck:buy', function(source, cb, amount)

  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_foodtruck', function(account)

    if account.money >= amount then
      account.removeMoney(amount)
      cb(true)
    else
      cb(false)
    end

  end)

end)

ESX.RegisterServerCallback('esx_foodtruck:getStock', function(source, cb)
	local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)

	local fridge = {}

	for k,v in pairs(Config.Fridge) do
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].name == k then
					table.insert(fridge, xPlayer.inventory[i])
				break
			end
		end
	end

	cb(fridge, MarketPrices)
end)

RegisterServerEvent('esx_foodtruck:buyItem')
AddEventHandler('esx_foodtruck:buyItem', function(itemName, price, itemLabel)
 local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local limit = xPlayer.getInventoryItem(itemName).limit
    local qtty = xPlayer.getInventoryItem(itemName).count
	 local societyAccount = nil
	
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_foodtruck', function(account)
        societyAccount = account
      end)

	  if societyAccount ~= nil and societyAccount.money >= price then
    --if xPlayer.get('money') >= price then
            societyAccount.removeMoney(price)
            xPlayer.addInventoryItem(itemName, 1)
            TriggerClientEvent('esx:showNotification', _source, _U('bought') .. itemLabel)
    else
        TriggerClientEvent('esx:showNotification', _source, _U('not_enough'))
    end

end)
----------------------------------------------
RegisterServerEvent('esx_foodtruck:craftingCoktails')
AddEventHandler('esx_foodtruck:craftingCoktails', function(itemValue)

    local _source = source
    local _itemValue = itemValue
    TriggerClientEvent('esx:showNotification', _source, _U('assembling_cocktail'))

    if _itemValue == 'tacos' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('bread').count
            local bethQuantity      = xPlayer.getInventoryItem('meat').count
			local gimelQuantity     = xPlayer.getInventoryItem('vegetables').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('meat') .. '~w~')
			elseif gimelQuantity < 1 then
				 TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('bread', 1)
                    xPlayer.removeInventoryItem('meat', 2)
					xPlayer.removeInventoryItem('vegetables', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('tacos') .. ' ~w~!')
                    xPlayer.removeInventoryItem('bread', 1)
                    xPlayer.removeInventoryItem('meat', 2)
					xPlayer.removeInventoryItem('vegetables', 1)
                    xPlayer.addInventoryItem('tacos', 1)
                end
            end

        end)
    end

    if _itemValue == 'haydari' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('menthe').count
            local bethQuantity      = xPlayer.getInventoryItem('carotte').count
            local gimelQuantity     = xPlayer.getInventoryItem('yaourt').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('menthe') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('carotte') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('yaourt') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('menthe', 1)
                    xPlayer.removeInventoryItem('carotte', 1)
                    xPlayer.removeInventoryItem('yaourt', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('haydari') .. ' ~w~!')
                    xPlayer.removeInventoryItem('menthe', 1)
                    xPlayer.removeInventoryItem('carotte', 1)
                    xPlayer.removeInventoryItem('yaourt', 1)
                    xPlayer.addInventoryItem('haydari', 1)
                end
            end

        end)
    end
    
    if _itemValue == 'cacik' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('yaourt').count
            local bethQuantity      = xPlayer.getInventoryItem('concombre').count

            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('yaourt') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('concombre') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('yaourt', 2)
                    xPlayer.removeInventoryItem('concombre', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('cacik') .. ' ~w~!')
                    xPlayer.removeInventoryItem('yaourt', 2)
                    xPlayer.removeInventoryItem('concombre', 1)
                    xPlayer.addInventoryItem('cacik', 1)
                end
            end

        end)
    end

    if _itemValue == 'karides' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('crevette').count
            local bethQuantity      = xPlayer.getInventoryItem('poivron').count
			local gimelQuantity     = xPlayer.getInventoryItem('tomate').count
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('crevette') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poivron') .. '~w~')
			elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tomate') .. '~w~')
            else
			
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('crevette', 1)
                    xPlayer.removeInventoryItem('poivron', 1)
					xPlayer.removeInventoryItem('tomate', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('karides') .. ' ~w~!')
                    xPlayer.removeInventoryItem('crevette', 1)
					xPlayer.removeInventoryItem('poivron', 1)
                    xPlayer.removeInventoryItem('tomate', 1)
                    xPlayer.addInventoryItem('karides', 1)
                end
            end

        end)
    end

	if _itemValue == 'burger' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('meat').count
            local bethQuantity      = xPlayer.getInventoryItem('bread').count
			local gimelQuantity     = xPlayer.getInventoryItem('vegetables').count
            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('meat') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
			elseif gimelQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
            else
			
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('meat', 2)
                    xPlayer.removeInventoryItem('bread', 2)
					xPlayer.removeInventoryItem('vegetables', 2)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('burger') .. ' ~w~!')
                    xPlayer.removeInventoryItem('meat', 2)
					xPlayer.removeInventoryItem('bread', 2)
                    xPlayer.removeInventoryItem('vegetables', 2)
                    xPlayer.addInventoryItem('burger', 1)
                end
            end

        end)
    end
	
	if _itemValue == 'chips' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('patate').count
            local bethQuantity      = xPlayer.getInventoryItem('sel').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('patate') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('sel') .. '~w~')
			else
			
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('patate', 1)
                    xPlayer.removeInventoryItem('sel', 1)
					
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('chips') .. ' ~w~!')
                    xPlayer.removeInventoryItem('patate', 1)
					xPlayer.removeInventoryItem('sel', 1)
                   
                    xPlayer.addInventoryItem('chips', 1)
                end
            end

        end)
    end
	
	if _itemValue == 'nuggetss' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('sel').count
            local bethQuantity      = xPlayer.getInventoryItem('poulet').count
			local gimelQuantity     = xPlayer.getInventoryItem('bread').count
            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('sel') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
			elseif gimelQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            else
			
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('sel', 2)
                    xPlayer.removeInventoryItem('poulet', 2)
					xPlayer.removeInventoryItem('bread', 2)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('nuggetss') .. ' ~w~!')
                    xPlayer.removeInventoryItem('sel', 2)
					xPlayer.removeInventoryItem('poulet', 2)
                    xPlayer.removeInventoryItem('bread', 2)
                    xPlayer.addInventoryItem('nuggetss', 1)
                end
            end

        end)
    end
	
	if _itemValue == 'kebab' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('meat').count
            local bethQuantity      = xPlayer.getInventoryItem('oignon').count
			local gimelQuantity     = xPlayer.getInventoryItem('vegetables').count
            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('meat') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('oignon') .. '~w~')
			elseif gimelQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
            else
			
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('meat', 2)
                    xPlayer.removeInventoryItem('oignon', 2)
					xPlayer.removeInventoryItem('vegetables', 2)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('kebab') .. ' ~w~!')
                    xPlayer.removeInventoryItem('meat', 2)
					xPlayer.removeInventoryItem('oignon', 2)
                    xPlayer.removeInventoryItem('vegetables', 2)
                    xPlayer.addInventoryItem('kebab', 1)
                end
            end

        end)
    end
	
	if _itemValue == 'wrap' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('bread').count
            local bethQuantity      = xPlayer.getInventoryItem('poulet').count
			local gimelQuantity     = xPlayer.getInventoryItem('vegetables').count
            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
			elseif gimelQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
            else
			
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('bread', 2)
                    xPlayer.removeInventoryItem('poulet', 2)
					xPlayer.removeInventoryItem('vegetables', 2)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('wrap') .. ' ~w~!')
                    xPlayer.removeInventoryItem('bread', 2)
					xPlayer.removeInventoryItem('poulet', 2)
                    xPlayer.removeInventoryItem('vegetables', 2)
                    xPlayer.addInventoryItem('wrap', 1)
                end
            end

        end)
    end
	
	if _itemValue == 'fishburger' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('bread').count
            local bethQuantity      = xPlayer.getInventoryItem('poulet').count
			local gimelQuantity     = xPlayer.getInventoryItem('vegetables').count
            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
			elseif gimelQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
            else
			
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('bread', 2)
                    xPlayer.removeInventoryItem('poulet', 2)
					xPlayer.removeInventoryItem('vegetables', 2)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('fishburger') .. ' ~w~!')
                    xPlayer.removeInventoryItem('bread', 2)
					xPlayer.removeInventoryItem('poulet', 2)
                    xPlayer.removeInventoryItem('vegetables', 2)
                    xPlayer.addInventoryItem('fishburger', 1)
                end
            end

        end)
    end

	if _itemValue == 'pizza' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('bread').count
            local bethQuantity      = xPlayer.getInventoryItem('tomate').count
			local gimelQuantity     = xPlayer.getInventoryItem('merguez').count
            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tomate') .. '~w~')
			elseif gimelQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('merguez') .. '~w~')
            else
			
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('bread', 2)
                    xPlayer.removeInventoryItem('tomate', 2)
					xPlayer.removeInventoryItem('merguez', 2)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('pizza') .. ' ~w~!')
                    xPlayer.removeInventoryItem('bread', 2)
					xPlayer.removeInventoryItem('poulet', 2)
                    xPlayer.removeInventoryItem('merguez', 2)
                    xPlayer.addInventoryItem('pizza', 1)
                end
            end

        end)
    end
	
	if _itemValue == 'salade' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('tomate').count
            local bethQuantity      = xPlayer.getInventoryItem('vegetables').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tomate') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
			else
			
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('tomate', 1)
                    xPlayer.removeInventoryItem('vegetables', 1)
					
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('salade') .. ' ~w~!')
                    xPlayer.removeInventoryItem('tomate', 1)
					xPlayer.removeInventoryItem('vegetables', 1)
                   
                    xPlayer.addInventoryItem('salade', 1)
                end
            end

        end)
    end
		
    if _itemValue == 'couscousa' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('couscous1').count
            local bethQuantity      = xPlayer.getInventoryItem('oignon').count
            local gimelQuantity     = xPlayer.getInventoryItem('courgette').count
			local daletQuantity      = xPlayer.getInventoryItem('agneau').count
			
            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('couscous1') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('oignon') .. '~w~')
            elseif gimelQuantity < 4 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('courgette') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('agneau') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('couscous1', 2)
                    xPlayer.removeInventoryItem('oignon', 2)
                    xPlayer.removeInventoryItem('courgette', 4)
					xPlayer.removeInventoryItem('agneau', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('couscousa') .. ' ~w~!')
                    xPlayer.removeInventoryItem('couscous1', 2)
                    xPlayer.removeInventoryItem('oignon', 2)
                    xPlayer.removeInventoryItem('courgette', 4)
					xPlayer.removeInventoryItem('agneau', 1)
                    xPlayer.addInventoryItem('couscousa', 1)
                end
            end

        end)
    end
	
	if _itemValue == 'couscousp' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('couscous1').count
            local bethQuantity      = xPlayer.getInventoryItem('oignon').count
            local gimelQuantity     = xPlayer.getInventoryItem('courgette').count
			local daletQuantity      = xPlayer.getInventoryItem('poulet').count
			
            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('couscous1') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('oignon') .. '~w~')
            elseif gimelQuantity < 4 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('courgette') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('couscous1', 2)
                    xPlayer.removeInventoryItem('oignon', 2)
                    xPlayer.removeInventoryItem('courgette', 4)
					xPlayer.removeInventoryItem('poulet', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('couscousp') .. ' ~w~!')
                    xPlayer.removeInventoryItem('couscous1', 2)
                    xPlayer.removeInventoryItem('oignon', 2)
                    xPlayer.removeInventoryItem('courgette', 4)
					xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.addInventoryItem('couscousp', 1)
                end
            end

        end)
    end
	
	if _itemValue == 'couscousm' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('couscous1').count
            local bethQuantity      = xPlayer.getInventoryItem('oignon').count
            local gimelQuantity     = xPlayer.getInventoryItem('courgette').count
			local daletQuantity      = xPlayer.getInventoryItem('merguez').count
			
            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('couscous1') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('oignon') .. '~w~')
            elseif gimelQuantity < 4 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('courgette') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('merguez') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('couscous1', 2)
                    xPlayer.removeInventoryItem('oignon', 2)
                    xPlayer.removeInventoryItem('courgette', 4)
					xPlayer.removeInventoryItem('merguez', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('couscousm') .. ' ~w~!')
                    xPlayer.removeInventoryItem('couscous1', 2)
                    xPlayer.removeInventoryItem('oignon', 2)
                    xPlayer.removeInventoryItem('courgette', 4)
					xPlayer.removeInventoryItem('merguez', 1)
                    xPlayer.addInventoryItem('couscousm', 1)
                end
            end

        end)
    end

	if _itemValue == 'tajine' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('tomate').count
            local bethQuantity      = xPlayer.getInventoryItem('oignon').count
            local gimelQuantity     = xPlayer.getInventoryItem('courgette').count
			local daletQuantity      = xPlayer.getInventoryItem('agneau').count
			
            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tomate') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('oignon') .. '~w~')
            elseif gimelQuantity < 4 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('courgette') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('agneau') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('tomate', 2)
                    xPlayer.removeInventoryItem('oignon', 2)
                    xPlayer.removeInventoryItem('courgette', 4)
					xPlayer.removeInventoryItem('agneau', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('tajine') .. ' ~w~!')
                    xPlayer.removeInventoryItem('tomate', 2)
                    xPlayer.removeInventoryItem('oignon', 2)
                    xPlayer.removeInventoryItem('courgette', 4)
					xPlayer.removeInventoryItem('agneau', 1)
                    xPlayer.addInventoryItem('tajine', 1)
                end
            end

        end)
    end
	
    if _itemValue == 'iskender' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('meat').count
            local bethQuantity      = xPlayer.getInventoryItem('bread').count
            local gimelQuantity     = xPlayer.getInventoryItem('yaourt').count

            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('meat') .. '~w~')
            elseif bethQuantity < 3 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif gimelQuantity < 3 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('yaourt') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('meat', 2)
                    xPlayer.removeInventoryItem('bread', 3)
                    xPlayer.removeInventoryItem('yaourt', 3)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('iskender') .. ' ~w~!')
                    xPlayer.removeInventoryItem('meat', 2)
                    xPlayer.removeInventoryItem('bread', 3)
                    xPlayer.removeInventoryItem('yaourt', 3)
                    xPlayer.addInventoryItem('iskender', 1) 
                end
            end

        end)
    end

    if _itemValue == 'dame_blanche' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('boule_vanille').count
            local bethQuantity      = xPlayer.getInventoryItem('sauce_chocolat').count
            local gimelQuantity     = xPlayer.getInventoryItem('chantilly').count

            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boule_vanille') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('sauce_chocolat') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('chantilly') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('boule_vanille', 2)
                    xPlayer.removeInventoryItem('sauce_chocolat', 2)
                    xPlayer.removeInventoryItem('chantilly', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('dame_blanche') .. ' ~w~!')
                    xPlayer.removeInventoryItem('boule_vanille', 2)
                    xPlayer.removeInventoryItem('sauce_chocolat', 2)
                    xPlayer.removeInventoryItem('chantilly', 1)
                    xPlayer.addInventoryItem('dame_blanche', 1)
                end
            end

        end)
    end

	if _itemValue == 'donuts' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('sucre').count
            local bethQuantity      = xPlayer.getInventoryItem('farine').count
            local gimelQuantity     = xPlayer.getInventoryItem('sauce_chocolat').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('sucre') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('farine') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('sauce_chocolat') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('sucre', 1)
                    xPlayer.removeInventoryItem('farine', 2)
                    xPlayer.removeInventoryItem('sauce_chocolat', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('donuts') .. ' ~w~!')
                    xPlayer.removeInventoryItem('sucre', 1)
                    xPlayer.removeInventoryItem('farine', 2)
                    xPlayer.removeInventoryItem('sauce_chocolat', 1)
                    xPlayer.addInventoryItem('donuts', 1)
                end
            end

        end)
    end

    if _itemValue == 'banana_split' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('boule_vanille').count
            local bethQuantity      = xPlayer.getInventoryItem('boule_fraise').count
            local gimelQuantity     = xPlayer.getInventoryItem('banane').count
            local daletQuantity      = xPlayer.getInventoryItem('chantilly').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boule_vanille') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boule_fraise') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('banane') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('chantilly') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('boule_vanille', 1)
                    xPlayer.removeInventoryItem('boule_fraise', 1)
                    xPlayer.removeInventoryItem('banane', 1)
                    xPlayer.removeInventoryItem('chantilly', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('banana_split') .. ' ~w~!')
                    xPlayer.removeInventoryItem('boule_vanille', 1)
                    xPlayer.removeInventoryItem('boule_fraise', 1)
                    xPlayer.removeInventoryItem('banane', 1)
                    xPlayer.removeInventoryItem('chantilly', 1)
                    xPlayer.addInventoryItem('banana_split', 1)
                end
            end

        end)
    end

    if _itemValue == 'coupe_anglaise' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('boule_menthe').count
            local bethQuantity      = xPlayer.getInventoryItem('boule_vanille').count
            local gimelQuantity     = xPlayer.getInventoryItem('boule_chocolat').count
            local daletQuantity     = xPlayer.getInventoryItem('chantilly').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boule_menthe') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boule_vanille') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boule_chocolat') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('chantilly') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('boule_menthe', 1)
                    xPlayer.removeInventoryItem('boule_vanille', 1)
                    xPlayer.removeInventoryItem('boule_chocolat', 1)
                    xPlayer.removeInventoryItem('chantilly', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('coupe_anglaise') .. ' ~w~!')
                    xPlayer.removeInventoryItem('boule_menthe', 1)
                    xPlayer.removeInventoryItem('boule_vanille', 1)
                    xPlayer.removeInventoryItem('boule_chocolat', 1)
                    xPlayer.removeInventoryItem('chantilly', 1)
                    xPlayer.addInventoryItem('coupe_anglaise', 1)
                end
            end

        end)
    end

--Nouvelle carte--

--entr�es--

    if _itemValue == 'batonnets_de_mozzarella' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('mozzarella').count
            local bethQuantity      = xPlayer.getInventoryItem('farine').count
            local gimelQuantity     = xPlayer.getInventoryItem('oeuf').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('mozzarella') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('farine') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('oeuf') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('mozzarella', 1)
                    xPlayer.removeInventoryItem('farine', 1)
                    xPlayer.removeInventoryItem('oeuf', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('batonnets_de_mozzarella') .. ' ~w~!')
                    xPlayer.removeInventoryItem('mozzarella', 1)
                    xPlayer.removeInventoryItem('farine', 1)
                    xPlayer.removeInventoryItem('oeuf', 1)
                    xPlayer.addInventoryItem('batonnets_de_mozzarella', 1)
                end
            end

        end)
    end

    if _itemValue == 'oignon_rings' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('oignon').count
            local bethQuantity      = xPlayer.getInventoryItem('farine').count
            local gimelQuantity     = xPlayer.getInventoryItem('oeuf').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('oignon') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('farine') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('oeuf') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('oignon', 1)
                    xPlayer.removeInventoryItem('farine', 1)
                    xPlayer.removeInventoryItem('oeuf', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('oignon_rings') .. ' ~w~!')
                    xPlayer.removeInventoryItem('oignon', 1)
                    xPlayer.removeInventoryItem('farine', 1)
                    xPlayer.removeInventoryItem('oeuf', 1)
                    xPlayer.addInventoryItem('oignon_rings', 1)
                end
            end

        end)
    end

    if _itemValue == 'mais_grille' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('mais').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('mais') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('mais', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('mais_grille') .. ' ~w~!')
                    xPlayer.removeInventoryItem('mais', 1)
                    xPlayer.addInventoryItem('mais_grille', 1)
                end
            end

        end)
    end


    if _itemValue == 'chicken_wings' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('poulet').count
            local bethQuantity      = xPlayer.getInventoryItem('sauce').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('sauce') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.removeInventoryItem('sauce', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('chicken_wings') .. ' ~w~!')
                    xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.removeInventoryItem('sauce', 1)
                    xPlayer.addInventoryItem('chicken_wings', 1)
                end
            end

        end)
    end


    if _itemValue == 'sunny_cheese_fries' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('patate').count
            local bethQuantity      = xPlayer.getInventoryItem('fromage').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('patate') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('fromage') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('patate', 1)
                    xPlayer.removeInventoryItem('fromage', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('sunny_cheese_fries') .. ' ~w~!')
                    xPlayer.removeInventoryItem('patate', 1)
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.addInventoryItem('sunny_cheese_fries', 1)
                end
            end

        end)
    end

	    if _itemValue == 'salade_de_tomates' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('tomate').count
            local bethQuantity      = xPlayer.getInventoryItem('salade').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tomate') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('salade') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('tomate', 1)
                    xPlayer.removeInventoryItem('salade', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('salade_de_tomates') .. ' ~w~!')
                    xPlayer.removeInventoryItem('tomate', 1)
                    xPlayer.removeInventoryItem('salade', 1)
                    xPlayer.addInventoryItem('salade_de_tomates', 1)
                end
            end

        end)
    end
	
	if _itemValue == 'salade_cobb' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('tomate').count
            local bethQuantity      = xPlayer.getInventoryItem('salade').count
            local gimelQuantity     = xPlayer.getInventoryItem('poulet').count
			local daletQuantity      = xPlayer.getInventoryItem('fromage').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tomate') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('salade') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('fromage') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('tomate', 1)
                    xPlayer.removeInventoryItem('salade', 1)
                    xPlayer.removeInventoryItem('poulet', 1)
					xPlayer.removeInventoryItem('fromage', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('salade_cobb') .. ' ~w~!')
                    xPlayer.removeInventoryItem('tomate', 1)
                    xPlayer.removeInventoryItem('salade', 1)
                    xPlayer.removeInventoryItem('poulet', 1)
					xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.addInventoryItem('salade_cobb', 1)
                end
            end

        end)
    end
	
		if _itemValue == 'salade_cesar' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('tomate').count
            local bethQuantity      = xPlayer.getInventoryItem('salade').count
            local gimelQuantity     = xPlayer.getInventoryItem('bread').count
			local daletQuantity      = xPlayer.getInventoryItem('poulet').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tomate') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('salade') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('tomate', 1)
                    xPlayer.removeInventoryItem('salade', 1)
                    xPlayer.removeInventoryItem('bread', 1)
					xPlayer.removeInventoryItem('poulet', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('salade_cesar') .. ' ~w~!')
                    xPlayer.removeInventoryItem('tomate', 1)
                    xPlayer.removeInventoryItem('salade', 1)
                    xPlayer.removeInventoryItem('bread', 1)
					xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.addInventoryItem('salade_cesar', 1)
                end
            end

        end)
    end
	
			if _itemValue == 'salade_marilyn' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('tomate').count
            local bethQuantity      = xPlayer.getInventoryItem('avocat').count
            local gimelQuantity     = xPlayer.getInventoryItem('bread').count
			local daletQuantity      = xPlayer.getInventoryItem('salade').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tomate') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('salade') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('tomate', 1)
                    xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.removeInventoryItem('bread', 1)
					xPlayer.removeInventoryItem('salade', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('salade_marilyn') .. ' ~w~!')
                    xPlayer.removeInventoryItem('tomate', 1)
                    xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.removeInventoryItem('bread', 1)
					xPlayer.removeInventoryItem('salade', 1)
                    xPlayer.addInventoryItem('salade_marilyn', 1)
                end
            end

        end)
    end
	
				if _itemValue == 'jambon_grille' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('boeuf').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boeuf') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('boeuf', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('jambon_grille') .. ' ~w~!')
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.addInventoryItem('jambon_grille', 1)
                end
            end

        end)
    end
	
					if _itemValue == 'chief_steak' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('boeuf').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boeuf') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('boeuf', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('chief_steak') .. ' ~w~!')
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.addInventoryItem('chief_steak', 1)
                end
            end

        end)
    end
	
	    if _itemValue == 'chicken_delight' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('poulet').count
            local bethQuantity      = xPlayer.getInventoryItem('vegetables').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.removeInventoryItem('vegetables', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('chicken_delight') .. ' ~w~!')
                    xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.removeInventoryItem('vegetables', 1)
                    xPlayer.addInventoryItem('chicken_delight', 1)
                end
            end

        end)
    end
	
				if _itemValue == 'brochette' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('boeuf').count
            local bethQuantity      = xPlayer.getInventoryItem('agneau').count
            local gimelQuantity     = xPlayer.getInventoryItem('poulet').count
			local daletQuantity      = xPlayer.getInventoryItem('merguez').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boeuf') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('agneau') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('merguez') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('agneau', 1)
                    xPlayer.removeInventoryItem('poulet', 1)
					xPlayer.removeInventoryItem('merguez', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('brochette') .. ' ~w~!')
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('agneau', 1)
                    xPlayer.removeInventoryItem('poulet', 1)
					xPlayer.removeInventoryItem('merguez', 1)
                    xPlayer.addInventoryItem('brochette', 1)
                end
            end

        end)
    end
	
		    if _itemValue == 'ribs' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('boeuf').count
            local bethQuantity      = xPlayer.getInventoryItem('sauce').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boeuf') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('sauce') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('sauce', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('ribs') .. ' ~w~!')
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('sauce', 1)
                    xPlayer.addInventoryItem('ribs', 1)
                end
            end

        end)
    end
	
					if _itemValue == 'toasty_cheese' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('fromage').count
            local bethQuantity      = xPlayer.getInventoryItem('boeuf').count
            local gimelQuantity     = xPlayer.getInventoryItem('bread').count
			local daletQuantity      = xPlayer.getInventoryItem('bacon').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('fromage') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boeuf') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bacon') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('bread', 1)
					xPlayer.removeInventoryItem('bacon', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('toasty_cheese') .. ' ~w~!')
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('bread', 1)
					xPlayer.removeInventoryItem('bacon', 1)
                    xPlayer.addInventoryItem('toasty_cheese', 1)
                end
            end

        end)
    end
	
						if _itemValue == 'cheese' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('fromage').count
            local bethQuantity      = xPlayer.getInventoryItem('boeuf').count
            local gimelQuantity     = xPlayer.getInventoryItem('bread').count
			local daletQuantity      = xPlayer.getInventoryItem('vegetables').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('fromage') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boeuf') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('bread', 1)
					xPlayer.removeInventoryItem('vegetables', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('cheese') .. ' ~w~!')
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('bread', 1)
					xPlayer.removeInventoryItem('vegetables', 1)
                    xPlayer.addInventoryItem('cheese', 1)
                end
            end

        end)
    end
	
							if _itemValue == 'fish' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('salade').count
            local bethQuantity      = xPlayer.getInventoryItem('poisson').count
            local gimelQuantity     = xPlayer.getInventoryItem('bread').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('salade') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poisson') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('salade', 1)
                    xPlayer.removeInventoryItem('poisson', 1)
                    xPlayer.removeInventoryItem('bread', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('fish') .. ' ~w~!')
                    xPlayer.removeInventoryItem('salade', 1)
                    xPlayer.removeInventoryItem('poisson', 1)
                    xPlayer.removeInventoryItem('bread', 1)
                    xPlayer.addInventoryItem('fish', 1)
                end
            end

        end)
    end
	
							if _itemValue == 'new_sunny' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('fromage').count
            local bethQuantity      = xPlayer.getInventoryItem('poulet').count
            local gimelQuantity     = xPlayer.getInventoryItem('bread').count
			local daletQuantity      = xPlayer.getInventoryItem('salade').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('fromage') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('salade') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.removeInventoryItem('bread', 1)
					xPlayer.removeInventoryItem('salade', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('new_sunny') .. ' ~w~!')
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.removeInventoryItem('bread', 1)
					xPlayer.removeInventoryItem('salade', 1)
                    xPlayer.addInventoryItem('new_sunny', 1)
                end
            end

        end)
    end
	
								if _itemValue == 'mountain' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('fromage').count
            local bethQuantity      = xPlayer.getInventoryItem('boeuf').count
            local gimelQuantity     = xPlayer.getInventoryItem('bread').count
			local daletQuantity      = xPlayer.getInventoryItem('patate').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('fromage') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boeuf') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('patate') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('bread', 1)
					xPlayer.removeInventoryItem('patate', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('mountain') .. ' ~w~!')
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('bread', 1)
					xPlayer.removeInventoryItem('patate', 1)
                    xPlayer.addInventoryItem('mountain', 1)
                end
            end

        end)
    end
	
			    if _itemValue == 'fish_and_chips' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('poisson').count
            local bethQuantity      = xPlayer.getInventoryItem('frites').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poisson') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('frites') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('poisson', 1)
                    xPlayer.removeInventoryItem('frites', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('fish_and_chips') .. ' ~w~!')
                    xPlayer.removeInventoryItem('poisson', 1)
                    xPlayer.removeInventoryItem('frites', 1)
                    xPlayer.addInventoryItem('fish_and_chips', 1)
                end
            end

        end)
    end
	
									if _itemValue == 'americain_eggs' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('fromage').count
            local bethQuantity      = xPlayer.getInventoryItem('oeuf').count
            local gimelQuantity     = xPlayer.getInventoryItem('vegetables').count
			local daletQuantity      = xPlayer.getInventoryItem('patate').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('fromage') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('oeuf') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('patate') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('oeuf', 1)
                    xPlayer.removeInventoryItem('vegetables', 1)
					xPlayer.removeInventoryItem('patate', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('americain_eggs') .. ' ~w~!')
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('oeuf', 1)
                    xPlayer.removeInventoryItem('vegetables', 1)
					xPlayer.removeInventoryItem('patate', 1)
                    xPlayer.addInventoryItem('americain_eggs', 1)
                end
            end

        end)
    end
	
				    if _itemValue == 'delicious_chicken' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('poulet').count
            local bethQuantity      = xPlayer.getInventoryItem('frites').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('frites') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.removeInventoryItem('frites', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('delicious_chicken') .. ' ~w~!')
                    xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.removeInventoryItem('frites', 1)
                    xPlayer.addInventoryItem('delicious_chicken', 1)
                end
            end

        end)
    end
	
					    if _itemValue == 'americain_hot_dog' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('boeuf').count
            local bethQuantity      = xPlayer.getInventoryItem('bread').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boeuf') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('bread', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('americain_hot_dog') .. ' ~w~!')
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('bread', 1)
                    xPlayer.addInventoryItem('americain_hot_dog', 1)
                end
            end

        end)
    end
	
										if _itemValue == 'macaroni_cheese' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('fromage').count
            local bethQuantity      = xPlayer.getInventoryItem('salade').count
            local gimelQuantity     = xPlayer.getInventoryItem('pates').count
			local daletQuantity      = xPlayer.getInventoryItem('bacon').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('fromage') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('salade') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('pates') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bacon') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('salade', 1)
                    xPlayer.removeInventoryItem('pates', 1)
					xPlayer.removeInventoryItem('bacon', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('macaroni_cheese') .. ' ~w~!')
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('salade', 1)
                    xPlayer.removeInventoryItem('pates', 1)
					xPlayer.removeInventoryItem('bacon', 1)
                    xPlayer.addInventoryItem('macaroni_cheese', 1)
                end
            end

        end)
    end
	
											if _itemValue == 'chicken_wrap' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('bread').count
            local bethQuantity      = xPlayer.getInventoryItem('poulet').count
            local gimelQuantity     = xPlayer.getInventoryItem('patate').count
			local daletQuantity      = xPlayer.getInventoryItem('vegetables').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('poulet') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('patate') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('bread', 1)
                    xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.removeInventoryItem('patate', 1)
					xPlayer.removeInventoryItem('vegetables', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('chicken_wrap') .. ' ~w~!')
                    xPlayer.removeInventoryItem('bread', 1)
                    xPlayer.removeInventoryItem('poulet', 1)
                    xPlayer.removeInventoryItem('patate', 1)
					xPlayer.removeInventoryItem('vegetables', 1)
                    xPlayer.addInventoryItem('chicken_wrap', 1)
                end
            end

        end)
    end
	
											if _itemValue == 'patty_melt' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('bread').count
            local bethQuantity      = xPlayer.getInventoryItem('boeuf').count
            local gimelQuantity     = xPlayer.getInventoryItem('bacon').count
			local daletQuantity      = xPlayer.getInventoryItem('vegetables').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boeuf') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('bread', 1)
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('bacon', 1)
					xPlayer.removeInventoryItem('vegetables', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('patty_melt') .. ' ~w~!')
                    xPlayer.removeInventoryItem('bread', 1)
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('bacon', 1)
					xPlayer.removeInventoryItem('vegetables', 1)
                    xPlayer.addInventoryItem('patty_melt', 1)
                end
            end

        end)
    end
	
											if _itemValue == 'blue_beef_wrap' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('bread').count
            local bethQuantity      = xPlayer.getInventoryItem('boeuf').count
            local gimelQuantity     = xPlayer.getInventoryItem('patate').count
			local daletQuantity      = xPlayer.getInventoryItem('vegetables').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boeuf') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('patate') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vegetables') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('bread', 1)
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('patate', 1)
					xPlayer.removeInventoryItem('vegetables', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('blue_beef_wrap') .. ' ~w~!')
                    xPlayer.removeInventoryItem('bread', 1)
                    xPlayer.removeInventoryItem('boeuf', 1)
                    xPlayer.removeInventoryItem('patate', 1)
					xPlayer.removeInventoryItem('vegetables', 1)
                    xPlayer.addInventoryItem('blue_beef_wrap', 1)
                end
            end

        end)
    end
	
						    if _itemValue == 'milkshake' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('milk').count
            local bethQuantity      = xPlayer.getInventoryItem('boule_chocolat').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('milk') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boule_chocolat') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('milk', 1)
                    xPlayer.removeInventoryItem('boule_chocolat', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('milkshake') .. ' ~w~!')
                    xPlayer.removeInventoryItem('milk', 1)
                    xPlayer.removeInventoryItem('boule_chocolat', 1)
                    xPlayer.addInventoryItem('milkshake', 1)
                end
            end

        end)
    end
	
						    if _itemValue == 'smoothie' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('water').count
            local bethQuantity      = xPlayer.getInventoryItem('boule_chocolat').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('water') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boule_chocolat') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('water', 1)
                    xPlayer.removeInventoryItem('boule_chocolat', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('smoothie') .. ' ~w~!')
                    xPlayer.removeInventoryItem('water', 1)
                    xPlayer.removeInventoryItem('boule_chocolat', 1)
                    xPlayer.addInventoryItem('smoothie', 1)
                end
            end

        end)
    end
	
								if _itemValue == 'sundae' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('chantilly').count
            local bethQuantity      = xPlayer.getInventoryItem('boule_chocolat').count
            local gimelQuantity     = xPlayer.getInventoryItem('sauce_chocolat').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('chantilly') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boule_chocolat') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('sauce_chocolat') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('chantilly', 1)
                    xPlayer.removeInventoryItem('boule_chocolat', 1)
                    xPlayer.removeInventoryItem('sauce_chocolat', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('sundae') .. ' ~w~!')
                    xPlayer.removeInventoryItem('chantilly', 1)
                    xPlayer.removeInventoryItem('boule_chocolat', 1)
                    xPlayer.removeInventoryItem('sauce_chocolat', 1)
                    xPlayer.addInventoryItem('sundae', 1)
                end
            end

        end)
    end
	
												if _itemValue == 'cookie' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('milk').count
            local bethQuantity      = xPlayer.getInventoryItem('farine').count
            local gimelQuantity     = xPlayer.getInventoryItem('oeuf').count
			local daletQuantity      = xPlayer.getInventoryItem('sauce_chocolat').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('milk') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('farine') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('oeuf') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('sauce_chocolat') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('milk', 1)
                    xPlayer.removeInventoryItem('farine', 1)
                    xPlayer.removeInventoryItem('oeuf', 1)
					xPlayer.removeInventoryItem('sauce_chocolat', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('cookie') .. ' ~w~!')
                    xPlayer.removeInventoryItem('milk', 1)
                    xPlayer.removeInventoryItem('farine', 1)
                    xPlayer.removeInventoryItem('oeuf', 1)
					xPlayer.removeInventoryItem('sauce_chocolat', 1)
                    xPlayer.addInventoryItem('cookie', 1)
                end
            end

        end)
    end
	
									if _itemValue == 'brownie' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('boule_vanille').count
            local bethQuantity      = xPlayer.getInventoryItem('boule_chocolat').count
            local gimelQuantity     = xPlayer.getInventoryItem('sauce_chocolat').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boule_vanille') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boule_chocolat') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('sauce_chocolat') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('boule_vanille', 1)
                    xPlayer.removeInventoryItem('boule_chocolat', 1)
                    xPlayer.removeInventoryItem('sauce_chocolat', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('brownie') .. ' ~w~!')
                    xPlayer.removeInventoryItem('boule_vanille', 1)
                    xPlayer.removeInventoryItem('boule_chocolat', 1)
                    xPlayer.removeInventoryItem('sauce_chocolat', 1)
                    xPlayer.addInventoryItem('brownie', 1)
                end
            end

        end)
    end
	
													if _itemValue == 'pancakes' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('milk').count
            local bethQuantity      = xPlayer.getInventoryItem('farine').count
            local gimelQuantity     = xPlayer.getInventoryItem('oeuf').count
			local daletQuantity      = xPlayer.getInventoryItem('sauce_chocolat').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('milk') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('farine') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('oeuf') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('sauce_chocolat') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('milk', 1)
                    xPlayer.removeInventoryItem('farine', 1)
                    xPlayer.removeInventoryItem('oeuf', 1)
					xPlayer.removeInventoryItem('sauce_chocolat', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('pancakes') .. ' ~w~!')
                    xPlayer.removeInventoryItem('milk', 1)
                    xPlayer.removeInventoryItem('farine', 1)
                    xPlayer.removeInventoryItem('oeuf', 1)
					xPlayer.removeInventoryItem('sauce_chocolat', 1)
                    xPlayer.addInventoryItem('pancakes', 1)
                end
            end

        end)
    end
	
														if _itemValue == 'churros' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('milk').count
            local bethQuantity      = xPlayer.getInventoryItem('farine').count
            local gimelQuantity     = xPlayer.getInventoryItem('oeuf').count
			local daletQuantity      = xPlayer.getInventoryItem('sauce_chocolat').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('milk') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('farine') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('oeuf') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('sauce_chocolat') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('milk', 1)
                    xPlayer.removeInventoryItem('farine', 1)
                    xPlayer.removeInventoryItem('oeuf', 1)
					xPlayer.removeInventoryItem('sauce_chocolat', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('churros') .. ' ~w~!')
                    xPlayer.removeInventoryItem('milk', 1)
                    xPlayer.removeInventoryItem('farine', 1)
                    xPlayer.removeInventoryItem('oeuf', 1)
					xPlayer.removeInventoryItem('sauce_chocolat', 1)
                    xPlayer.addInventoryItem('churros', 1)
                end
            end

        end)
    end
	
							    if _itemValue == 'tutti_frutti' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('fuits').count
            local bethQuantity      = xPlayer.getInventoryItem('chantilly').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('fuits') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('chantilly') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('fuits', 1)
                    xPlayer.removeInventoryItem('chantilly', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('tutti_frutti') .. ' ~w~!')
                    xPlayer.removeInventoryItem('fuits', 1)
                    xPlayer.removeInventoryItem('chantilly', 1)
                    xPlayer.addInventoryItem('tutti_frutti', 1)
                end
            end

        end)
    end
	
															if _itemValue == 'cheesecake' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('fromage').count
            local bethQuantity      = xPlayer.getInventoryItem('boule_chocolat').count
            local gimelQuantity     = xPlayer.getInventoryItem('fruits').count
			local daletQuantity      = xPlayer.getInventoryItem('chantilly').count
			
            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('fromage') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('boule_chocolat') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('fruits') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('chantilly') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('boule_chocolat', 1)
                    xPlayer.removeInventoryItem('fruits', 1)
					xPlayer.removeInventoryItem('chantilly', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('cheesecake') .. ' ~w~!')
                    xPlayer.removeInventoryItem('fromage', 1)
                    xPlayer.removeInventoryItem('boule_chocolat', 1)
                    xPlayer.removeInventoryItem('fruits', 1)
					xPlayer.removeInventoryItem('chantilly', 1)
                    xPlayer.addInventoryItem('cheesecake', 1)
                end
            end

        end)
    end
	
end)

-------------------------------------------*
RegisterServerEvent('esx_foodtruck:removeItem')
AddEventHandler('esx_foodtruck:removeItem', function(item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem(item, count)
end)

RegisterServerEvent('esx_foodtruck:addItem')
AddEventHandler('esx_foodtruck:addItem', function(item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addInventoryItem(item, count)
end)

RegisterServerEvent('esx_foodtruck:getItem')
AddEventHandler('esx_foodtruck:getItem', function( type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
 
  if type == 'item_standard' then
	local sourceItem = xPlayer.getInventoryItem(item)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_foodtruck',  function(inventory)

      local roomItemCount = inventory.getItem(item)
	  
	  if count > 0 and roomItemCount.count >= count then	  

		if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
			TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez ~y~de place~s~ dans votre inventaire!')
		else
				
			inventory.removeItem(item, count)
			xPlayer.addInventoryItem(item, count)
			--TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
				end
      else
        TriggerClientEvent('esx:showNotification', _source, 'Il n\'a pas assez de ~r~cet objet~s~ dans votre coffre!')
      end

    end)

  end

  if type == 'item_account' then

    TriggerEvent('esx_addonaccount:getSharedAccount', 'foodtruck_black_money',  function(account)

      local roomAccountMoney = account.money

      if roomAccountMoney >= count then
        account.removeMoney(count)
        xPlayer.addAccountMoney(item, count)
      else
        TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
      end

    end)

  end

end)

RegisterServerEvent('esx_foodtruck:putItem')
AddEventHandler('esx_foodtruck:putItem', function( type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
 -- local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

  if type == 'item_standard' then

    local playerItemCount = xPlayer.getInventoryItem(item).count

    if playerItemCount >= count then

      xPlayer.removeInventoryItem(item, count)

      TriggerEvent('esx_addoninventory:getSharedInventory', 'society_foodtruck', function(inventory)
        inventory.addItem(item, count)
      end)

    else
      TriggerClientEvent('esx:showNotification', _source, _U('invalid_quantity'))
    end
--TriggerClientEvent('esx:showNotification', _source, _U('you_added') .. count .. ' ' .. item.label)
  end

  if type == 'item_account' then

    local playerAccountMoney = xPlayer.getAccount(item).money

    if playerAccountMoney >= count then

      xPlayer.removeAccountMoney(item, count)

      TriggerEvent('esx_addonaccount:getSharedAccount', 'foodtruck_black_money',  function(account)
        account.addMoney(count)
      end)

    else
      TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
    end

  end

 

end)



ESX.RegisterServerCallback('esx_foodtruck:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local blackMoney = xPlayer.getAccount('black_money').money
  local items      = xPlayer.inventory

  cb({
	 blackMoney = blackMoney,
	 items      = items
  })

end)

ESX.RegisterServerCallback('esx_foodtruck:getFoodtruckInventory', function(source, cb)

  local blackMoney = 0
  local items      = {}
  local weapons    = {}

  TriggerEvent('esx_addonaccount:getSharedAccount', 'foodtruck_black_money',  function(account)
    blackMoney = account.money
  end)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_foodtruck',  function(inventory)
    items = inventory.items
  end)

  cb({
    blackMoney = blackMoney,
    items      = items,
    weapons    = weapons
  })

end)

---------------------------- register usable item --------------------------------------------------
--ESX.RegisterUsableItem('cola', function(source)
--	local xPlayer = ESX.GetPlayerFromId(source)
--	xPlayer.removeInventoryItem('cola', 1)
--	TriggerClientEvent('esx_status:add', source, 'thirst', 300000)
--	TriggerClientEvent('esx_basicneeds:onDrink', source, 'prop_ecola_can')
--   TriggerClientEvent('esx:showNotification', source, _U('drank_coke'))
--end)


