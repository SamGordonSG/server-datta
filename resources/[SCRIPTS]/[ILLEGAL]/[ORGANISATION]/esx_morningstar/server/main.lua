-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'morningstar', Config.MaxInService)
end

TriggerEvent('esx_organisation:registerOrganisation', 'morningstar', 'Morningstar', 'organisation_morningstar', 'organisation_morningstar', 'organisation_morningstar', {type = 'public'})

RegisterServerEvent('esx_morningstar:giveWeapon')
AddEventHandler('esx_morningstar:giveWeapon', function(weapon, ammo)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addWeapon(weapon, ammo)
end)

RegisterServerEvent('esx_morningstar:handcuff')
AddEventHandler('esx_morningstar:handcuff', function(target)
  TriggerClientEvent('esx_morningstar:handcuff', target)
end)

RegisterServerEvent('esx_morningstar:drag')
AddEventHandler('esx_morningstar:drag', function(target)
  local _source = source
  TriggerClientEvent('esx_morningstar:drag', target, _source)
end)

RegisterServerEvent('esx_morningstar:putInVehicle')
AddEventHandler('esx_morningstar:putInVehicle', function(target)
  TriggerClientEvent('esx_morningstar:putInVehicle', target)
end)

RegisterServerEvent('esx_morningstar:OutVehicle')
AddEventHandler('esx_morningstar:OutVehicle', function(target)
    TriggerClientEvent('esx_morningstar:OutVehicle', target)
end)

RegisterServerEvent('esx_morningstar:getItem')
AddEventHandler('esx_morningstar:getItem', function( type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
 
  if type == 'item_standard' then

    TriggerEvent('esx_addoninventory:getSharedInventory', 'organisation_morningstar',  function(inventory)

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

    TriggerEvent('esx_addonaccount:getSharedAccount', 'morningstar_black_money',  function(account)

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

RegisterServerEvent('esx_morningstar:getItem2')
AddEventHandler('esx_morningstar:getItem2', function( type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
 
  if type == 'item_standard' then

    TriggerEvent('esx_addoninventory:getSharedInventory', 'organisation_morningboss',  function(inventory)

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

    TriggerEvent('esx_addonaccount:getSharedAccount', 'morningstar_black_money',  function(account)

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

RegisterServerEvent('esx_morningstar:putItem')
AddEventHandler('esx_morningstar:putItem', function( type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
 -- local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

  if type == 'item_standard' then

    local playerItemCount = xPlayer.getInventoryItem(item).count

    if playerItemCount >= count then

      xPlayer.removeInventoryItem(item, count)

      TriggerEvent('esx_addoninventory:getSharedInventory', 'organisation_morningstar', function(inventory)
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

      TriggerEvent('esx_addonaccount:getSharedAccount', 'morningstar_black_money',  function(account)
        account.addMoney(count)
      end)

    else
      TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
    end

  end

 

end)

RegisterServerEvent('esx_morningstar:putItem2')
AddEventHandler('esx_morningstar:putItem2', function( type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
 
  if type == 'item_standard' then

    local playerItemCount = xPlayer.getInventoryItem(item).count

    if playerItemCount >= count then

      xPlayer.removeInventoryItem(item, count)

      TriggerEvent('esx_addoninventory:getSharedInventory', 'organisation_morningboss', function(inventory)
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

      TriggerEvent('esx_addonaccount:getSharedAccount', 'morningstar_black_money',  function(account)
        account.addMoney(count)
      end)

    else
      TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
    end

  end

 

end)

ESX.RegisterServerCallback('esx_morningstar:getOtherPlayerData', function(source, cb, target)

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

ESX.RegisterServerCallback('esx_morningstar:getVehicleInfos', function(source, cb, plate)

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

ESX.RegisterServerCallback('esx_morningstar:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'organisation_morningstar', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)

	end)

end)

ESX.RegisterServerCallback('esx_morningstar:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'organisation_morningboss', function(store)

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

ESX.RegisterServerCallback('esx_morningstar:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'organisation_morningstar', function(store)

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


ESX.RegisterServerCallback('esx_morningstar:getArmoryWeapons2', function(source, cb)

  TriggerEvent('esx_datastore:getSharedDataStore', 'organisation_morningboss', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('esx_morningstar:addArmoryWeapon2', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.removeWeapon(weaponName)

  TriggerEvent('esx_datastore:getSharedDataStore', 'organisation_morningboss', function(store)

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

ESX.RegisterServerCallback('esx_morningstar:removeArmoryWeapon2', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addWeapon(weaponName, 1000)

  TriggerEvent('esx_datastore:getSharedDataStore', 'organisation_morningboss', function(store)

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



ESX.RegisterServerCallback('esx_morningstar:getPlayerInventory', function(source, cb)

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


ESX.RegisterServerCallback('esx_morningstar:getOrganisationInventory', function(source, cb)

  local blackMoney = 0
  local items      = {}
  local weapons    = {}

  TriggerEvent('esx_addonaccount:getSharedAccount', 'morningstar_black_money',  function(account)
    blackMoney = account.money
  end)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'organisation_morningstar',  function(inventory)
    items = inventory.items
  end)

  cb({
    blackMoney = blackMoney,
    items      = items,
    weapons    = weapons
  })

end)
-------------------
ESX.RegisterServerCallback('esx_morningstar:getOrganisationInventory2', function(source, cb)

  local blackMoney = 0
  local items      = {}
  local weapons    = {}

  TriggerEvent('esx_addonaccount:getSharedAccount', 'morningstar_black_money',  function(account)
    blackMoney = account.money
  end)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'organisation_morningboss',  function(inventory)
    items = inventory.items
  end)

  cb({
    blackMoney = blackMoney,
    items      = items,
    weapons    = weapons
  })

end)
-------------------
ESX.RegisterServerCallback('esx_morningstar:buy', function(source, cb, amount)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'organisation_morningstar', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)

end)
