ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local selling = false
	local success = false
	local copscalled = false
	local notintrested = false

  RegisterNetEvent('drugs:trigger')
  AddEventHandler('drugs:trigger', function()
	selling = true
	    if selling == true then
			TriggerEvent('pass_or_fail')
  			TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 1)
  			TriggerClientEvent("pNotify:SendNotification", source, {
            text = "Essaye de convaincre le client",
            type = "error",
            queue = "lmao",
            timeout = 2500,
            layout = "Centerleft"
        	})
 	end
end)

RegisterServerEvent('fetchjob')
AddEventHandler('fetchjob', function()
    local xPlayer  = ESX.GetPlayerFromId(source)
    TriggerClientEvent('getjob', source, xPlayer.job.name)
end)


  RegisterNetEvent('drugs:sell')
  AddEventHandler('drugs:sell', function()
  	local xPlayer = ESX.GetPlayerFromId(source)
	local meth = xPlayer.getInventoryItem('meth_pooch').count
	local coke = xPlayer.getInventoryItem('ceok_pooch').count
	local crack = xPlayer.getInventoryItem('crack_pooch').count
	local keta = xPlayer.getInventoryItem('ketamine_pooch').count
	local ecsta = xPlayer.getInventoryItem('ecstasy_pooch').count
	local opi = xPlayer.getInventoryItem('opium_pooch').count
	local weed = xPlayer.getInventoryItem('weed').count
	local paymentc = math.random (500,1000)
	local paymenth = math.random (150,300)
	local paymentm = math.random (300,700)
	local paymentl = math.random (150,300)


		if coke >= 1 and success == true then
			 	TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Vous avez vendu de la cocaine pour $" .. paymentc ,
					type = "success",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "CenterLeft"
			})
			TriggerClientEvent("animation", source)
			xPlayer.removeInventoryItem('coke_pooch', 1)
  			xPlayer.addAccountMoney('black_money', paymentc)
  			selling = false
  		elseif crack >= 1 and success == true then
  				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Vous avez vendu du crack pour $" .. paymenth ,
					type = "success",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "CenterLeft"
			})
			TriggerClientEvent("animation", source)
			TriggerClientEvent("test", source)
  			xPlayer.removeInventoryItem('crack_pooch', 1)
  			xPlayer.addAccountMoney('black_money', paymenth)
			  selling = false
		elseif weed >= 1 and success == true then
				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
			  	TriggerClientEvent("pNotify:SendNotification", source, {
				  text = "Vous avez vendu de la weed pour $" .. paymentl,
				  type = "success",
				  progressBar = false,
				  queue = "lmao",
				  timeout = 2000,
				  layout = "CenterLeft"
		 	})
		 	TriggerClientEvent("animation", source)
		  	TriggerClientEvent("test", source)
			xPlayer.removeInventoryItem('weed', 1)
			xPlayer.addAccountMoney('black_money', paymentl)
				selling = false
  		elseif meth >= 1 and success == true then
  				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Vous avez vendu de la meth pour $" .. paymentm ,
					type = "success",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "CenterLeft"
			})
			TriggerClientEvent("animation", source)
  			xPlayer.removeInventoryItem('meth_pooch', 1)
  			xPlayer.addAccountMoney('black_money', paymentm)
  			selling = false
  		elseif keta >= 1 and success == true then
  				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Vous avez vendu de la kétamine pour $" .. paymentl ,
					type = "success",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "CenterLeft"
			})
			TriggerClientEvent("animation", source)
			xPlayer.removeInventoryItem('ketamine_pooch', 1)
  			xPlayer.addAccountMoney('black_money', paymentl)
			selling = false
		elseif ecsta >= 1 and success == true then
				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
				text = "Vous avez vendu de l'ecstasie pour $" .. paymentl ,
				type = "success",
				progressBar = false,
				queue = "lmao",
				timeout = 2000,
				layout = "CenterLeft"
			})
			TriggerClientEvent("animation", source)
			xPlayer.removeInventoryItem('ecstasy_pooch', 1)
			xPlayer.addAccountMoney('black_money', paymentl)
			selling = false  
		elseif opi >= 1 and success == true then
			TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
			TriggerClientEvent("pNotify:SendNotification", source, {
			text = "Vous avez vendu de l'opium pour $" .. paymentl ,
			type = "success",
			progressBar = false,
			queue = "lmao",
			timeout = 2000,
			layout = "CenterLeft"
			})
			TriggerClientEvent("animation", source)
			xPlayer.removeInventoryItem('opium_pooch', 1)
			xPlayer.addAccountMoney('black_money', paymentl)
			selling = false  
		elseif selling == true and success == false and notintrested == true then
				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Pas intéressé",
					type = "error",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "CenterLeft"
			})
  			selling = false
  		elseif meth < 1 and coke < 1 and crack < 1 and keta < 1 and ecsta < 1 and opi < 1 and weed < 1 then
				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
				text = "Vous n avez pas de drogue",
				type = "error",
				progressBar = false,
				queue = "lmao",
				timeout = 2000,
				layout = "CenterLeft"
			})
		elseif copscalled == true and success == false then
  				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Ils ont appelé la police",
					type = "error",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "CenterLeft"
			})
			TriggerClientEvent("notifyc", source)
  			selling = false
  		end
end)

RegisterNetEvent('pass_or_fail')
AddEventHandler('pass_or_fail', function()

  		local percent = math.random(1, 11)

  		if percent == 7 or percent == 8 or percent == 9 then
  			success = false
  			notintrested = true
  		elseif percent ~= 8 and percent ~= 9 and percent ~= 10 and percent ~= 7 then
  			success = true
  			notintrested = false
  		else
  			notintrested = false
  			success = false
  			copscalled = true
  		end
end)

RegisterNetEvent('sell_dis')
AddEventHandler('sell_dis', function()
		TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
		TriggerClientEvent("pNotify:SendNotification", source, {
		text = "Vous etes partit trop loin",
		type = "error",
		progressBar = false,
		queue = "lmao",
		timeout = 2000,
		layout = "CenterLeft"
	})
end)

RegisterNetEvent('checkD')
AddEventHandler('checkD', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local meth = xPlayer.getInventoryItem('meth_pooch').count
	local coke 	  = xPlayer.getInventoryItem('coke_pooch').count
	local crack = xPlayer.getInventoryItem('crack_pooch').count
	local keta = xPlayer.getInventoryItem('ketamine_pooch').count
	local ecsta = xPlayer.getInventoryItem('ecstasy_pooch').count
	local opi = xPlayer.getInventoryItem('opium_pooch').count
	local weed = xPlayer.getInventoryItem('weed').count

	if meth >= 1 or coke >= 1 or crack >= 1 or keta >= 1 or ecsta >= 1 or opi >= 1 or weed >= 1 then
		TriggerClientEvent("checkR", source, true)
	else
		TriggerClientEvent("checkR", source, false)
	end

end)
