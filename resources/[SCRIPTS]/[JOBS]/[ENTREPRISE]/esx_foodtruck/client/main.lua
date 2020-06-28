-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------

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


local PlayerData                = {}
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local Blips                   = {}
local JobBlips                  = {}
local publicBlip 				= false
local isRecrue                = true
local isInMarker              = false
local isInPublicMarker        = false
local hintIsShowed            = false
local hintToDisplay           = "no hint to display"

ESX                             = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function IsJobTrue()
    if PlayerData ~= nil then
        local IsJobTrue = false
		if PlayerData.job ~=nil and PlayerData.job.name=='foodtruck' then
       -- if PlayerData.job ~= nil and PlayerData.job.name == 'foodtruck' then
            IsJobTrue = true
        end
        return IsJobTrue
    end
end

function IsGradeBoss()
    if PlayerData ~= nil then
        local IsGradeBoss = false
        if PlayerData.job.grade_name == 'boss' then
            IsGradeBoss = true
        end
        return IsGradeBoss
    end
end

function SetVehicleMaxMods(vehicle)

  local props = {
    modEngine       = 0,
    modBrakes       = 0,
    modTransmission = 0,
    modSuspension   = 0,
    modTurbo        = true,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

function setUniform(job, playerPed)
  TriggerEvent('skinchanger:getSkin', function(skin)

    if skin.sex == 0 then
      if Config.Uniforms[job].male ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
	  
   
    else
      if Config.Uniforms[job].female ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
    
    end

  end)
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	blips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlips()
	blips()
end)

function OpenCloakroomMenu()

	local playerPed = GetPlayerPed(-1)
	
    local elements = {
        {label = _U('citizen_wear'), value = 'citizen_wear'},		
        }
	  
    if PlayerData.job ~= nil and PlayerData.job.name == 'foodtruck'  and PlayerData.job.grade_name == 'recruit' then
		table.insert(elements, {label = _U('foodtruck_wear'), value = 'recruit_wear'})
	end
	if PlayerData.job ~= nil and PlayerData.job.name == 'foodtruck' and PlayerData.job.grade_name == 'cook' then
		table.insert(elements, {label = _U('foodtruck_wear2'), value = 'cooking_wear'})
		table.insert(elements, {label = _U('foodtruck_wear'), value = 'recruit_wear'})
	end
    if PlayerData.job ~= nil and PlayerData.job.name == 'foodtruck'  and PlayerData.job.grade_name == 'chief' then
		table.insert(elements, {label = _U('foodtruck_wear3'), value = 'chief_wear'})
		table.insert(elements, {label = _U('foodtruck_wear2'), value = 'cooking_wear'})
		table.insert(elements, {label = _U('foodtruck_wear'), value = 'recruit_wear'})
	end  
    if PlayerData.job ~= nil and PlayerData.job.name == 'foodtruck'  and PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('foodtruck_wear4'), value = 'boss_wear'})
		table.insert(elements, {label = _U('foodtruck_wear3'), value = 'chief_wear'})
		table.insert(elements, {label = _U('foodtruck_wear2'), value = 'cooking_wear'})
		table.insert(elements, {label = _U('foodtruck_wear'), value = 'recruit_wear'})
	end
  
  
  ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'cloakroom',
      {css= 'vestiaire',
        title    = _U('cloakroom'),
        align    = 'top-left',
        elements = elements,
        },
        function(data, menu)
		
			cleanPlayer(playerPed)
			
	if data.current.value == 'citizen_wear' then
      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			local model = nil
			
             if skin.sex == 0 then
            model = GetHashKey("mp_m_freemode_01")
          else
            model = GetHashKey("mp_f_freemode_01")
          end
		
		 RequestModel(model)
          while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(1)
          end

          SetPlayerModel(PlayerId(), model)
          SetModelAsNoLongerNeeded(model)

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
          local playerPed = GetPlayerPed(-1)
        end)
      end
		
		 if
        data.current.value == 'recruit_wear' or
        data.current.value == 'cooking_wear' or
		data.current.value == 'chief_wear' or
        data.current.value == 'boss_wear' 
		 then
		 
        setUniform(data.current.value, playerPed)
      end
	
	  	  
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}
    end
  )
end

function OpenFridgeMenu()

    local elements = {
      {label = _U('get_object'), value = 'society_inventory'},
      {label = _U('put_object'), value = 'player_inventory'}
    }
    

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'fridge',
      {css= 'metier',
        title    = _U('fridge'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

	    if data.current.value == 'society_inventory' then
           OpenSocietyInventoryMenu()
        end
		
        if data.current.value == 'player_inventory' then
          OpenPlayerInventoryMenu()
        end   
      end,
      
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_fridge'
        CurrentActionMsg  = _U('open_fridge')
        CurrentActionData = {}
      end
    )

end

function OpenFoodTruckActionsMenu()
			
	if Config.EnableVaultManagement then

	local elements = {
		{label = _U('vehicle_list'),   value = 'vehicle_list'},
		{label = _U('create_bill'),    value = 'create_bill'},		
		{label = _U('crafting'),     value = 'menu_crafting'},
		{label = _U('put_weapon'),     value = 'put_weapon'}
	}
	
	--if PlayerData.job.name == 'foodtruck' and (PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'chief' or PlayerData.job.grade_name == 'cook') then
	--	table.insert(elements,
	--	{label = _U('crafting'),    value = 'menu_crafting'})
	--	end
	
	if PlayerData.job.name == 'foodtruck' and PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'chief'  then
		table.insert(elements,
		{label = _U('buy_weapons'), value = 'buy_weapons'})
	    end
		
	if PlayerData.job.name == 'foodtruck' and PlayerData.job.grade_name == 'boss'  then
		table.insert(elements,
		{label = _U('boss_actions'), value = 'boss_actions'})		
		end
		
	if PlayerData.job.name == 'foodtruck' and PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'chief' then	
		table.insert(elements,
		{label = _U('get_weapon'),     value = 'get_weapon'})
		end
		
	if IsJobTrue() and IsGradeBoss() then
		table.insert(elements,
		{label = _U('boss_actions'), value = 'boss_actions'})		
		end
	
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'foodtruck_actions',
		{css= 'entreprise',
			title    = _U('blip_foodtruck'),
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)
			if data.current.value == 'vehicle_list' then		
				local vehicles = Config.Zones.VehicleSpawnPoint
				if Config.EnableSocietyOwnedVehicles then

    local elements = {}

	
    ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
      for i=1, #vehicles, 1 do
        table.insert(elements, {
          label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
          value = vehicles[i]
        })
      end


      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', 
      {css = 'vehicle',
        title    = _U('service_vehicle'),
        align    = 'top-left',
        elements = elements
      }, function(data, menu)
        menu.close()
        local vehicleProps = data.current.value

        ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 222.728, function(vehicle)
          ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
          local playerPed = PlayerPedId()
          TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
        end)

        TriggerServerEvent('esx_society:removeVehicleFromGarage', 'foodtruck', vehicleProps)
      end, function(data, menu)
        menu.close()
      end)
    end, 'foodtruck')

  else				
				local elements = {
          {label = 'FoodTruck', value = 'taco'},
          {label = 'Voiture Patron', value = 'stalion2'}
				}

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', 
				{css='vehicle',
					title    = _U('service_vehicle'),
					align    = 'top-left',
					elements = elements
				}, function(data, menu)
					if Config.MaxInService == -1 then
					    local platenum = math.random(1000, 9999)
              local platePrefix = Config.platePrefix
					    ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 222.728, function(vehicle)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							SetVehicleMaxMods(vehicle)
							SetVehicleLivery(vehicle, 1)
							SetVehicleDirtLevel(vehicle, 0)
						  SetVehicleNumberPlateText(vehicle, platePrefix .. platenum)
					    plate = GetVehicleNumberPlateText(vehicle)
							plate = string.gsub(plate, " ", "")
							TriggerServerEvent('esx_vehiclelock:registerkeyjob', plate, 'no') -- vehicle lock
						end)
					else
						ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
							if canTakeService then
								ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 50.360, function(vehicle)
									local playerPed = PlayerPedId()
									TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
								end)
							else
								ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
							end
						end, 'foodtruck')
					end

					menu.close()
				end, function(data, menu)
					menu.close()
					OpenFoodtruckActionsMenu()
				end)
			end
end

-----------------------------------------------------------------------------------------------------------			
			if data.current.value == 'create_bill' then

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'foodtruck_billing',
          {
            title = _U('invoice_amount'),
          },
          function (data2, menu)

            local amount = tonumber(data2.value)

            if amount == nil then
              ESX.ShowNotification(_U('invoice_amount'))
            else
              menu.close()

              local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification(_U('invoice_amount'))
              else
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_foodtruck', _U('facture_foodtruck'), tonumber(data2.value))
              end
            end
          end,
          function (data2, menu)
            menu.close()
          end
        )
      end
			
			if data.current.value == 'get_weapon' then
				OpenGetWeaponMenu()
			end

			if data.current.value == 'put_weapon' then
				OpenPutWeaponMenu()
			end
		
			if data.current.value == 'buy_weapons' then
				OpenBuyWeaponsMenu(station)
			end
	
			if data.current.value == 'boss_actions' then

                TriggerEvent('esx_society:openBossMenu', 'foodtruck', function(data, menu)
                    menu.close()
                end, {wash = false})

            end
			
			if data.current.value == 'menu_crafting' then
        
          ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'menu_crafting',
              {css= 'entreprise',
                  title = _U('crafting'),
                  align = 'top-left',
                  elements = {
                      {label = _U('haydari'),       	value = 'haydari'},--
                      {label = _U('cacik'),   			value = 'cacik'},--
                      {label = _U('karides'),   		value = 'karides'},--
					  {label = _U('salade'),  			value = 'salade'},--
					  {label = _U('wrap'),  			value = 'wrap'},--
                      {label = _U('chips'),  			value = 'chips'},--
					  {label = _U('tacos'),     		value = 'tacos'},
					  {label = _U('fishburger'),  		value = 'fishburger'},--
					  {label = _U('pizza'),  			value = 'pizza'},
                      {label = _U('couscousa'),   	 	value = 'couscousa'},--
					  {label = _U('couscousp'),   	 	value = 'couscousp'},--
					  {label = _U('couscousm'),   	 	value = 'couscousm'},--
					  {label = _U('nuggetss'),  		value = 'nuggetss'},--
					  {label = _U('kebab'),  			value = 'kebab'},--
                      {label = _U('burger'),  			value = 'burger'},--
                      {label = _U('tajine_agneau'),     value = 'tajine'},--
                      {label = _U('iskender'),        	value = 'iskender'},
                      {label = _U('dame_blanche'),      value = 'dame_blanche'},--
                      {label = _U('banana_split'),      value = 'banana_split'},--
                      {label = _U('coupe_anglaise'),    value = 'coupe_anglaise'},--
					  {label = _U('donuts'),  			value = 'donuts'},--
					  {label = _U('batonnets_de_mozzarella'),  			value = 'batonnets_de_mozzarella'},--
{label = _U('oignon_rings'),  			value = 'oignon_rings'},--
{label = _U('mais_grille'),  			value = 'mais_grille'},--
{label = _U('chicken_wings'),  			value = 'chicken_wings'},--
{label = _U('sunny_cheese_fries'),  			value = 'sunny_cheese_fries'},--
{label = _U('salade_de_tomates'),  			value = 'salade_de_tomates'},--
{label = _U('salade_cobb'),  			value = 'salade_cobb'},--
{label = _U('salade_cesar'),  			value = 'salade_cesar'},--
{label = _U('salade_marilyn'),  			value = 'salade_marilyn'},--
{label = _U('jambon_grille'),  			value = 'jambon_grille'},--
{label = _U('chief_steak'),  			value = 'chief_steak'},--
{label = _U('chicken_delight'),  			value = 'chicken_delight'},--
{label = _U('brochette'),  			value = 'brochette'},--
{label = _U('ribs'),  			value = 'ribs'},--
{label = _U('toasty_cheese'),  			value = 'toasty_cheese'},--
{label = _U('cheese'),  			value = 'cheese'},--
{label = _U('fish'),  			value = 'fish'},--
{label = _U('new_sunny'),  			value = 'new_sunny'},--
{label = _U('mountain'),  			value = 'mountain'},--
{label = _U('fish_and_chips'),  			value = 'fish_and_chips'},--
{label = _U('americain_eggs'),  			value = 'americain_eggs'},--
{label = _U('delicious_chicken'),  			value = 'delicious_chicken'},--
{label = _U('americain_hot_dog'),  			value = 'americain_hot_dog'},--
{label = _U('macaroni_cheese'),  			value = 'macaroni_cheese'},--
{label = _U('chicken_wrap'),  			value = 'chicken_wrap'},--
{label = _U('patty_melt'),  			value = 'patty_melt'},--
{label = _U('blue_beef_wrap'),  			value = 'blue_beef_wrap'},--
{label = _U('milkshake'),  			value = 'milkshake'},--
{label = _U('smoothie'),  			value = 'smoothie'},--
{label = _U('sundae'),  			value = 'sundae'},--
{label = _U('cookie'),  			value = 'cookie'},--
{label = _U('brownie'),  			value = 'brownie'},--
{label = _U('pancakes'),  			value = 'pancakes'},--
{label = _U('churros'),  			value = 'churros'},--
{label = _U('tutti_frutti'),  			value = 'tutti_frutti'},--
{label = _U('cheesecake'),  			value = 'cheesecake'},--	 
					 
					   
                  }
              },
              function(data2, menu2)
            
                TriggerServerEvent('esx_foodtruck:craftingCoktails', data2.current.value)
                animsAction({ lib = "mini@drinking", anim = "shots_barman_b" })
      
              end,
              function(data2, menu2)
                  menu2.close()
              end
          )
      end
			
			
		end,
		function(data, menu)
			menu.close()
			CurrentAction     = 'foodtruck_actions_menu'
			CurrentActionMsg  = _U('foodtruck_actions_menu')
			CurrentActionData = {}
		end
	)
	
	else

    local elements = {}

    for i=1, #Config.AuthorizedWeapons, 1 do
      local weapon = Config.AuthorizedWeapons[i]
      table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {css= 'entreprise',
        title    = _U('armory'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)
        local weapon = data.current.value
        TriggerServerEvent('foodtruck:giveWeapon', weapon,  1000)
      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}
		
		end
)
      end
    
		
  end
--f6
function OpenMobileFoodTruckActionsMenu()

	  local elements = {}

    table.insert(elements, {label = _U('billing'),    value = 'billing'})
    table.insert(elements, {label = "Point de livraison", value = 'gps'})
	if (isRecrue) then
		table.insert(elements, {label = _U('crafting'),    value = 'menu_crafting'})
	
	end
  ESX.UI.Menu.CloseAll()
  
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mobile_foodtruck_actions',
		{css= 'job',
			title    = _U('blip_foodtruck'),
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)
			
			if data.current.value == 'billing' then
				OpenFoodTruckBilling()
      end

      if data.current.value == 'gps' then
        x, y, z = Config.Zones.Delivery.Pos.x, Config.Zones.Delivery.Pos.y, Config.Zones.Delivery.Pos.z
        SetNewWaypoint(x, y, z)
        local source = GetPlayerServerId();
  
        exports.pNotify:SendNotification({text = "<b style='color:grey'>Revival</b><br><br>⭐ Destination ajouté au GPS !", type = "success"})
      end

		if data.current.value == 'menu_crafting' then
        
          ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'menu_crafting',
              {css= 'job',
                  title = _U('crafting'),
                  align = 'top-left',
                  elements = {
{label = _U('haydari'),       	value = 'haydari'},
{label = _U('cacik'),   			value = 'cacik'},
{label = _U('karides'),   		value = 'karides'},
{label = _U('salade'),  			value = 'salade'},
{label = _U('wrap'),  			value = 'wrap'},
{label = _U('chips'),  			value = 'chips'},
{label = _U('tacos'),     		value = 'tacos'},
{label = _U('fishburger'),  		value = 'fishburger'},
{label = _U('pizza'),  			value = 'pizza'},
{label = _U('couscousa'),   	 	value = 'couscousa'},
{label = _U('couscousp'),   	 	value = 'couscousp'},
{label = _U('couscousm'),   	 	value = 'couscousm'},
{label = _U('nuggetss'),  		value = 'nuggetss'},
{label = _U('kebab'),  			value = 'kebab'},
{label = _U('burger'),  			value = 'burger'},
{label = _U('tajine_agneau'),     value = 'tajine'},
{label = _U('iskender'),        	value = 'iskender'},
{label = _U('dame_blanche'),      value = 'dame_blanche'},
{label = _U('banana_split'),      value = 'banana_split'},
{label = _U('coupe_anglaise'),    value = 'coupe_anglaise'},
{label = _U('donuts'),  			value = 'donuts'},	
{label = _U('batonnets_de_mozzarella'),  			value = 'batonnets_de_mozzarella'},	
{label = _U('oignon_rings'),  			value = 'oignon_rings'},
{label = _U('mais_grille'),  			value = 'mais_grille'},
{label = _U('chicken_wings'),  			value = 'chicken_wings'},
{label = _U('sunny_cheese_fries'),  			value = 'sunny_cheese_fries'},
{label = _U('salade_de_tomates'),  			value = 'salade_de_tomates'},
{label = _U('salade_cobb'),  			value = 'salade_cobb'},
{label = _U('salade_cesar'),  			value = 'salade_cesar'},
{label = _U('salade_marilyn'),  			value = 'salade_marilyn'},
{label = _U('jambon_grille'),  			value = 'jambon_grille'},
{label = _U('chief_steak'),  			value = 'chief_steak'},
{label = _U('chicken_delight'),  			value = 'chicken_delight'},
{label = _U('brochette'),  			value = 'brochette'},
{label = _U('ribs'),  			value = 'ribs'},
{label = _U('toasty_cheese'),  			value = 'toasty_cheese'},
{label = _U('cheese'),  			value = 'cheese'},
{label = _U('fish'),  			value = 'fish'},
{label = _U('new_sunny'),  			value = 'new_sunny'},
{label = _U('mountain'),  			value = 'mountain'},
{label = _U('fish_and_chips'),  			value = 'fish_and_chips'},
{label = _U('americain_eggs'),  			value = 'americain_eggs'},
{label = _U('delicious_chicken'),  			value = 'delicious_chicken'},
{label = _U('americain_hot_dog'),  			value = 'americain_hot_dog'},
{label = _U('macaroni_cheese'),  			value = 'macaroni_cheese'},
{label = _U('chicken_wrap'),  			value = 'chicken_wrap'},
{label = _U('patty_melt'),  			value = 'patty_melt'},
{label = _U('blue_beef_wrap'),  			value = 'blue_beef_wrap'},
{label = _U('milkshake'),  			value = 'milkshake'},
{label = _U('smoothie'),  			value = 'smoothie'},
{label = _U('sundae'),  			value = 'sundae'},
{label = _U('cookie'),  			value = 'cookie'},
{label = _U('brownie'),  			value = 'brownie'},
{label = _U('pancakes'),  			value = 'pancakes'},
{label = _U('churros'),  			value = 'churros'},
{label = _U('tutti_frutti'),  			value = 'tutti_frutti'},
{label = _U('cheesecake'),  			value = 'cheesecake'},
				  
                  }
              },
              function(data2, menu2)
            
                TriggerServerEvent('esx_foodtruck:craftingCoktails', data2.current.value)
                animsAction({ lib = "mini@drinking", anim = "shots_barman_b" })
      
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

end
   
function OpenFoodTruckBilling()
	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'billing',
		{
			title = _U('bill_amount')
		},
		function(data, menu)
			local amount = tonumber(data.value)
			if amount == nil then
				ESX.ShowNotification(_U('invalid_amount'))
			else							
				menu.close()							
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 3.0 then
					ESX.ShowNotification(_U('no_player_nearby'))
				else
					TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_foodtruck', 'Foodtruck', amount)
				end
			end
		end,
	function(data, menu)
		menu.close()
	end
	)
end

function OpenSocietyInventoryMenu()

  ESX.TriggerServerCallback('esx_foodtruck:getFoodtruckInventory', function(inventory)

    local elements = {}

    table.insert(elements, {label = _U('dirty_money') .. inventory.blackMoney, type = 'item_account', value = 'black_money'})

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    for i=1, #inventory.weapons, 1 do
      local weapon = inventory.weapons[i]
      table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name) .. ' [' .. weapon.ammo .. ']', type = 'item_weapon', value = weapon.name, ammo = weapon.ammo})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'society_inventory',
      {css= 'entreprise',
        title    = _U('inventory'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        if data.current.type == 'item_weapon' then

          menu.close()

          TriggerServerEvent('esx_foodtruck:getItem',  data.current.type, data.current.value, data.current.ammo)

          ESX.SetTimeout(300, function()
            OpenSocietyInventoryMenu()
          end)

        else

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'get_item_count',
            {
              title = _U('amount'),
            },
            function(data2, menu)

              local quantity = tonumber(data2.value)

              if quantity == nil then
                ESX.ShowNotification(_U('amount_invalid'))
              else

                menu.close()

                TriggerServerEvent('esx_foodtruck:getItem', data.current.type, data.current.value, quantity)

                ESX.SetTimeout(300, function()
                  OpenSocietyInventoryMenu()
                end)

              end

            end,
            function(data2,menu)
              menu.close()
            end
          )

        end

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)
  

end

function OpenPlayerInventoryMenu()

  ESX.TriggerServerCallback('esx_foodtruck:getPlayerInventory', function(inventory)

    local elements = {}

    table.insert(elements, {label = _U('dirty_money') .. inventory.blackMoney, type = 'item_account', value = 'black_money'})

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    local playerPed  = GetPlayerPed(-1)
    local weaponList = ESX.GetWeaponList()

    for i=1, #weaponList, 1 do

      local weaponHash = GetHashKey(weaponList[i].name)

      if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
        local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
        table.insert(elements, {label = weaponList[i].label .. ' [' .. ammo .. ']', type = 'item_weapon', value = weaponList[i].name, ammo = ammo})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'player_inventory',
      {css= 'entreprise',
        title    = _U('inventory'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        if data.current.type == 'item_weapon' then

          menu.close()

          TriggerServerEvent('esx_foodtruck:putItem',  data.current.type, data.current.value, data.current.ammo)

          ESX.SetTimeout(300, function()
            OpenPlayerInventoryMenu()
          end)

        else

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'put_item_count',
            {
              title = _U('amount'),
            },
            function(data2, menu)

              menu.close()

              TriggerServerEvent('esx_foodtruck:putItem', data.current.type, data.current.value, tonumber(data2.value))

              ESX.SetTimeout(300, function()
                OpenPlayerInventoryMenu()
              end)

            end,
            function(data2,menu)
              menu.close()
            end
          )

        end

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenGetWeaponMenu()

  ESX.TriggerServerCallback('foodtruck:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {css= 'entreprise',
        title    = _U('get_weapon_menu'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('foodtruck:removeArmoryWeapon', function()
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
    {css= 'entreprise',
      title    = _U('put_weapon_menu'),
      align    = 'top-left',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('foodtruck:addArmoryWeapon', function()
        OpenPutWeaponMenu()
      end, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenBuyWeaponsMenu(station)

  ESX.TriggerServerCallback('foodtruck:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #Config.AuthorizedWeapons, 1 do

      local weapon = Config.AuthorizedWeapons[i]
      local count  = 0

      for i=1, #weapons, 1 do
        if weapons[i].name == weapon.name then
          count = weapons[i].count
          break
        end
      end

      table.insert(elements, {label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price, value = weapon.name, price = weapon.price})

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_buy_weapons',
      {css= 'entreprise',
        title    = _U('buy_weapon_menu'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        ESX.TriggerServerCallback('foodtruck:buy', function(hasEnoughMoney)

          if hasEnoughMoney then
            ESX.TriggerServerCallback('foodtruck:addArmoryWeapon', function()
              OpenBuyWeaponsMenu(station)
            end, data.current.value)
          else
            ESX.ShowNotification(_U('not_enough_money'))
          end

        end, data.current.price)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenShopMenu(zone)

    local elements = {}
    for i=1, #Config.Zones[zone].Items, 1 do

        local item = Config.Zones[zone].Items[i]

        table.insert(elements, {
            label     = item.label .. ' - <span style="color:green;">$' .. item.price .. ' </span>',
            realLabel = item.label,
            value     = item.name,
            price     = item.price
        })

    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'foodtruck_shop',
        {css= 'shop',
            title    = _U('shop'),
			align    = 'top-left',
            elements = elements
        },
        function(data, menu)
            TriggerServerEvent('esx_foodtruck:buyItem', data.current.value, data.current.price, data.current.realLabel)
        end,
        function(data, menu)
            menu.close()
        end
    )

end

function animsAction(animObj)
    Citizen.CreateThread(function()
        if not playAnim then
            local playerPed = GetPlayerPed(-1);
            if DoesEntityExist(playerPed) then -- Check if ped exist
                dataAnim = animObj

                -- Play Animation
                RequestAnimDict(dataAnim.lib)
                while not HasAnimDictLoaded(dataAnim.lib) do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded(dataAnim.lib) then
                    local flag = 0
                    if dataAnim.loop ~= nil and dataAnim.loop then
                        flag = 1
                    elseif dataAnim.move ~= nil and dataAnim.move then
                        flag = 49
                    end

                    TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                    playAnimation = true
                end

                -- Wait end animation
                while true do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                        playAnim = false
                        TriggerEvent('ft_animation:ClFinish')
                        break
                    end
                end
            end -- end ped exist
        end
    end)
end

AddEventHandler('esx_foodtruck:hasEnteredMarker', function(zone)
	if Config.EnableVaultManagement and IsJobTrue then
	if zone == 'Actions' then
		CurrentAction     = 'foodtruck_actions_menu'
		CurrentActionMsg  = _U('foodtruck_menu')
		CurrentActionData = {}
	end
	end
	 if zone == 'Cloakrooms' and IsJobTrue then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
    end
	if zone == 'Fridge' then
		CurrentAction     = 'menu_fridge'
		CurrentActionMsg  = _U('open_fridge')
		CurrentActionData = {}
    end

	  if zone == 'Delivery' then
      CurrentAction     = 'menu_delivery'
      CurrentActionMsg  = _U('msg_delivery')
      CurrentActionData = {}
    end

	  if zone == 'Meat' or zone == 'NoAlcool'  or zone == 'Dessert' or zone == 'Vegetables' then
      CurrentAction     = 'menu_shop'
      CurrentActionMsg  = _U('shop_menu')
      CurrentActionData = {zone = zone}
    end
	
	  if zone == 'VehicleDeleter' and IsJobTrue then
      local playerPed = PlayerPedId()

      if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed,  false)
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('veh_stored')
        CurrentActionData = {vehicle = vehicle}
      end

    end
end)

AddEventHandler('esx_foodtruck:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('blip_foodtruck'),
		number     = 'foodtruck',
		--base64Icon = 'data:image/png;base64,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'
	}
	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- Delete Blips
function deleteBlips() --
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
		RemoveBlip(JobBlips[i])
		JobBlips[i] = nil
		end
	end
end
-- Create Blips
Citizen.CreateThread(function()		
	local blip = AddBlipForCoord(Config.Zones.Actions.Pos.x, Config.Zones.Actions.Pos.y, Config.Zones.Actions.Pos.z)
	SetBlipSprite (blip, 479)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_foodtruck'))
  EndTextCommandSetBlipName(blip)
end)

function blips()		

	--[[if publicBlip == false then
		local blipMarker = Config.Blips.Blip
	  local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

    SetBlipSprite (blipCoord, blipMarker.Sprite)
    SetBlipDisplay(blipCoord, blipMarker.Display)
    SetBlipScale  (blipCoord, blipMarker.Scale)
    SetBlipColour (blipCoord, blipMarker.Colour)
    SetBlipAsShortRange(blipCoord, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_foodtruck'))
	EndTextCommandSetBlipName(blipCoord)
		publicBlip = true
	]]--end
	
	if PlayerData.job ~= nil and PlayerData.job.name == 'foodtruck' then

		for k,v in pairs(Config.Zones)do
			if v.Type == 23 then
				local blip2 = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)

				SetBlipSprite (blip2, 85)
				SetBlipDisplay(blip2, 4)
				SetBlipScale  (blip2, 0.8)
				SetBlipColour (blip2, 5)
				SetBlipAsShortRange(blip2, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(v.Name)
				EndTextCommandSetBlipName(blip2)
				table.insert(JobBlips, blip2)
			end
		end
	end
end

-- Display markers
Citizen.CreateThread(function()
    while true do

        Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            for k,v in pairs(Config.Zones) do
				if IsJobTrue() then
                if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
                    DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, false, false, false, false)
                end
            end
        end
    end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
    while true do

        Wait(0)
        if IsJobTrue() then

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
                TriggerEvent('esx_foodtruck:hasEnteredMarker', currentZone)
            end

            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent('esx_foodtruck:hasExitedMarker', LastZone)
            end

        end

    end
end)


------------------------------------------------------------------
function OpenDeliveryMenu()

  local elements = {}
  for i=1, #Config.Zones.Delivery.Items, 1 do

    local item = Config.Zones.Delivery.Items[i]

    table.insert(elements, {
      label     = item.label,
      realLabel = item.label,
      value     = item.name,
      price     = item.price
    })

  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'foodtruck_delivery',
    {
      title    = _U('delivery'),
      align = 'top-left',
      elements = elements
    },
    function(data, menu)
      animsAction({lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper"})
      TriggerServerEvent('esx_foodtruck:sellItem', data.current.value, data.current.price, data.current.realLabel)

    end,
    function(data, menu)
      menu.close()
    end
  )

end
-----------------------------------------------------------------------------


-- Key Controls
Citizen.CreateThread(function()

    while true do
	
        Citizen.Wait(0)
		
        if CurrentAction ~= nil then
		
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            
             if IsControlJustReleased(0,  Keys['E']) and IsJobTrue() then
			
				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
        end
        
				if CurrentAction == 'menu_delivery' then
          OpenDeliveryMenu()
        end

				if CurrentAction == 'menu_fridge' then
					OpenFridgeMenu()
				end
				
				if CurrentAction == 'menu_shop' then
					OpenShopMenu(CurrentActionData.zone)
				end  

				if CurrentAction == 'delete_vehicle' then
          if Config.EnableSocietyOwnedVehicles then

						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'foodtruck', vehicleProps)

					else

						if
						    GetEntityModel(vehicle) == GetHashKey('taco') 
						then
							TriggerServerEvent('esx_service:disableService', 'foodtruck')
						end

					end
          TriggerServerEvent('esx_vehiclelock:deletekey2', plate, 'no')
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

        end	       
				
				if CurrentAction == 'foodtruck_actions_menu' then
                    OpenFoodTruckActionsMenu()
				end
				
			   CurrentAction = nil

            end
            
        end
		
		    if IsControlJustReleased(0,  Keys['F6']) and (PlayerData.job ~=nil and PlayerData.job.name=='foodtruck') and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'foodtruck_actions') then
        --if IsControlJustReleased(0, 167) and PlayerData.job ~= nil and PlayerData.job.name == 'foodtruck' then
            OpenMobileFoodTruckActionsMenu()
        end

    end
end)
