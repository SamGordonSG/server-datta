-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'shadows', Config.MaxInService)
end

TriggerEvent('esx_organisation:registerOrganisation', 'shadows', 'shadows', 'organisation_shadows', 'organisation_shadows', 'organisation_shadows', {type = 'public'})

RegisterServerEvent('esx_shadows:giveWeapon')
AddEventHandler('esx_shadows:giveWeapon', function(weapon, ammo)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addWeapon(weapon, ammo)
end)

RegisterServerEvent('esx_shadows:handcuff')
AddEventHandler('esx_shadows:handcuff', function(target)
  TriggerClientEvent('esx_shadows:handcuff', target)
end)

RegisterServerEvent('esx_shadows:drag')
AddEventHandler('esx_shadows:drag', function(target)
  local _source = source
  TriggerClientEvent('esx_shadows:drag', target, _source)
end)

RegisterServerEvent('esx_shadows:putInVehicle')
AddEventHandler('esx_shadows:putInVehicle', function(target)
  TriggerClientEvent('esx_shadows:putInVehicle', target)
end)

RegisterServerEvent('esx_shadows:OutVehicle')
AddEventHandler('esx_shadows:OutVehicle', function(target)
    TriggerClientEvent('esx_shadows:OutVehicle', target)
end)

RegisterServerEvent('esx_shadows:getItem')
AddEventHandler('esx_shadows:getItem', function( type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
 
  if type == 'item_standard' then

    TriggerEvent('esx_addoninventory:getSharedInventory', 'organisation_shadows',  function(inventory)

      local roomItemCount = inventory.getItem(item).count

      if roomItemCount >= count then
        inventory.removeItem(item, count)
        xPlayer.addInventoryItem(item, count)
      else
        TriggerClientEvent('esx:showNotification', _source, _U('invalid_quantity'))
      end

    end)

  end

  if type == 'item_account' then

    TriggerEvent('esx_addonaccount:getSharedAccount', 'shadows_black_money',  function(account)

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

RegisterServerEvent('esx_shadows:getItem2')
AddEventHandler('esx_shadows:getItem2', function( type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
 
  if type == 'item_standard' then

    TriggerEvent('esx_addoninventory:getSharedInventory', 'organisation_shadowsboss',  function(inventory)

      local roomItemCount = inventory.getItem(item).count

      if roomItemCount >= count then
        inventory.removeItem(item, count)
        xPlayer.addInventoryItem(item, count)
      else
        TriggerClientEvent('esx:showNotification', _source, _U('invalid_quantity'))
      end

    end)

  end

  if type == 'item_account' then

    TriggerEvent('esx_addonaccount:getSharedAccount', 'shadows_black_money',  function(account)

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

RegisterServerEvent('esx_shadows:putItem')
AddEventHandler('esx_shadows:putItem', function( type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
 -- local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

  if type == 'item_standard' then

    local playerItemCount = xPlayer.getInventoryItem(item).count

    if playerItemCount >= count then

      xPlayer.removeInventoryItem(item, count)

      TriggerEvent('esx_addoninventory:getSharedInventory', 'organisation_shadows', function(inventory)
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

      TriggerEvent('esx_addonaccount:getSharedAccount', 'shadows_black_money',  function(account)
        account.addMoney(count)
      end)

    else
      TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
    end

  end

 

end)

RegisterServerEvent('esx_shadows:putItem2')
AddEventHandler('esx_shadows:putItem2', function( type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
 
  if type == 'item_standard' then

    local playerItemCount = xPlayer.getInventoryItem(item).count

    if playerItemCount >= count then

      xPlayer.removeInventoryItem(item, count)

      TriggerEvent('esx_addoninventory:getSharedInventory', 'organisation_shadowsboss', function(inventory)
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

      TriggerEvent('esx_addonaccount:getSharedAccount', 'shadows_black_money',  function(account)
        account.addMoney(count)
      end)

    else
      TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
    end

  end

 

end)

ESX.RegisterServerCallback('esx_shadows:getOtherPlayerData', function(source, cb, target)

	if Config.EnableESXIdentity then

		local xPlayer = ESX.GetPlayerFromId(target)

		local identifier = GetPlayerIdentifiers(target)[1]

		local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
			['@identifier'] = identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local height    = result[1].height

		local data = {
			name      = GetPlayerName(target),
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end

	else

		local xPlayer = ESX.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)

	end

end)

ESX.RegisterServerCallback('esx_shadows:getVehicleInfos', function(source, cb, plate)

  if Config.EnableESXIdentity then

    MySQL.Async.fetchAll(
      'SELECT * FROM owned_vehicles',
      {},
      function(result)

        local foundIdentifier = nil

        for i=1, #result, 1 do

          local vehicleData = json.decode(result[i].vehicle)

          if vehicleData.plate == plate then
            foundIdentifier = result[i].owner
            break
          end

        end

        if foundIdentifier ~= nil then

          MySQL.Async.fetchAll(
            'SELECT * FROM users WHERE identifier = @identifier',
            {
              ['@identifier'] = foundIdentifier
            },
            function(result)

              local ownerName = result[1].firstname .. " " .. result[1].lastname

              local infos = {
                plate = plate,
                owner = ownerName
              }

              cb(infos)

            end
          )

        else

          local infos = {
          plate = plate
          }

          cb(infos)

        end

      end
    )

  else

    MySQL.Async.fetchAll(
      'SELECT * FROM owned_vehicles',
      {},
      function(result)

        local foundIdentifier = nil

        for i=1, #result, 1 do

          local vehicleData = json.decode(result[i].vehicle)

          if vehicleData.plate == plate then
            foundIdentifier = result[i].owner
            break
          end

        end

        if foundIdentifier ~= nil then

          MySQL.Async.fetchAll(
            'SELECT * FROM users WHERE identifier = @identifier',
            {
              ['@identifier'] = foundIdentifier
            },
            function(result)

              local infos = {
                plate = plate,
                owner = result[1].name
              }

              cb(infos)

            end
          )

        else

          local infos = {
          plate = plate
          }

          cb(infos)

        end

      end
    )

  end

end)

ESX.RegisterServerCallback('esx_shadows:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'organisation_shadows', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)

	end)

end)

ESX.RegisterServerCallback('esx_shadows:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'organisation_shadows', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
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

ESX.RegisterServerCallback('esx_shadows:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'organisation_shadows', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
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


ESX.RegisterServerCallback('esx_shadows:getArmoryWeapons2', function(source, cb)

  TriggerEvent('esx_datastore:getSharedDataStore', 'organisation_shadowsboss', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('esx_shadows:addArmoryWeapon2', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.removeWeapon(weaponName)

  TriggerEvent('esx_datastore:getSharedDataStore', 'organisation_shadowsboss', function(store)

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

ESX.RegisterServerCallback('esx_shadows:removeArmoryWeapon2', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addWeapon(weaponName, 1000)

  TriggerEvent('esx_datastore:getSharedDataStore', 'organisation_shadowsboss', function(store)

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



ESX.RegisterServerCallback('esx_shadows:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local blackMoney = xPlayer.getAccount('black_money').money
  local items      = xPlayer.inventory

  cb({
	 blackMoney = blackMoney,
	 items      = items
  })

end)

-------------------

-------------------


ESX.RegisterServerCallback('esx_shadows:getOrganisationInventory', function(source, cb)

  local blackMoney = 0
  local items      = {}
  local weapons    = {}

  TriggerEvent('esx_addonaccount:getSharedAccount', 'shadows_black_money',  function(account)
    blackMoney = account.money
  end)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'organisation_shadows',  function(inventory)
    items = inventory.items
  end)

  cb({
    blackMoney = blackMoney,
    items      = items,
    weapons    = weapons
  })

end)
-------------------
ESX.RegisterServerCallback('esx_shadows:getOrganisationInventory2', function(source, cb)

  local blackMoney = 0
  local items      = {}
  local weapons    = {}

  TriggerEvent('esx_addonaccount:getSharedAccount', 'shadows_black_money',  function(account)
    blackMoney = account.money
  end)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'organisation_shadowsboss',  function(inventory)
    items = inventory.items
  end)

  cb({
    blackMoney = blackMoney,
    items      = items,
    weapons    = weapons
  })

end)
-------------------
ESX.RegisterServerCallback('esx_shadows:buy', function(source, cb, amount)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'organisation_shadows', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)

end)
