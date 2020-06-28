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


ESX                           = nil
TimeDiff                      = 0
CurrentCig                    = nil
SpawnedObjects                = {}
SpawnedPeds                   = {}
local PlayerData              = {}
local GUI                     = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local LastPart                = nil
local LastData                = {}
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local OnJob                   = false
local TargetCoords            = nil
local CurrentlyTowedVehicle   = nil
local PedBlacklist            = {}
local PedAttacking            = nil
local Blips                   = {}
local JobBlips                = {}
GUI.Time                      = 0



Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  CreateJobBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
  DeleteJobBlips()
  CreateJobBlips()
end)

function IsJobTrue()
  if PlayerData ~= nil then
    local IsJobTrue = false
    if PlayerData.job ~= nil and PlayerData.job.name == 'tabac' then
      IsJobTrue = true
    end
    return IsJobTrue
  end
end

function CreateJobBlips()
    if IsJobTrue() then               
	  local blip = AddBlipForCoord(Config.Zones.Garage.Pos.x, Config.Zones.Garage.Pos.y, Config.Zones.Garage.Pos.z)
	  SetBlipSprite (blip, 238)
	  SetBlipDisplay(blip, 4)
	  SetBlipScale  (blip, 0.8)
	  SetBlipColour (blip, 56)
	  SetBlipAsShortRange(blip, true)
	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentString("Récolte Tabac")
	  EndTextCommandSetBlipName(blip)
      table.insert(JobBlips, blip) 
    end 
end

function DeleteJobBlips()
  if JobBlips[1] ~= nil then
    for i=1, #JobBlips, 1 do
      RemoveBlip(JobBlips[i])
      JobBlips[i] = nil
    end
  end
end


function Message()
  Citizen.CreateThread(function()
    while messagenotfinish do
        Citizen.Wait(1)

      DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
           Citizen.Wait(1)
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            messagenotfinish = false
           TriggerServerEvent('esx_tabac:annonce',result)
           
        end
    end
  end)
  
end

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30,  true) -- MoveLeftRight
      DisableControlAction(0, 31,  true) -- MoveUpDown
    end
  end
end)

function StartWalking(ped)
  Citizen.CreateThread(function()
    RequestAnimDict('move_m@generic_variations@walk')
    while not HasAnimDictLoaded('move_m@generic_variations@walk') do
      Citizen.Wait(1)
    end
    TaskPlayAnim(ped,  'move_m@generic_variations@walk',  'walk_a',  1.0,  -1.0,  -1,  0,  1,  false,  false,  false)
  end)
end

function OpenTabacActionsMenu()

  local elements = {
    {label = _U('vehicle_list'), value = 'vehicle_list'},
    {label = _U('work_wear'), value = 'cloakroom'},
    {label = _U('civ_wear'), value = 'cloakroom2'},
    {label = _U('deposit_stock'), value = 'put_stock'}
  }

  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name ~= 'recrue' then
  	table.insert(elements, {label = _U('withdraw_stock'), value = 'get_stock'})
  end

  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' then
    table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'tabac_actions',
    {
      title    = 'Menu Tabac',
      align = 'top-left',
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
              {
                title    = _U('service_vehicle'),
                align    = 'top-left',
                elements = elements
              },
          
              function(data, menu)

                menu.close()

                local vehicleProps = data.current.value
                local playerPed = GetPlayerPed(-1)
                local coords    = Config.Zones.VehicleSpawnPoint.Pos
                local platenum = math.random(100, 900)

                ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
                ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
                SetVehicleNumberPlateText(vehicle, "TBC" .. platenum)
                TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                local plate = GetVehicleNumberPlateText(vehicle)
            	  plate = string.gsub(plate, " ", "")
                TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
              end)

                TriggerServerEvent('esx_society:removeVehicleFromGarage', 'tabac', vehicleProps)

              end,
          
              function(data, menu)
                menu.close()
              end
            )
          end, 'tabac')

        else

          local elements = {
            {label = 'Livraison', value = 'gburrito'},
            {label = 'Chef Equipe', value = 'bison'}
          }

          if Config.EnablePlayerManagement and PlayerData.job ~= nil and
            (PlayerData.job.grade_name == 'boss') then
            table.insert(elements, {label = 'Véhicule Patron', value = 'revolter'})
          end

          ESX.UI.Menu.CloseAll()

          ESX.UI.Menu.Open(
           'default', GetCurrentResourceName(), 'spawn_vehicle',
            {
              title    = _U('service_vehicle'),
              elements = elements
            },
          
            function(data, menu)
              for i=1, #elements, 1 do
                if Config.MaxInService == -1 then
                  ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
                  local playerPed = GetPlayerPed(-1)
                  local platenum = math.random(100, 900)
                  SetVehicleNumberPlateText(vehicle, "TBC" .. platenum)
                  TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                  local plate = GetVehicleNumberPlateText(vehicle)
                  plate = string.gsub(plate, " ", "")
                  TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
                  end, 'tabac')
            
                  break
                end
              end
            menu.close()
            end,
            function(data, menu)
              menu.close()
              OpenTabacActionsMenu()
            end
          )

        end
      end

      if data.current.value == 'cloakroom' then
      TriggerServerEvent("player:serviceOn", "tabac")	
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
      TriggerServerEvent("player:serviceOff", "tabac")	
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

      if data.current.value == 'boss_actions' then
        TriggerEvent('esx_society:openBossMenu', 'tabac', function(data, menu)
          menu.close()
        end)
      end

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'tabac_actions_menu'
      CurrentActionMsg  = _U('open_actions')
      CurrentActionData = {}
    end
  )
end

function OpenTabacHarvestMenu()

  if Config.EnablePlayerManagement and PlayerData.job ~= nil then
    local elements = {
      {label = 'Tabac Blond', value = 'tabacblond'},
      {label = 'Tabac Brun', value = 'tabacbrun'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'tabac_harvest',
      {
        title    = _U('harvest'),
        align    = 'top-left',
        elements = elements
      },

      function(data, menu)

        if data.current.value == 'tabacblond' then
          menu.close()
          TriggerServerEvent('esx_tabac:startHarvest')
        end

        if data.current.value == 'tabacbrun' then
          menu.close()
          TriggerServerEvent('esx_tabac:startHarvest2')
        end        

      end,
      function(data, menu)
        
        menu.close()

        CurrentAction     = 'tabac_harvest_menu'
        CurrentActionMsg  = _U('harvest_menu')
        CurrentActionData = {}

      end
    )
  else
    ESX.ShowNotification(_U('not_experienced_enough'))
  end

end

function OpenTabacCraftMenu()
  if Config.EnablePlayerManagement and PlayerData.job ~= nil then

    local elements = {
      {label = 'Tabac Blond Sec', value = 'tabacblondsec'},
      {label = 'Tabac Brun Sec', value = 'tabacbrunsec'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'tabac_craft',
      {
        title    = _U('craft'),
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'tabacblondsec' then
          menu.close()
          TriggerServerEvent('esx_tabac:startCraft')
        end

        if data.current.value == 'tabacbrunsec' then
          menu.close()
          TriggerServerEvent('esx_tabac:startCraft2')
        end

      end,

      function(data, menu)
        menu.close()
        CurrentAction     = 'tabac_craft_menu'
        CurrentActionMsg  = _U('craft_menu')
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification(_U('not_experienced_enough'))
  end
end

function OpenTabacCraft2Menu()
  if Config.EnablePlayerManagement and PlayerData.job ~= nil then

    local elements = {
      {label = 'Malboro', value = 'malbora'},
      {label = 'Lucky Strike', value = 'gitanes'},
      {label = 'Spliff de Weed',   value = 'splif'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'tabac_craft2',
      {
        title    = _U('craft'),
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'malbora' then
          menu.close()
          TriggerServerEvent('esx_tabac:startCraft3')
        end

        if data.current.value == 'gitanes' then
          menu.close()
          TriggerServerEvent('esx_tabac:startCraft4')
        end

        if data.current.value == 'splif' then
          menu.close()
          TriggerServerEvent('esx_tabac:startCraft5')
        end

      end,

      function(data, menu)
        menu.close()
        CurrentAction     = 'tabac_craft2_menu'
        CurrentActionMsg  = _U('craft_menu')
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification(_U('not_experienced_enough'))
  end
end

function OpenFactuTabacActionsMenu()

ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'factu_tabac_actions',
    {
      title    = 'Menu Tabac & Facturation',
      align    = 'top-left',
      elements = {
        {label = 'Intéraction Client',    value = 'facture_client'},
        {label = 'Passer une annonce', value = 'announce'}        
      },
    },


    function(data, menu)

      if data.current.value == 'facture_client' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'facture_client',
          {
            title    = 'Facturation Client',
            align    = 'top-left',
            elements = {

              {label = 'Facture',       value = 'billing'}              
            },
          },
             
          function(data2, menu2)
                
            local player, distance = ESX.Game.GetClosestPlayer()        

            if distance ~= -1 and distance <= 3.0 then
            
              if data2.current.value == 'billing' then
                ESX.UI.Menu.Open(
                  'dialog', GetCurrentResourceName(), 'billing',
                  {
                    title = _U('invoice_amount')
                  },
                  function(data2, menu2)
                    local amount = tonumber(data2.value)
                    if amount == nil then
                        ESX.ShowNotification(_U('amount_invalid'))
                      else
                      menu2.close()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                      if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(_U('no_players_nearby'))
                      else
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_tabac', _U('Tabac'), amount)
                      end
                    end
                  end,
                function(data2, menu2)
                  menu2.close()
                end                  
                )
              end

            else
              ESX.ShowNotification(_U('no_players_nearby'))
            end    
          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'announce' then
        messagenotfinish = true
        Message()
      end      

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('esx_tabac:getStockItems', function(items)

    print(json.encode(items))

    local elements = {}

    for i=1, #items, 1 do

      local item = items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = 'Tabac Stock',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('esx_tabac:getStockItem', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutStocksMenu()

ESX.TriggerServerCallback('esx_tabac:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('inventory'),
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenPutStocksMenu()

              TriggerServerEvent('esx_tabac:putStockItems', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end


AddEventHandler('esx_tabac:hasEnteredMarker', function(zone)

  if zone == 'TabacActions' then
    CurrentAction     = 'tabac_actions_menu'
    CurrentActionMsg  = _U('open_actions')
    CurrentActionData = {}
  end
  
  if zone == 'SellFarm' and PlayerData.job ~= nil and PlayerData.job.name == 'tabac'  then
    CurrentAction     = 'farm_resell'
    CurrentActionMsg  = _U('press_sell')
    CurrentActionData = {zone = zone}
  end

  if zone == 'Garage' then
    CurrentAction     = 'tabac_harvest_menu'
    CurrentActionMsg  = _U('harvest_menu')
    CurrentActionData = {}
  end

  if zone == 'Craft' then
    CurrentAction     = 'tabac_craft_menu'
    CurrentActionMsg  = _U('craft_menu')
    CurrentActionData = {}
  end

  if zone == 'Craft2' then
    CurrentAction     = 'tabac_craft2_menu'
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

AddEventHandler('esx_tabac:hasExitedMarker', function(zone)
 
  if (zone == 'SellFarm') and PlayerData.job ~= nil and PlayerData.job.name == 'tabac' then
    TriggerServerEvent('esx_tabac:stopSell')
  end

  if zone == 'Craft' then
    TriggerServerEvent('esx_tabac:stopCraft')
    TriggerServerEvent('esx_tabac:stopCraft2')
    TriggerServerEvent('esx_tabac:stopCraft7')
  end

  if zone == 'Craft2' then
    TriggerServerEvent('esx_tabac:stopCraft3')
    TriggerServerEvent('esx_tabac:stopCraft4')
    TriggerServerEvent('esx_tabac:stopCraft5')
    TriggerServerEvent('esx_tabac:stopCraft6')
  end  

  if zone == 'Garage' then
    TriggerServerEvent('esx_tabac:stopHarvest')
    TriggerServerEvent('esx_tabac:stopHarvest2')
    TriggerServerEvent('esx_tabac:stopHarvest3')
  end

  CurrentAction = nil
  ESX.UI.Menu.CloseAll()
end)


RegisterNetEvent('esx_tabac:setTimeDiff')
AddEventHandler('esx_tabac:setTimeDiff', function(time)
  TimeDiff = GetPosixTime() - time 
end)


-- Display markers
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if PlayerData.job ~= nil and PlayerData.job.name == 'tabac' then

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
    if PlayerData.job ~= nil and PlayerData.job.name == 'tabac' then
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
        TriggerEvent('esx_tabac:hasEnteredMarker', currentZone)
      end
      if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('esx_tabac:hasExitedMarker', LastZone)
      end
    end
  end
end)


-- Key Controls
Citizen.CreateThread(function()

  while ESX == nil or not ESX.IsPlayerLoaded() do
    Citizen.Wait(1)
  end

    while true do
        Citizen.Wait(1)

        if CurrentAction ~= nil then

          SetTextComponentFormat('STRING')
          AddTextComponentString(CurrentActionMsg)
          DisplayHelpTextFromStringLabel(0, 0, 1, -1)

          if IsControlJustReleased(0, 38) and PlayerData.job ~= nil and PlayerData.job.name == 'tabac' then

            if CurrentAction == 'tabac_actions_menu' then
                OpenTabacActionsMenu()
            end
            if CurrentAction == 'farm_resell' then
                TriggerServerEvent('esx_tabac:startSell', CurrentActionData.zone)
            end

            if CurrentAction == 'tabac_harvest_menu' then
                OpenTabacHarvestMenu()
            end

            if CurrentAction == 'tabac_craft_menu' then
                OpenTabacCraftMenu()
            end
            
            if CurrentAction == 'tabac_craft2_menu' then
                OpenTabacCraft2Menu()
            end

            if CurrentAction == 'delete_vehicle' then

              if Config.EnableSocietyOwnedVehicles then

                local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
                local playerPed    = GetPlayerPed(-1)
                local vehicle      = GetVehiclePedIsIn(playerPed,  false)
                local hash         = GetEntityModel(vehicle)
                local plate        = GetVehicleNumberPlateText(vehicle)
                TriggerServerEvent('esx_society:putVehicleInGarage', 'tabac', vehicleProps)

              else

                if
                  GetEntityModel(vehicle) == GetHashKey('burrito3')   or
                  GetEntityModel(vehicle) == GetHashKey('brioso') or
                  GetEntityModel(vehicle) == GetHashKey('sultan')
                then
                  TriggerServerEvent('esx_service:disableService', 'tabac')
                end

              end

              ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
              TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
            end

            CurrentAction = nil
          end
        end

        if IsControlJustReleased(0, Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'tabac' then
            OpenFactuTabacActionsMenu()
        end 

        if IsControlJustReleased(0, Keys['DELETE']) and PlayerData.job ~= nil and PlayerData.job.name == 'tabac' then

          local playerPed = GetPlayerPed(-1)
          local coords    = GetEntityCoords(playerPed)
          
          local closestPed, closestDistance = ESX.Game.GetClosestPed({
            x = coords.x,
            y = coords.y,
            z = coords.z
          }, {playerPed})

          -- Fallback code
          if closestDistance == -1 then
            
            print('Using fallback code to find ped')

            local success, ped = GetClosestPed(coords.x,  coords.y,  coords.z,  5.0, 1, 0, 0, 0,  26)

            if DoesEntityExist(ped) then
              local pedCoords = GetEntityCoords(ped)
              closestPed      = ped
              closestDistance = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  pedCoords.x,  pedCoords.y,  pedCoords.z,  true)
            end

          end

          if closestPed ~= -1 and closestDistance <= 5.0 then

            if IsPedInAnyVehicle(closestPed,  false) then
              ESX.ShowNotification('Action ~r~impossible~s~, cette personne est en voiture')
            else

              local playerData    = ESX.GetPlayerData()
              local isBlacklisted = false

              for i=1, #PedBlacklist, 1 do
                if PedBlacklist[i] == closestPed then
                  isBlacklisted = true
                end
              end

              if isBlacklisted then
                ESX.ShowNotification('Vous avez déjà traité avec ce client')
              else

                table.insert(PedBlacklist, closestPed)

                local hasCig = {}

                for i=1, #playerData.inventory, 1 do
                  for j=1, #Config.Cig, 1 do
                    if playerData.inventory[i].name == Config.Cig[j] and playerData.inventory[i].count > 0 then
                      table.insert(hasCig,  Config.Cig[j])
                    end
                  end
                end

                if #hasCig > 0 then

                  local magic = GetRandomIntInRange(1, 100)

                  TaskStandStill(closestPed,  -1)
                  TaskLookAtEntity(closestPed,  playerPed,  -1,  2048,  3)

                  if magic <= 1 then

                    ESX.ShowNotification('Le client a refusé vos cigarettes !')

                    TaskStandStill(closestPed,  -1)

                    ESX.SetTimeout(5000, function()

                      StartWalking(closestPed)

                      ESX.SetTimeout(20000, function()

                        TaskStartScenarioInPlace(closestPed, 'WORLD_HUMAN_STAND_MOBILE', 0, true);

                        TriggerServerEvent('esx_tabac:pedCallPolice')

                        ESX.SetTimeout(20000, function()
                          StartWalking(closestPed)
                        end)

                      end)

                    end)

                  elseif magic <= 30 then
                    
                    ESX.ShowNotification('Le client a acheté vos cigarettes !')
                    StartWalking(closestPed)

                  elseif magic <= 70 then

                    ESX.ShowNotification('Le client a acheté vos cigarettes plus chères !')

                    TriggerServerEvent('esx_tabac:pedBuyCig', false)

                    ESX.SetTimeout(5000, function()
                      StartWalking(closestPed)
                    end)

                  elseif magic <= 90 then

                    PedAttacking = closestPed
                    
                    SetPedAlertness(closestPed,  3)
                    SetPedCombatAttributes(closestPed,  46,  true)

                    ESX.SetTimeout(120000, function()
                      PedAttacking = nil
                    end)

                  else
                    
                    TriggerServerEvent('esx_tabac:pedBuyCig', true)
                    
                    ESX.ShowNotification('Le client a acheté vos cigarettes au prix fort !!')

                    TaskStandStill(closestPed,  -1)

                    ESX.SetTimeout(5000, function()
                      StartWalking(closestPed)
                    end)
                  
                  end

                else
                  ESX.ShowNotification('Vous n\'avez pas vos cigarettes sur vous')
                end

              end

            end

          else
            ESX.ShowNotification('Personne à proximité')
          end

        end

    end
end)


Citizen.CreateThread(function()
  while true do

    Citizen.Wait(1)

    if PedAttacking ~= nil then
      TaskCombatPed(PedAttacking,  GetPlayerPed(-1),  0,  16)
    end

  end
end)


RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Tabac',
		number     = 'tabac',
		base64Icon = 'data:image/png;base64,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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)


----------------------------
---- UTILISER CIGARETTE ----
----------------------------

RegisterNetEvent('esx_tabac:onSmokeCig')
AddEventHandler('esx_tabac:onSmokeCig', function()
  TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING", 0, 1)
  emotePlay = true
  Citizen.Wait(120000)
  ClearPedTasksImmediately(GetPlayerPed(-1))
  emotePlay = false
end)

------------------------
---- UTILISER SPLIF ----
------------------------

--RegisterNetEvent('esx_tabac:onSmokeSplif')
--AddEventHandler('esx_tabac:onSmokeSplif', function()
--  TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, 1)
--  emotePlay = true
--  Citizen.Wait(150000)
--  ClearPedTasksImmediately(GetPlayerPed(-1))
-- emotePlay = false
--end)

-- Splif Effect
RegisterNetEvent('esx_tabac:onSmokeSplif')
AddEventHandler('esx_tabac:onSmokeSplif', function()
    RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
    while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
        Citizen.Wait(1)
        ESX.ShowNotification('Si vous fumez attention au volant..')
    end
    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
    Citizen.Wait(15000)
    DoScreenFadeOut(10000)
    Citizen.Wait(5000)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(GetPlayerPed(-1), true)
    SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
    SetPedIsDrunk(GetPlayerPed(-1), true)
    DoScreenFadeIn(1000)
    Citizen.Wait(600000)
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
    SetPedIsDrunk(GetPlayerPed(-1), false)
    SetPedMotionBlur(GetPlayerPed(-1), false)
end)



function stopEmote()
  ClearPedTasks(GetPlayerPed(-1))
  emotePlay = false
end


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if emotePlay then
      if IsControlJustPressed(1, 22) or IsControlJustPressed(1, 30) or IsControlJustPressed(1, 31) then
        stopEmote()
      end
    end
  end
end)


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
                DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, "~r~ TABAC ~d~", 255, 255, 255, 255, 1, 0)
                DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, texteafiche, 255, 255, 255, 255, 7, 0)
                DrawAdvancedTextCNN(0.588, 0.246, 0.005, 0.0028, 0.4, "", 255, 255, 255, 255, 0, 0)

            end                
       end
    end)



RegisterNetEvent('esx_tabac:annonce')
AddEventHandler('esx_tabac:annonce', function(text)
    texteafiche = text
    affichenews = true
    
  end) 


RegisterNetEvent('esx_tabac:annoncestop')
AddEventHandler('esx_tabac:annoncestop', function()
    affichenews = false
    
  end)

Citizen.CreateThread(function()

  local blip = AddBlipForCoord(Config.Blip.Pos.x, Config.Blip.Pos.y, Config.Blip.Pos.z)

  SetBlipSprite (blip, Config.Blip.Sprite)
  SetBlipDisplay(blip, Config.Blip.Display)
  SetBlipScale  (blip, Config.Blip.Scale)
  SetBlipColour (blip, Config.Blip.Colour)
  SetBlipAsShortRange(blip, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(_U('hospital'))
  EndTextCommandSetBlipName(blip)

end)
