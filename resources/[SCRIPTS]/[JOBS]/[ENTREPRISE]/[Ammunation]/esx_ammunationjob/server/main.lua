ESX                = nil
PlayersHarvesting  = {}
PlayersHarvesting2 = {}
PlayersHarvesting3 = {}


PlayersVenteMunition = {}
PlayersTransformingMunition  = {}
PlayersHarvestingMunition = {}
PlayersHarvestingMunition2 = {}

PlayersCrafting    = {}
PlayersCrafting2   = {}
PlayersCrafting3   = {}
PlayersCrafting4   = {}
PlayersCrafting5   = {}
PlayersCrafting6   = {}
PlayersCrafting7   = {}
PlayersCrafting8   = {}
PlayersCrafting9   = {}
PlayersCrafting10   = {}
PlayersCrafting11   = {}
PlayersCrafting12   = {}
PlayersCrafting13   = {}
PlayersCrafting14   = {}
PlayersCrafting15   = {}
PlayersCrafting16   = {}
PlayersCrafting17   = {}
PlayersCrafting18   = {}
PlayersCrafting19   = {}
PlayersCrafting20   = {}
PlayersCrafting21   = {}
PlayersCrafting22   = {}

local societyAccount = nil

TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
	societyAccount = account
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'ammunation', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'ammunation', _U('ammunation_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'ammunation', 'Ammunation', 'society_ammunation', 'society_ammunation', 'society_ammunation', {type = 'private'})

ESX.RegisterServerCallback('esx_ammunationjob:getArmoryWeapons', function(source, cb)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_ammunation', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('esx_ammunationjob:addArmoryWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.removeWeapon(weaponName)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_ammunation', function(store)

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

ESX.RegisterServerCallback('esx_ammunationjob:removeArmoryWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addWeapon(weaponName, 0)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_ammunation', function(store)

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

RegisterServerEvent('esx_ammunationjob:giveWeapon')
AddEventHandler('esx_ammunationjob:giveWeapon', function(weapon, ammo)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addWeapon(weapon, ammo)
end)

RegisterServerEvent('esx_ammunationjob:givelicence')
AddEventHandler('esx_ammunationjob:givelicence', function(playerId, tier)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do

		local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer2.source == playerId then
	
				TriggerEvent('esx_license:addLicense', xPlayer2.source, 'weapon', function ()
				  LoadLicenses(xPlayer2.source)
				end)
				TriggerClientEvent('esx:showNotification', source, 'Vous avez donné un permis de port d\'arme')

			break
		end
	end
end)

function LoadLicenses (source)
  TriggerEvent('esx_license:getLicenses', source, function (licenses)
    TriggerClientEvent('esx_weashop:loadLicenses', source, licenses)
  end)
end

-------------- Récupération carbone -------------
local function Harvest(source)

  SetTimeout(4000, function()

    if PlayersHarvesting[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarbonQuantity = xPlayer.getInventoryItem('carbon').count

      if CarbonQuantity >= 250 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
        xPlayer.addInventoryItem('carbon', 10)
        Harvest(source)
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startHarvest')
AddEventHandler('esx_ammunationjob:startHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Récupération de ~b~carbone~s~...')
  Harvest(source)
end)

RegisterServerEvent('esx_ammunationjob:stopHarvest')
AddEventHandler('esx_ammunationjob:stopHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = false
end)
------------ Récupération acier --------------
local function Harvest2(source)

  SetTimeout(8000, function()

    if PlayersHarvesting2[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local AcierQuantity  = xPlayer.getInventoryItem('acier').count
      if AcierQuantity >= 250 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
                xPlayer.addInventoryItem('acier', 10)

        Harvest2(source)
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startHarvest2')
AddEventHandler('esx_ammunationjob:startHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Récupération d\'~b~acier~s~...')
  Harvest2(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopHarvest2')
AddEventHandler('esx_ammunationjob:stopHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = false
end)

--- farm munition 
-- poudre
local function HarvestMunition(source)
	if PlayersHarvestingMunition[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
			local itemQuantity = xPlayer.getInventoryItem('poudre').count
			if itemQuantity >= 250 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(1800, function()
					xPlayer.addInventoryItem('poudre', 10)
					HarvestMunition(source)
				end)
			end
	end
end

RegisterServerEvent('esx_ammunationjob:startHarvestMunition')
AddEventHandler('esx_ammunationjob:startHarvestMunition', function()
	local _source = source
  	
	if PlayersHarvestingMunition[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvestingMunition[_source]=false
	else
		PlayersHarvestingMunition[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('poudre_taken'))  
		HarvestMunition(_source)
	end
end)


RegisterServerEvent('esx_ammunationjob:stopHarvestMunition')
AddEventHandler('esx_ammunationjob:stopHarvestMunition', function()
	local _source = source
	
	if PlayersHarvestingMunition[_source] == true then
		PlayersHarvestingMunition[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~réceptionner')
		PlayersHarvestingMunition[_source]=true
	end
end)

--douille
local function HarvestMunition2(source)
	if PlayersHarvestingMunition2[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
			local itemQuantity = xPlayer.getInventoryItem('douille').count
			if itemQuantity >= 250 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(1800, function()
					xPlayer.addInventoryItem('douille', 10)
					HarvestMunition2(source)
				end)
			end
	end
end

RegisterServerEvent('esx_ammunationjob:startHarvestMunition2')
AddEventHandler('esx_ammunationjob:startHarvestMunition2', function()
	local _source = source
  	
	if PlayersHarvestingMunition2[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvestingMunition2[_source]=false
	else
		PlayersHarvestingMunition2[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('douille_taken'))  
		HarvestMunition2(_source)
	end
end)


RegisterServerEvent('esx_ammunationjob:stopHarvestMunition2')
AddEventHandler('esx_ammunationjob:stopHarvestMunition2', function()
	local _source = source
	
	if PlayersHarvestingMunition2[_source] == true then
		PlayersHarvestingMunition2[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~réceptionner')
		PlayersHarvestingMunition2[_source]=true
	end
end)

--Fabrication clip
local function TransformMunition(source)

	if PlayersTransformingMunition[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
			local poudreQuantity = xPlayer.getInventoryItem('poudre').count
			local douilleQuantity = xPlayer.getInventoryItem('douille').count
			
			if poudreQuantity < 30 or douilleQuantity < 30 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_matos'))
				return
			else
				SetTimeout(1800, function()
					xPlayer.removeInventoryItem('poudre', 10)
					xPlayer.removeInventoryItem('douille', 10)
					xPlayer.addInventoryItem('clip', 1)
					TriggerClientEvent('esx:showNotification', source, 'Vous avez assemblé des balles et les avez conditionné dans un chargeur')
					TransformMunition(source)
				end)
			end
	end	
end

RegisterServerEvent('esx_ammunationjob:startTransformMunition')
AddEventHandler('esx_ammunationjob:startTransformMunition', function()
	local _source = source
  	
	if PlayersTransformingMunition[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersTransformingMunition[_source]=false
	else
		PlayersTransformingMunition[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
		TransformMunition(_source)
	end
end)

RegisterServerEvent('esx_ammunationjob:stopTransformMunition')
AddEventHandler('esx_ammunationjob:stopTransformMunition', function()

	local _source = source
	
	if PlayersTransformingMunition[_source] == true then
		PlayersTransformingMunition[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~fabriquer et conditionner des munitions')
		PlayersTransformingMunition[_source]=true
		
	end
end)

-- Vente munition

local function VenteMunition(source)

  SetTimeout(1800, function()

    if PlayersVenteMunition[source] == true then

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local Quantity = xPlayer.getInventoryItem('clip').count

    if Quantity < 1 then
      TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez plus de chargeur à vendre.')
      PlayersVenteMunition[_source] = false
	  
    else
	  local argent = math.random(30,30)
	  local money = math.random(30,30)
      xPlayer.removeInventoryItem('clip', 1)
		local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addMoney(argent/2)
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. argent)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
      VenteMunition(_source)
    end
  end
end)
end

RegisterServerEvent('esx_ammunationjob:startVenteMunition')
AddEventHandler('esx_ammunationjob:startVenteMunition', function()

local _source = source

if PlayersVenteMunition[_source] == false then
  TriggerClientEvent('esx:showNotification', _source, '~r~Sortez et revenez dans la zone !')
  PlayersVenteMunition[_source] = false
else
  PlayersVenteMunition[_source] = true
  TriggerClientEvent('esx:showNotification', _source, '~g~Action ~w~en cours...')
  VenteMunition(_source)
end
end)

RegisterServerEvent('esx_ammunationjob:stopVenteMunition')
AddEventHandler('esx_ammunationjob:stopVenteMunition', function()

local _source = source

if PlayersVenteMunition[_source] == true then
  PlayersVenteMunition[_source] = false
else
  PlayersVenteMunition[_source] = true
end
end)


------------ Craft Pistolet -------------------
local function CraftPistolet(source)

  SetTimeout(15000, function()

    if PlayersCrafting[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_pistol
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true		
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end
	  
	  if CarboneQuantity < 5 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 4 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and clip and societymoney then
        xPlayer.removeInventoryItem('carbon', 5)
		xPlayer.removeInventoryItem('acier', 4)
		xPlayer.addWeapon('WEAPON_PISTOL', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftPistol')
AddEventHandler('esx_ammunationjob:startCraftPistol', function()
  local _source = source
  PlayersCrafting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Pistolet~s~...')
  CraftPistolet(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftPistol')
AddEventHandler('esx_ammunationjob:stopCraftPistol', function()
  local _source = source
  PlayersCrafting[_source] = false
end)

------------ Craft Pistolet de combat -------------------
local function CraftCombatPistol(source)

  SetTimeout(15000, function()

    if PlayersCrafting2[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_combatpistol
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 5 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 6 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 5)
		xPlayer.removeInventoryItem('acier', 6)
		xPlayer.addWeapon('WEAPON_COMBATPISTOL', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftCombatPistol')
AddEventHandler('esx_ammunationjob:startCraftCombatPistol', function()
  local _source = source
  PlayersCrafting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Pistolet de combat~s~...')
  CraftCombatPistol(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftCombatPistol')
AddEventHandler('esx_ammunationjob:stopCraftCombatPistol', function()
  local _source = source
  PlayersCrafting2[_source] = false
end)

------------ Craft Pétoire -------------------
local function CraftSnsPistol(source)

  SetTimeout(15000, function()

    if PlayersCrafting3[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_snspistol
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 4  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 3 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 4)
		xPlayer.removeInventoryItem('acier', 3)
		xPlayer.addWeapon('WEAPON_SNSPISTOL', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftSnsPistol')
AddEventHandler('esx_ammunationjob:startCraftSnsPistol', function()
  local _source = source
  PlayersCrafting3[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Pétoire~s~...')
  CraftSnsPistol(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftSnsPistol')
AddEventHandler('esx_ammunationjob:stopCraftSnsPistol', function()
  local _source = source
  PlayersCrafting3[_source] = false
end)

------------ Craft Pistolet MK2 -------------------
local function CraftHeavyPistolmk2(source)

  SetTimeout(15000, function()

    if PlayersCrafting4[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_pistol_mk2
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true		
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')	
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 7  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 5 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 7)
		xPlayer.removeInventoryItem('acier', 5)
		xPlayer.addWeapon('WEAPON_PISTOL_MK2', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftPistolmk2')
AddEventHandler('esx_ammunationjob:startCraftPistolmk2', function()
  local _source = source
  PlayersCrafting4[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Pistolet MK2~s~...')
  CraftPistolmk2(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftPistolmk2')
AddEventHandler('esx_ammunationjob:stopCraftPistolmk2', function()
  local _source = source
  PlayersCrafting4[_source] = false
end)

------------ Craft Fusil Pompe -------------------
local function CraftPumpShotgun(source)

  SetTimeout(15000, function()

    if PlayersCrafting5[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_pumpshotgun
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)

	  if CarboneQuantity < 8  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 5 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 8)
		xPlayer.removeInventoryItem('acier', 5)
		xPlayer.addWeapon('WEAPON_PUMPSHOTGUN', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftPumpShotgun')
AddEventHandler('esx_ammunationjob:startCraftPumpShotgun', function()
  local _source = source
  PlayersCrafting5[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Fusil à pompe~s~...')
  CraftPumpShotgun(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftPumpShotgun')
AddEventHandler('esx_ammunationjob:stopCraftPumpshotgun', function()
  local _source = source
  PlayersCrafting5[_source] = false
end)


------------ Craft Mousquet -------------------
local function CraftMusket(source)

  SetTimeout(15000, function()

    if PlayersCrafting6[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_musket
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)

	  if CarboneQuantity < 7  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 9 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 7)
		xPlayer.removeInventoryItem('acier', 9)
		xPlayer.addWeapon('WEAPON_MUSKET', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftMusket')
AddEventHandler('esx_ammunationjob:startCraftMusket', function()
  local _source = source
  PlayersCrafting6[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Mousquet~s~...')
  CraftMusket(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftMusket')
AddEventHandler('esx_ammunationjob:stopCraftMusket', function()
  local _source = source
  PlayersCrafting6[_source] = false
end)

------------ Craft Tazer -------------------
local function CraftStungun(source)

  SetTimeout(15000, function()

    if PlayersCrafting7[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_stungun
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  if AcierQuantity < 3 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if acier and societymoney then
		xPlayer.removeInventoryItem('acier', 3)
		xPlayer.addWeapon('WEAPON_STUNGUN', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftStungun')
AddEventHandler('esx_ammunationjob:startCraftStungun', function()
  local _source = source
  PlayersCrafting7[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Tazer~s~...')
  CraftStungun(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftStungun')
AddEventHandler('esx_ammunationjob:stopCraftStungun', function()
  local _source = source
  PlayersCrafting7[_source] = false
end)

------------ Craft Pistolet Cal.50 -------------------
local function CraftPistol50(source)

  SetTimeout(15000, function()

    if PlayersCrafting8[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_pistol50
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 7  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 4 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 7)
		xPlayer.removeInventoryItem('acier', 4)
		xPlayer.addWeapon('WEAPON_PISTOL50', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftPistol50')
AddEventHandler('esx_ammunationjob:startCraftPistol50', function()
  local _source = source
  PlayersCrafting8[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Pistolet Cal.50~s~...')
  CraftPistol50(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftPistol50')
AddEventHandler('esx_ammunationjob:stopCraftPistol50', function()
  local _source = source
  PlayersCrafting8[_source] = false
end)

------------ Craft Pompe MK2 -------------------
local function CraftPumpShotgunmk2(source)

  SetTimeout(15000, function()

    if PlayersCrafting9[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_pumpshotgun_mk2
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 10  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 7 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 10)
		xPlayer.removeInventoryItem('acier', 7)
		xPlayer.addWeapon('WEAPON_PUMPSHOTGUN_MK2', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftPumpShotgunmk2')
AddEventHandler('esx_ammunationjob:startCraftPumpShotgunmk2', function()
  local _source = source
  PlayersCrafting9[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Pompe MK2~s~...')
  CraftPumpShotgunmk2(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftPumpShotgunmk2')
AddEventHandler('esx_ammunationjob:stopCraftPumpShotgunmk2', function()
  local _source = source
  PlayersCrafting9[_source] = false
end)

------------ Craft Carabine d'assaut -------------------
local function CraftCarbineRifle(source)

  SetTimeout(15000, function()

    if PlayersCrafting10[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_carbinerifle
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 40  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 11 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 40)
		xPlayer.removeInventoryItem('acier', 11)
		xPlayer.addWeapon('WEAPON_CARBINERIFLE', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftCarbineRifle')
AddEventHandler('esx_ammunationjob:startCraftCarbineRifle', function()
  local _source = source
  PlayersCrafting10[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Carabine d\'assaut~s~...')
  CraftCarbineRifle(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftCarbineRifle')
AddEventHandler('esx_ammunationjob:stopCraftCarbineRifle', function()
  local _source = source
  PlayersCrafting10[_source] = false
end)

------------ Craft Mitraillette d'assaut -------------------
local function CraftAssaultSmg(source)

  SetTimeout(15000, function()

    if PlayersCrafting11[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_assaultsmg
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 30  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 15 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 30)
		xPlayer.removeInventoryItem('acier', 15)
		xPlayer.addWeapon('WEAPON_ASSAULTSMG', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftAssaultSmg')
AddEventHandler('esx_ammunationjob:startCraftAssaultSmg', function()
  local _source = source
  PlayersCrafting11[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Mitraillette d\'assaut~s~...')
  CraftAssaultSmg(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftAssaultSmg')
AddEventHandler('esx_ammunationjob:stopCraftAssaultSmg', function()
  local _source = source
  PlayersCrafting11[_source] = false
end)

------------ Craft ADP de combat -------------------
local function CraftCombatPdw(source)

  SetTimeout(15000, function()

    if PlayersCrafting12[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_combatpdw
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')			
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 35  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 25 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 35)
		xPlayer.removeInventoryItem('acier', 20)
		xPlayer.addWeapon('WEAPON_COMBATPDW', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftCombatPdw')
AddEventHandler('esx_ammunationjob:startCraftCombatPdw', function()
  local _source = source
  PlayersCrafting12[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~ADP de combat~s~...')
  CraftCombatPdw(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftCombatPdw')
AddEventHandler('esx_ammunationjob:stopCraftCombatPdw', function()
  local _source = source
  PlayersCrafting12[_source] = false
end)

------------ Craft Bullpup Shotgun -------------------
local function CraftBullpupShotgun(source)

  SetTimeout(15000, function()

    if PlayersCrafting13[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_bullpupshotgun
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 35  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 15 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 35)
		xPlayer.removeInventoryItem('acier', 15)
		xPlayer.addWeapon('WEAPON_BULLPUPSHOTGUN', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftBullpupShotgun')
AddEventHandler('esx_ammunationjob:startCraftBullpupShotgun', function()
  local _source = source
  PlayersCrafting13[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Pompe Bullpup~s~...')
  CraftBullpupShotgun(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftBullpupShotgun')
AddEventHandler('esx_ammunationjob:stopCraftBullpupShotgun', function()
  local _source = source
  PlayersCrafting13[_source] = false
end)

------------ Craft Fusil de précision -------------------
local function CraftSniperRifle(source)

  SetTimeout(15000, function()

    if PlayersCrafting14[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_sniperrifle
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 100  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 125 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 100)
		xPlayer.removeInventoryItem('acier', 125)
		xPlayer.addWeapon('WEAPON_SNIPERRIFLE', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftSniperRifle')
AddEventHandler('esx_ammunationjob:startCraftSniperRifle', function()
  local _source = source
  PlayersCrafting14[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Sniper de précision~s~...')
  CraftSniperRifle(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftSniperRifle')
AddEventHandler('esx_ammunationjob:stopCraftSniperRifle', function()
  local _source = source
  PlayersCrafting14[_source] = false
end)

------------ Craft Fusil de précision lourd -------------------
local function CraftHeavySniper(source)

  SetTimeout(15000, function()

    if PlayersCrafting15[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_heavysniper
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')			
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 70  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 15 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 70)
		xPlayer.removeInventoryItem('acier', 15)
		xPlayer.addWeapon('WEAPON_HEAVYSNIPER', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftHeavySniper')
AddEventHandler('esx_ammunationjob:startCraftHeavySniper', function()
  local _source = source
  PlayersCrafting15[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Sniper de précision lourd~s~...')
  CraftHeavySniper(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftHeavySniper')
AddEventHandler('esx_ammunationjob:stopCraftHeavySniper', function()
  local _source = source
  PlayersCrafting15[_source] = false
end)

------------ Craft Revolver double action -------------------
local function CraftDoubleAction(source)

  SetTimeout(15000, function()

    if PlayersCrafting16[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_doubleaction
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 125  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 45 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 125)
		xPlayer.removeInventoryItem('acier', 45)
		xPlayer.addWeapon('WEAPON_DOUBLEACTION', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftDoubleAction')
AddEventHandler('esx_ammunationjob:startCraftDoubleAction', function()
  local _source = source
  PlayersCrafting16[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Revolver double action~s~...')
  CraftDoubleAction(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftDoubleAction')
AddEventHandler('esx_ammunationjob:stopCraftDoubleAction', function()
  local _source = source
  PlayersCrafting16[_source] = false
end)

------------ Craft Pompe Assault -------------------
local function CraftAssaultShotgun(source)

  SetTimeout(15000, function()

    if PlayersCrafting17[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_assaultshotgun
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true			
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 50  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 20 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 50)
		xPlayer.removeInventoryItem('acier', 20)
		xPlayer.addWeapon('WEAPON_ASSAULTSHOTGUN', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end		
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftAssaultShotgun')
AddEventHandler('esx_ammunationjob:startCraftAssaultShotgun', function()
  local _source = source
  PlayersCrafting17[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Pompe d\'assault~s~...')
  CraftAssaultShotgun(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftAssaultShotgun')
AddEventHandler('esx_ammunationjob:stopCraftAssaultShotgun', function()
  local _source = source
  PlayersCrafting17[_source] = false
end)

------------ Craft SMG-------------------
local function CraftSMG(source)

  SetTimeout(15000, function()

    if PlayersCrafting18[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_smg
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true		
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')	
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 45  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 10 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 45)
		xPlayer.removeInventoryItem('acier', 10)
		xPlayer.addWeapon('WEAPON_SMG', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftSMG')
AddEventHandler('esx_ammunationjob:startCraftSMG', function()
  local _source = source
  PlayersCrafting18[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage de la ~b~Mitraillette~s~...')
  CraftSMG(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftSMG')
AddEventHandler('esx_ammunationjob:stopCraftSMG', function()
  local _source = source
  PlayersCrafting18[_source] = false
end)

------------ Craft Fusil à canon scié -------------------
local function CraftCarbineRiflemk2(source)

  SetTimeout(15000, function()

    if PlayersCrafting19[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_carbinerifle_mk2
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true		
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')	
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 30  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 20 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 30)
		xPlayer.removeInventoryItem('acier', 20)
		xPlayer.addWeapon('WEAPON_CARBINERIFLE_MK2', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCarbineRiflemk2')
AddEventHandler('esx_ammunationjob:startCraftCarbineRiflemk2', function()
  local _source = source
  PlayersCrafting19[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage de la ~b~Carabine MK2~s~...')
  CraftCarbineRiflemk2(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftCarbineRiflemk2')
AddEventHandler('esx_ammunationjob:stopCraftCarbineRiflemk2', function()
  local _source = source
  PlayersCrafting19[_source] = false
end)

------------ Craft Carabine Spéciale -------------------
local function CraftSpecialCarbine(source)

  SetTimeout(15000, function()

    if PlayersCrafting20[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_specialcarbine
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 65  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 35 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 65)
		xPlayer.removeInventoryItem('acier', 35)
		xPlayer.addWeapon('WEAPON_SPECIALCARBINE', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftSpecialCarbine')
AddEventHandler('esx_ammunationjob:startCraftSpecialCarbine', function()
  local _source = source
  PlayersCrafting20[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage de la ~b~Carabine Speciale~s~...')
  CraftSpecialCarbine(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftSpecialCarbine')
AddEventHandler('esx_ammunationjob:stopCraftSpecialCarbine', function()
  local _source = source
  PlayersCrafting20[_source] = false
end)

------------ Craft Carabine Speciale MK2 -------------------
local function CraftSpecialCarbinemk2(source)

  SetTimeout(15000, function()

    if PlayersCrafting21[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_specialcarbine_mk2
	  local ClipQuantity = xPlayer.getInventoryItem('clip').count
	  local clip = false
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécessaires pour fabriquer cette arme')		
		end
	  end)
	  
	  if ClipQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas~s~ de chargeur')
	  else
		clip = true
	  end

	  if CarboneQuantity < 150  then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de carbone')
	  else
		carbone = true
	  end
	  
	  if AcierQuantity < 150 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if carbone and acier and societymoney then
		xPlayer.removeInventoryItem('carbon', 150)
		xPlayer.removeInventoryItem('acier', 150)
		xPlayer.addWeapon('WEAPON_SPECIALCARBINE_MK2', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftSpecialCarbinemk2')
AddEventHandler('esx_ammunationjob:startSpecialCarbinemk2', function()
  local _source = source
  PlayersCrafting21[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage de la ~b~Carabine Speciale MK2t~s~...')
  CraftSpecialCarbinemk2(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopSpecialCarbinemk2')
AddEventHandler('esx_ammunationjob:stopCraftSpecialCarbinemk2', function()
  local _source = source
  PlayersCrafting21[_source] = false
end)

------------ Craft Matraque -------------------
local function CraftNightStick(source)

  SetTimeout(15000, function()

    if PlayersCrafting22[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CarboneQuantity = xPlayer.getInventoryItem('carbon').count
	  local AcierQuantity = xPlayer.getInventoryItem('acier').count
	  local carbone = false
	  local acier = false
	  local prix = Config.Price.weapon_nightstick
	  local societymoney = false
	  
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
		if account.money >= prix then
			societymoney = true	
		else 
			TriggerClientEvent('esx:showNotification', source, '~r~Votre société n\'a pas les fonds nécéssaire pour fabriquer cette armes')		
		end
	  end)
	  
	  if AcierQuantity < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ d\'acier')
	  else
	    acier = true
	  end
	  
      if acier and societymoney then
		xPlayer.removeInventoryItem('acier', 1)
		xPlayer.addWeapon('WEAPON_NIGHTSTICK', 0)
		
		local societyAccount = nil

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ammunation', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.removeMoney(prix)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('achat_society') .. prix .. _U('achat_society2'))
			end
      end
    end
  end)
end

RegisterServerEvent('esx_ammunationjob:startCraftNightStick')
AddEventHandler('esx_ammunationjob:startCraftNightStick', function()
  local _source = source
  PlayersCrafting22[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Assemblage du ~b~Mitraillette légère~s~...')
  CraftNightStick(_source)
end)

RegisterServerEvent('esx_ammunationjob:stopCraftNightStick')
AddEventHandler('esx_ammunationjob:stopCraftNightStick', function()
  local _source = source
  PlayersCrafting22[_source] = false
end)

----------------------------------
---- Ajout Gestion Stock Boss ----
----------------------------------

RegisterServerEvent('esx_ammunationjob:getStockItem')
AddEventHandler('esx_ammunationjob:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ammunation', function(inventory)

	local item = inventory.getItem(itemName)
	local sourceItem = xPlayer.getInventoryItem(itemName)

    -- is there enough in the society?
		if count > 0 and item.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('player_cannot_hold'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', count, item.label))
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_ammunationjob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ammunation', function(inventory)
    cb(inventory.items)
  end)

end)

-------------
-- AJOUT 2 --
-------------

RegisterServerEvent('esx_ammunationjob:putStockItems')
AddEventHandler('esx_ammunationjob:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ammunation', function(inventory)

    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count

    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, item.label))

  end)

end)

ESX.RegisterServerCallback('esx_ammunationjob:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({items = items})
end)

RegisterServerEvent('givesil:give')
AddEventHandler('givesil:give', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('silencieux', 1)

end)

RegisterServerEvent('givepng:give')
AddEventHandler('givepng:give', function()
local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('grip', 1)

end)

RegisterServerEvent('givelmp:give')
AddEventHandler('givelmp:give', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('flashlight', 1)

end)

RegisterServerEvent('givesd:give')
AddEventHandler('givesd:give', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('yusuf', 1)

end)

RegisterServerEvent('esx_ammunationjob:annonce')
AddEventHandler('esx_ammunationjob:annonce', function(result)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local text     = result
	print(text)
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		TriggerClientEvent('esx_ammunationjob:annonce', xPlayers[i],text)
	end

	Wait(8000)

	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		TriggerClientEvent('esx_ammunationjob:annoncestop', xPlayers[i])
	end

end)