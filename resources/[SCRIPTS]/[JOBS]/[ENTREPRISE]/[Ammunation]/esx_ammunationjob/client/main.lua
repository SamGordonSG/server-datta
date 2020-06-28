
local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData              = {}
local GUI                     = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local OnJob                   = false
local TargetCoords            = nil
local CurrentlyTowedVehicle   = nil
local Blips                   = {}

ESX                           = nil
GUI.Time                      = 0

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 3,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 3,
		modArmor = 		  4,
		modTurbo        = true,
		windowTint = 1,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end

function OpenGetWeaponMenu()

  ESX.TriggerServerCallback('esx_ammunationjob:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {css='inventaire',
        title    = 'Armurerie',
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('esx_ammunationjob:removeArmoryWeapon', function()
          OpenGetWeaponMenu()
        end, data.current.value)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutWeaponMenu()

  local elements   = {}
  local playerPed  = GetPlayerPed(-1)
  local weaponList = ESX.GetWeaponList()

  for i=1, #weaponList, 1 do

    local weaponHash = GetHashKey(weaponList[i].name)

    if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
      local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
      table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
    end

  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory_put_weapon',
    {css='inventaire',
      title    = 'Armurerie',
      align    = 'top-left',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('esx_ammunationjob:addArmoryWeapon', function()
        OpenPutWeaponMenu()
      end, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end


function OpenAmmuActionsMenu()

  local elements = {
	{label = 'Sortir Véhicule', value = 'vehicle_list'},
    --{label = _U('work_wear'), value = 'cloakroom'},
    --{label = _U('civ_wear'), value = 'cloakroom2'},
    {label = _U('deposit_stock'), value = 'put_stock'}
  }
  
  If PlayerData.job ~= nil and PlayerData.job.grade_name == 'second' or PlayerData.job.grade_name =='boss' or PlayerData.job.grade_name == 'professionnel' or PlayerData.job.grade_name == 'employer' then 
	table.insert(elements, {label = 'Prendre Stock', value = 'get_stock'})
    table.insert(elements, {label = 'Prendre Arme', value = 'get_weapon'})
	table.insert(elements, {label = 'Déposer Arme', value = 'put_weapon'})
  end
  
  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' then
    table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Ammu_actions',
    {css='metier',
      title    = _U('ammunation'),
      elements = elements
    },
    function(data, menu)
      if data.current.value == 'vehicle_list' then

        if Config.EnableSocietyOwnedVehicles then

            local elements = {}

            ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

              for i=1, #vehicles, 1 do
                table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
              end

              ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'vehicle_spawner',
                {css='vehicle',
                  title    = _U('service_vehicle'),
                  align    = 'top-left',
                  elements = elements,
                },
                function(data, menu)

                  menu.close()

                  local vehicleProps = data.current.value

                  ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
                    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
                    local playerPed = GetPlayerPed(-1)
                    TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                  end)

                  TriggerServerEvent('esx_society:removeVehicleFromGarage', 'ammunation', vehicleProps)

                end,
                function(data, menu)
                  menu.close()
                end
              )

            end, 'ammunation')

          else

            local elements = {
			  {label = 'Boxville Ammunation', value = 'aboxville'},
			  {label = 'Burrito Ammunation', value = 'aburrito'}
            }

            if Config.EnablePlayerManagement and PlayerData.job ~= nil and
				(PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'second' or PlayerData.job.grade_name == 'professionnel' or PlayerData.job.grade_name == 'employer') then
                table.insert(elements, {label = 'Stockade Ammunation', value = 'astockade'})
				table.insert(elements, {label = '4x4 Ammunation', value = 'mesa3'})
            end

            ESX.UI.Menu.CloseAll()

            ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'spawn_vehicle',
              {css='vehicle',
                title    = _U('service_vehicle'),
                elements = elements
              },
              function(data, menu)
                for i=1, #elements, 1 do
                  if Config.MaxInService == -1 then
                    local platenum = math.random(1000, 9999)
                    local platePrefix = Config.platePrefix
                    ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 360.0, function(vehicle)
                      local playerPed = GetPlayerPed(-1)
                      TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							        SetVehicleMaxMods(vehicle)
							        SetVehicleLivery(vehicle, 1)
						          SetVehicleNumberPlateText(vehicle, platePrefix .. platenum)
					            plate = GetVehicleNumberPlateText(vehicle)
							        plate = string.gsub(plate, " ", "")
							        TriggerServerEvent('esx_vehiclelock:registerkeyjob', plate, 'no') -- vehicle lock
                      end)
                    break
                  else
                    ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
                      if canTakeService then
                        ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 360.0, function(vehicle)
                          local playerPed = GetPlayerPed(-1)
                          TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
                        end)
                      else
                        ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
                      end
                    end, 'ammunation')
                    break
                  end
                end
                menu.close()
              end,
              function(data, menu)
                menu.close()
                OpenAmmuActionsMenu()
              end
            )

          end
      end

      if data.current.value == 'cloakroom' then
        menu.close()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

            if skin.sex == 0 then
                TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
            else
                TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
            end

        end)
      end

      if data.current.value == 'cloakroom2' then
        menu.close()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

            TriggerEvent('skinchanger:loadSkin', skin)

        end)
      end

      if data.current.value == 'put_stock' then
        OpenPutStocksMenu()
      end

      if data.current.value == 'get_stock' then
        OpenGetStocksMenu()
      end
	  
	  if data.current.value == 'put_weapon' then
        OpenPutWeaponMenu()
      end

      if data.current.value == 'get_weapon' then
        OpenGetWeaponMenu()
      end

      if data.current.value == 'boss_actions' then
        TriggerEvent('esx_society:openBossMenu', 'ammunation', function(data, menu)
          menu.close()
        end)
      end

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'ammu_actions_menu'
      CurrentActionMsg  = _U('open_actions')
      CurrentActionData = {}
    end
  )
end

function OpenAmmuHarvestMenu()

  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'ammunation' then
    local elements = {
      {label = 'Carbone', value = 'carbone_recolt'},
	  {label = 'Acier', value = 'acier_recolt'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'ammu_harvest',
      {css='metier',
        title    = _U('harvest'),
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'carbone_recolt' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startHarvest')
        end
		
		if data.current.value == 'acier_recolt' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startHarvest2')
        end

      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'ammu_harvest_menu'
        CurrentActionMsg  = _U('harvest_menu')
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification(_U('not_experienced_enough'))
  end
end

function OpenAmmuCraftMenu()
  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name ~= 'stagiaire' and PlayerData.job.name == 'ammunation' then

    local elements = {
    {label = 'Munition 100$', value = 'munition'},
    {label = 'Silencieux - 400$ ' , value = 'sil'},
    {label = 'Poignée - 250$ ', value = 'png'},
    {label = 'Lampe - 150$ ', value = 'lmp'},
    {label = 'Skin Doré - 600$ ', value = 'sd'},
    {label = 'Matraque - 350$ ' .. Config.Price.weapon_nightstick, value = 'weapon_nightstick'},
    {label = 'Taser - 1500$ ' .. Config.Price.weapon_stungun, value = 'weapon_stungun'},
	  {label = 'Pétoire - 32000$ ' .. Config.Price.weapon_snspistol, value = 'weapon_snspistol'},
    {label = 'Pistolet - 35000$ ' .. Config.Price.weapon_pistol, value = 'weapon_pistol'},
    {label = 'Pistolet Double Action - 55000$ ' .. Config.Price.weapon_doubleaction, value = 'weapon_doubleaction'},
    {label = 'Pistolet MK2 - 39000$ ' .. Config.Price.weapon_pistol_mk2, value = 'weapon_pistol_mk2'},
	  {label = 'Pistolet de combat - 42000$ ' .. Config.Price.weapon_combatpistol, value = 'weapon_combatpistol'},
    {label = 'Pistolet Cal.50 - 60000$ ' .. Config.Price.weapon_pistol50, value = 'weapon_pistol50'},
    {label = 'Mousquet - 32000$ ' .. Config.Price.weapon_musket, value = 'weapon_musket'},
    {label = 'Fusil Pompe - 84000$ ' .. Config.Price.weapon_pumpshotgun, value = 'weapon_pumpshotgun'},
    {label = 'Fusil Pompe MK2 - 39000$ ' .. Config.Price.weapon_pumpshotgun_mk2, value = 'weapon_pumpshotgun_mk2'},
    {label = 'Pompe Bullpup - $ ' .. Config.Price.weapon_bullpupshotgun, value = 'weapon_bullpupshotgun'},
    {label = 'Carabine d\'assaut - $ ' .. Config.Price.weapon_carbinerifle, value = 'weapon_carbinerifle'},
    {label = 'Carabine d\'assaut 2 - $ ' .. Config.Price.weapon_carbinerifle_mk2, value = 'weapon_carbinerifle_mk2'},
    {label = 'Carabine Spéciale - $ ' .. Config.Price.weapon_specialcarbine, value = 'weapon_specialcarbine'},
    {label = 'Carabine Spéciale 2 - $ ' .. Config.Price.weapon_specialcarbine_mk2, value = 'weapon_specialcarbine_mk2'},
    {label = 'ADP de combat - $ ' .. Config.Price.weapon_combatpdw, value = 'weapon_combatpdw'},
    {label = 'Mitraillette - $ ' .. Config.Price.weapon_smg, value = 'weapon_smg'},
    {label = 'Mitraillette d\'assaut - $ ' .. Config.Price.weapon_assaultsmg, value = 'weapon_assaultsmg'},
    {label = 'Fusil à pompe d\'assaut - $ ' .. Config.Price.weapon_assaultshotgun, value = 'weapon_assaultshotgun'},
    {label = 'Fusil de précision - 190000$ ' .. Config.Price.weapon_sniperrifle, value = 'weapon_sniperrifle'},
    {label = 'Fusil de précision 2 - 199000$ ' .. Config.Price.weapon_heavysniper, value = 'weapon_heavysniper'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'ammu_craft',
      {css='metier',
        title    = _U('craft'),
        elements = elements
      },
      function(data, menu)
		local playerPed = GetPlayerPed(-1)
		
        if data.current.value == 'munition' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startTransformMunition')
        end

        if data.current.value == 'sil' then
          menu.close()
          TriggerServerEvent('givesil:give')
        end

        if data.current.value == 'png' then
          menu.close()
          TriggerServerEvent('givepng:give')
        end

        if data.current.value == 'lmp' then
          menu.close()
          TriggerServerEvent('givelmp:give')
        end

        if data.current.value == 'sd' then
          menu.close()
          TriggerServerEvent('givesd:give')
        end

        if data.current.value == 'weapon_nightstick' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftNightStick')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Matraque assemblée !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end        

        if data.current.value == 'weapon_stungun' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftStungun')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Tazer assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end

        if data.current.value == 'weapon_snspistol' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftSnsPistol')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Pétoire assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end
		
        if data.current.value == 'weapon_pistol' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftPistol')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Pistolet assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end

        if data.current.value == 'weapon_pistol_mk2' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftPistolmk2')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Pistolet MK2 assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end
		
		if data.current.value == 'weapon_combatpistol' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftCombatPistol')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Pistolet de combat assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end

        if data.current.value == 'weapon_pistol50' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftPistol50')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Pistolet Cal.50 assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end

    		if data.current.value == 'weapon_doubleaction' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftDoubleAction')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Revolver Double Action assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end    
		
		if data.current.value == 'weapon_musket' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftMusket')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Mousquet assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end

    		if data.current.value == 'weapon_pumpshotgun' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftPumpShotgun')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Fusil à pompe assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end

        if data.current.value == 'weapon_pumpshotgun_mk2' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftPumptShotgunmk2')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Fusil à pompe MK2 assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end  
        
    		if data.current.value == 'weapon_bullpumpshotgun' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftBullpupShotgun')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Pompe Bullpup assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end    
		
		if data.current.value == 'weapon_carbinerifle' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftCarbineRifle')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Carabine d'assaut assemblée !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end

        if data.current.value == 'weapon_carbinerifle_mk2' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftCarbineRiflemk2')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Carabine d'assaut MK2 assemblée !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end

    		if data.current.value == 'weapon_specialcarbine' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftSpecialCarbine')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Carabine Spéciale assemblée !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end    

    		if data.current.value == 'weapon_specialcarbine_mk2' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftSpecialCarbinemk2')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Carabine Spéciale MK2 assemblée !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end 
        
        if data.current.value == 'weapon_combatpdw' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftCombatPdw')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "ADP de combat assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end
        
    		if data.current.value == 'weapon_smg' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftSMG')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Mitraillette assemblée !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end    
		
		if data.current.value == 'weapon_assaultsmg' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftAssaultSmg')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Mitraillette d'assaut assemblée !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end
        
		if data.current.value == 'weapon_sniperrifle' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftSniperRifle')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Sniper de précision assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end
		
		if data.current.value == 'weapon_heavysniper' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftHeavySniper')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Sniper lourd assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end
		
		if data.current.value == 'weapon_assaulshotgun' then
          menu.close()
          TriggerServerEvent('esx_ammunationjob:startCraftAssaultShotgun')
		  exports.utils:getUtils().showProgressBarTimer(15000, "Assemblage en cours ..", "Pompe d'assault assemblé !")
		  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 15000, true)
		  Citizen.Wait(15000)
		  ClearPedTasksImmediately(playerPed)
        end
      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'ammu_craft_menu'
        CurrentActionMsg  = _U('craft_menu')
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification(_U('not_experienced_enough'))
  end
end

function OpenMobileAmmuActionsMenu()

  ESX.UI.Menu.CloseAll()

  if PlayerData.job ~= nil and PlayerData.job.grade_name == 'second' or PlayerData.job.grade_name == 'professionnel'  or PlayerData.job.grade_name == 'boss' then
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mobile_ammu_actions',
		{css='metier',
		  title    = _U('ammunation'),
		  elements = {
      {label = _U('billing'),    value = 'billing'},
      {label = 'Annonces',    value = 'annonce'},
			{label = 'Permis de port d\'arme',    value = 'ppa'},
		  }
		},
		function(data, menu)
		  if data.current.value == 'billing' then
			ESX.UI.Menu.Open(
			  'dialog', GetCurrentResourceName(), 'billing',
			  {
				title = _U('invoice_amount')
			  },
			  function(data, menu)
				local amount = tonumber(data.value)
				if amount == nil then
				  ESX.ShowNotification(_U('amount_invalid'))
				else
				  menu.close()
				  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				  if closestPlayer == -1 or closestDistance > 3.0 then
					ESX.ShowNotification(_U('no_players_nearby'))
				  else
					TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ammunation', _U('ammunation'), amount)
				  end
				end
			  end,
			function(data, menu)
			  menu.close()
			end
			)
      end
      
      if data.current.value == 'annonce' then 
        messagenotfinish = true
        Message()
      end
		  
		  if data.current.value == 'ppa' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'ppa',
          {
		  css = 'metier',
            title    = ('PPA'),
            align    = 'top-left',
            elements = {
              {label = ('Attribuer le PPA'), value = 'give_ppa'},
              {label = ('Destituer le PPA'),    value = 'remove_ppa'},
            },
          },
          function(data2, menu2)
		  local player, distance = ESX.Game.GetClosestPlayer()

              if data2.current.value == 'give_ppa' then
			    if distance ~= -1 and distance <= 3.0 then
				
				TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(player), 'weapon', function ()
				end)
				ESX.ShowNotification('Vous avez donné le PPA')
              else
			    ESX.ShowNotification('Personne à proximité')
			  end
			end

              if data2.current.value == 'remove_ppa' then
				if distance ~= -1 and distance <= 3.0 then
				
				TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), 'weapon', function ()
				end)
				ESX.ShowNotification('Vous avez retiré le PPA')
              else
			    ESX.ShowNotification('Personne à proximité')
			  end
			end
          
          end,
          function(data2, menu2)
          menu2.close()
          end
        )
  
        end
      end,
      function(data, menu)
      menu.close()
      end
      )
  else
    ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'mobile_ammu_actions',
    {
      title    = _U('ammunation'),
      elements = {
        {label = _U('billing'),    value = 'billing'},
      }
    },
    function(data, menu)
      if data.current.value == 'billing' then
        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'billing',
          {
            title = _U('invoice_amount')
          },
          function(data, menu)
            local amount = tonumber(data.value)
            if amount == nil then
              ESX.ShowNotification(_U('amount_invalid'))
            else
              menu.close()
              local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
              if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification(_U('no_players_nearby'))
              else
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ammunation', _U('ammunation'), amount)
              end
            end
          end,
        function(data, menu)
          menu.close()
        end
        )
      end
    end,
  function(data, menu)
    menu.close()
  end
  )
  end
end

function tier(player, tier)

  TriggerServerEvent('esx_ammunationjob:givelicence')

end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_ammunationjob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', 
		{css='metier',
			title    = _U('ammunation_stock'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_ammunationjob:getStockItem', itemName, count)

					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_ammunationjob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', 
		{css='metier',
			title    = _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_ammunationjob:putStockItems', itemName, count)

					Citizen.Wait(1000)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function setEntityHeadingFromEntity ( vehicle, playerPed )
    local heading = GetEntityHeading(vehicle)
    SetEntityHeading( playerPed, heading )
end

function getVehicleInDirection(coordFrom, coordTo)
  local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
  local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
  return vehicle
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
  refreshBlips()
end)

function Message()
  Citizen.CreateThread(function()
    while messagenotfinish do
        Citizen.Wait(1)

      DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 200)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
           Citizen.Wait(1)
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            messagenotfinish = false
           TriggerServerEvent('esx_ammunationjob:annonce',result)
            
        end


    end
  end)
  
end


function DrawAdvancedTextCNN (x,y ,w,h,sc, text, r,g,b,a,font,jus)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(sc, sc)
  N_0x4e096588b13ffeca(jus)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x - 0.1+w, y - 0.02+h)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)    
                         
          if (affichenews == true) then
             
            DrawRect(0.494, 0.227, 5.185, 0.118, 0, 0, 0, 150)
            DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, "~r~ AMMUNATION ~d~", 255, 255, 255, 255, 1, 0)
            DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, texteafiche, 255, 255, 255, 255, 7, 0)
            DrawAdvancedTextCNN(0.588, 0.246, 0.005, 0.0028, 0.4, "", 255, 255, 255, 255, 0, 0)

          end                
     end
end)

RegisterNetEvent('esx_ammunationjob:annonce')
AddEventHandler('esx_ammunationjob:annonce', function(text)
    texteafiche = text
    affichenews = true
    
end) 


RegisterNetEvent('esx_ammunationjob:annoncestop')
AddEventHandler('esx_ammunationjob:annoncestop', function()
    affichenews = false
    
end) 

AddEventHandler('esx_ammunationjob:hasEnteredMarker', function(zone)

  if zone == 'AmmunationActions' then
    CurrentAction     = 'ammu_actions_menu'
    CurrentActionMsg  = _U('open_actions')
    CurrentActionData = {}
  end

  if zone == 'Matos' then
    CurrentAction     = 'ammu_harvest_menu'
    CurrentActionMsg  = _U('harvest_menu')
    CurrentActionData = {}
  end
  --- farm munition
  if zone == 'Poudre' then
    CurrentAction     = 'poudre_harvest'
    CurrentActionMsg  = _U('poudre_menu')
    CurrentActionData = {}
  end
  if zone == 'Douille' then
    CurrentAction     = 'douille_harvest'
    CurrentActionMsg  = _U('douille_menu')
    CurrentActionData = {}
  end
  if zone == 'Revente' then
    CurrentAction     = 'resell'
    CurrentActionMsg  = _U('resell_menu')
    CurrentActionData = {}
  end
---fin farm munition
  if zone == 'Craft' then
    CurrentAction     = 'ammu_craft_menu'
    CurrentActionMsg  = _U('craft_menu')
    CurrentActionData = {}
  end

  if zone == 'VehicleDeleter' then

    local playerPed = GetPlayerPed(-1)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed,  false)

      CurrentAction     = 'delete_vehicle'
      CurrentActionMsg  = _U('veh_stored')
      CurrentActionData = {vehicle = vehicle}
    end
  end

end)

AddEventHandler('esx_ammunationjob:hasExitedMarker', function(zone)

  if zone =='VehicleDelivery' then
    NPCTargetDeleterZone = false
  end

  if zone == 'Craft' then
    TriggerServerEvent('esx_ammunationjob:stopTransformMunition')
    TriggerServerEvent('esx_ammunationjob:stopCraftStungun')
    TriggerServerEvent('esx_ammunationjob:stopCraftSnsPistol')
    TriggerServerEvent('esx_ammunationjob:stopCraftPistol')
    TriggerServerEvent('esx_ammunationjob:stopCraftPistolmk2')
  TriggerServerEvent('esx_ammunationjob:stopCraftCombatPistol')
  TriggerServerEvent('esx_ammunationjob:stopCraftPistol50')
  TriggerServerEvent('esx_ammunationjob:stopCraftDoubleAction')
  TriggerServerEvent('esx_ammunationjob:stopCraftMusket')
  TriggerServerEvent('esx_ammunationjob:stopCraftPumpShotgun')
  TriggerServerEvent('esx_ammunationjob:stopCraftPumpShotgunmk2')
	TriggerServerEvent('esx_ammunationjob:stopCraftBullpupShotgun')
  TriggerServerEvent('esx_ammunationjob:stopCraftCarbineRifle')
  TriggerServerEvent('esx_ammunationjob:stopCraftCarbineRiflemk2')
  TriggerServerEvent('esx_ammunationjob:stopCraftSpecialCarbine')
  TriggerServerEvent('esx_ammunationjob:stopCraftSpecialCarbinemk2')
  TriggerServerEvent('esx_ammunationjob:stopCraftCombatPdw')
  TriggerServerEvent('esx_ammunationjob:stopCraftSmg')
	TriggerServerEvent('esx_ammunationjob:stopCraftAssaultSmg')
  TriggerServerEvent('esx_ammunationjob:stopCraftAssaultShotgun')
  TriggerServerEvent('esx_ammunationjob:stopCraftSniperRifle')
	TriggerServerEvent('esx_ammunationjob:stopCraftHeavySniper')
  end

  if zone == 'Matos' then
    TriggerServerEvent('esx_ammunationjob:stopHarvest')
    TriggerServerEvent('esx_ammunationjob:stopHarvest2')
    TriggerServerEvent('esx_ammunationjob:stopHarvest3')
  end

  if zone == 'Poudre' then
    TriggerServerEvent('esx_ammunationjob:stopHarvestMunition')
  end

  if zone == 'Douille' then
    TriggerServerEvent('esx_ammunationjob:stopHarvestMunition2')
  end

  if zone == 'Revente' then
    TriggerServerEvent('esx_ammunationjob:stopVenteMunition')
  end

  CurrentAction = nil
  ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
  local specialContact = {
    name       = _U('ammunation'),
    number     = 'ammunation',
    base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
  }
  TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- Create Blips
Citizen.CreateThread(function()
  local blip = AddBlipForCoord(826.94, -2151.82, 28.61)
  SetBlipSprite (blip, 313)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 1.2)
  SetBlipColour (blip, 1)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(('AMMUNATION'))
  EndTextCommandSetBlipName(blip)
end)

function refreshBlips()
  local zones = {}
  local blipInfo = {}

  if PlayerData.job ~= nil and PlayerData.job.name == 'ammunation' then
    local blip = AddBlipForCoord(1208.453, -3113.833, 4.5403)
    SetBlipSprite (blip, 566)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 1.0)
    SetBlipColour (blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Ammu-Nation - Fabrication d'armes")
    EndTextCommandSetBlipName(blip)
  end
  if PlayerData.job ~= nil and PlayerData.job.name == 'ammunation' then
	local blip = AddBlipForCoord(1736.262, 3327.502, 40.2234)
    SetBlipSprite (blip, 478)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 1.00)
    SetBlipColour (blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Ammu-Nation - Matériels")
    EndTextCommandSetBlipName(blip)
  end
  if PlayerData.job ~= nil and PlayerData.job.name == 'ammunation' then
	local blip = AddBlipForCoord(2572.25, 292.7638, 107.7349 )
    SetBlipSprite (blip, 549)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 1.00)
    SetBlipColour (blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Ammu-Nation - Poudre")
    EndTextCommandSetBlipName(blip)
  end
  if PlayerData.job ~= nil and PlayerData.job.name == 'ammunation' then
	local blip = AddBlipForCoord(1689.718, 3757.49, 33.7053 )
    SetBlipSprite (blip, 549)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 1.0)
    SetBlipColour (blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Ammu-Nation - Douille")
    EndTextCommandSetBlipName(blip)
  end
  if PlayerData.job ~= nil and PlayerData.job.name == 'ammunation' then
	local blip = AddBlipForCoord(612.0963, -3075.188, 5.0692)
    SetBlipSprite (blip, 549)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 1.0)
    SetBlipColour (blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Ammu-Nation - Revente")
    EndTextCommandSetBlipName(blip)
  end
end
-- Display markers
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if PlayerData.job ~= nil and PlayerData.job.name == 'ammunation' then

      local coords = GetEntityCoords(GetPlayerPed(-1))

      for k,v in pairs(Config.Zones) do
        if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
          DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
        end
      end
    end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if PlayerData.job ~= nil and PlayerData.job.name == 'ammunation' then
      local coords      = GetEntityCoords(GetPlayerPed(-1))
      local isInMarker  = false
      local currentZone = nil
      for k,v in pairs(Config.Zones) do
        if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
          isInMarker  = true
          currentZone = k
        end
      end
      if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
        HasAlreadyEnteredMarker = true
        LastZone                = currentZone
        TriggerEvent('esx_ammunationjob:hasEnteredMarker', currentZone)
      end
      if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('esx_ammunationjob:hasExitedMarker', LastZone)
      end
    end
  end
end)


-- Key Controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if CurrentAction ~= nil then

          SetTextComponentFormat('STRING')
          AddTextComponentString(CurrentActionMsg)
          DisplayHelpTextFromStringLabel(0, 0, 1, -1)

          if IsControlJustReleased(0, 38) and PlayerData.job ~= nil and PlayerData.job.name == 'ammunation' then

            if CurrentAction == 'ammu_actions_menu' then
                OpenAmmuActionsMenu()
            end

            if CurrentAction == 'ammu_harvest_menu' then
                OpenAmmuHarvestMenu()
            end
			
            if CurrentAction == 'poudre_harvest' then
				TriggerServerEvent('esx_ammunationjob:startHarvestMunition')                
            end
			
            if CurrentAction == 'douille_harvest' then
				TriggerServerEvent('esx_ammunationjob:startHarvestMunition2')     
            end
			
			
            if CurrentAction == 'resell' then
				TriggerServerEvent('esx_ammunationjob:startVenteMunition')     
            end
			
			
			if PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'second' or PlayerData.job.grade_name == 'employer' or PlayerData.job.grade_name == 'professionnel' then
				if CurrentAction == 'ammu_craft_menu' then
					OpenAmmuCraftMenu()
				end
			end

            if CurrentAction == 'delete_vehicle' then

              if Config.EnableSocietyOwnedVehicles then

                local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
                TriggerServerEvent('esx_society:putVehicleInGarage', 'ammunation', vehicleProps)

              else

                if
                  GetEntityModel(vehicle) == GetHashKey('aboxville')   or
                  GetEntityModel(vehicle) == GetHashKey('astockade') or
                  GetEntityModel(vehicle) == GetHashKey('aburrito')
                then
                  TriggerServerEvent('esx_service:disableService', 'ammunation')
                end

              end
              TriggerServerEvent('esx_vehiclelock:deletekey2', plate, 'no')
              ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
            end

            if CurrentAction == 'remove_entity' then
              DeleteEntity(CurrentActionData.entity)
            end

            CurrentAction = nil
          end
        end		
			
        if IsControlJustReleased(0, Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'ammunation' then
            OpenMobileAmmuActionsMenu()
        end

    end
end)

--[[RegisterNetEvent('esx_menu_actions:job')
AddEventHandler('esx_menu_actions:job', function()
    if PlayerData.job ~= nil and PlayerData.job.name == 'ammunation' then
        OpenMobileAmmuActionsMenu()
    end
end)]]
