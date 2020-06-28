ESX               = nil
local playerCars = {}
local GUI                       = {}
GUI.Time                        = 0
local PlayerData                = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	--blips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	--deleteBlips()
	--blips()
end)

--[[--Menu Mes clés
RegisterNetEvent('esx_menu:key')
AddEventHandler('esx_menu:key', function()
ESX.TriggerServerCallback('esx_vehiclelock:allkey', function(mykey)
	local elements = {}
		for i=1, #mykey, 1 do
			if mykey[i].got == 'true' then 
				if 	mykey[i].NB == 1 then									
						table.insert(elements, {label = 'Clés : '.. ' [' .. mykey[i].plate .. ']', value = mykey[i].plate})
					elseif mykey[i].NB == 2 then
						table.insert(elements, {label = '[DOUBLE] Véhicule : '.. ' [' .. mykey[i].plate .. ']', value = nil})
					end
				end
			end

ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'mykey',
	{css='mescles',
		title = 'Mes clés',
		align = 'left',
		elements = elements
	  },
        function(data2, menu2) --Submit Cb
 
        if data2.current.value ~= nil then
        ESX.UI.Menu.CloseAll()
  			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'mykey',
				{css='mescles',
				title = 'Voulez vous ?',
				align = 'left',
				elements = {
						{label = 'Donner', value = 'donnerkey'}, -- Donné les clés
						{label = 'Préter', value = 'preterkey'}, -- Donné les clés
			  		},
	  			},
        		function(data3, menu3) --Submit Cb
 					local player, distance = ESX.Game.GetClosestPlayer()
 					local playerPed = GetPlayerPed(-1)
					local coords    = GetEntityCoords(playerPed, true)
 					local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 71)
 					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

       				 if data3.current.value == 'donnerkey' then
       					 ESX.UI.Menu.CloseAll()
       					if distance ~= -1 and distance <= 3.0 then
       					  TriggerServerEvent('esx_vehiclelock:donnerkey', GetPlayerServerId(player), data2.current.value)
       					  TriggerServerEvent('esx_vehiclelock:deletekey', data2.current.value)
       					  print("avant changement owner")
       					  TriggerServerEvent('esx_vehiclelock:changeowner', GetPlayerServerId(player), vehicleProps)
       					  print("après changement owner")
       					end
      				 end
      				 if data3.current.value == 'preterkey' then
       					 ESX.UI.Menu.CloseAll()
       					if distance ~= -1 and distance <= 3.0 then 
       					  TriggerServerEvent('esx_vehiclelock:preterkey', GetPlayerServerId(player), data2.current.value)
       					end
      				 end
       			 end,
       			 function(data3, menu3) --Cancel Cb
           		     menu3.close()
       			 end,
       			 function(data3, menu3) --Change Cb
         
        		 end
   			 )
        end
        end,
        
        function(data2, men2) --Cancel Cb
                men2.close()
        end,
        function(dat2, men2) --Change Cb
        end
      )
  end)
end)
--]]
--Menu Mes clés
--
RegisterNetEvent('esx_menu:key')
AddEventHandler('esx_menu:key', function()
ESX.TriggerServerCallback('esx_vehiclelock:allkey', function(mykey)
	--local plate = mykey[i].plate
	local elements = {}
		for i=1, #mykey, 1 do		
			if mykey[i].got == 'true' then 				
				if 	mykey[i].NB == 1 then									
						table.insert(elements, {label = '<span style="color:brown;">Clés véhicule personnel : '.. ' </span><span style="text-align: center">[' .. mykey[i].plate .. ']', value = mykey[i].plate})
					elseif mykey[i].NB == 2 then
						table.insert(elements, {label = '<span style="color:brown;">[DOUBLE] Véhicule personnel : '.. ' </span><span style="text-align: center">[' .. mykey[i].plate .. ']', value = nil})
					end
				end				
			end
ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'mykey',
	{css='mescles',
		title = 'Mes clés',
		align = 'left',
		elements = elements
	  },
        function(data2, menu2) --Submit Cb
 
        if data2.current.value ~= nil then
        ESX.UI.Menu.CloseAll()
  			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'mykey',
				{css='mescles',
				title = 'Voulez vous ?',
				align = 'left',
				elements = {
						{label = 'Prêter un double des clés', value = 'preter'}, -- Donné les clés
						{label = 'Donner les clés du véhicule', value = 'donner'},
						{label = 'Jeter les clés', value = 'jeter'},
			  		},
	  			},
        		function(data3, menu3) --Submit Cb
 					local player, distance = ESX.Game.GetClosestPlayer()
       				if data3.current.value == 'preter' then
       					 ESX.UI.Menu.CloseAll()
       					if distance ~= -1 and distance <= 3.0 then
       					  TriggerServerEvent('esx_vehiclelock:givekey', GetPlayerServerId(player), data2.current.value)
						  ESX.ShowNotification('~g~Vous avez donné un double des clés')
       					else
						  ESX.ShowNotification('~r~Aucun citoyen à proximité')
						end
      				end
					if data3.current.value == 'donner' then
       					 ESX.UI.Menu.CloseAll()
       					if distance ~= -1 and distance <= 3.0 then
       					 TriggerServerEvent('esx_vehiclelock:donnerkey', GetPlayerServerId(player), data2.current.value)
       					 TriggerServerEvent('esx_vehiclelock:deletekey', data2.current.value)
						 ESX.ShowNotification('~g~Vous avez donné les clés.\n~r~Vous ne les avez plus.')
						else
						  ESX.ShowNotification('~r~Aucun citoyen à proximité')
						end
      				end
					if data3.current.value == 'jeter' then
					  TriggerServerEvent('esx_vehiclelock:deletekey', data2.current.value)
					 -- ESX.ShowNotification('~r~Vous avez jeté les clés')
       					 ESX.UI.Menu.CloseAll()						 
					end
				 end,
       			 function(data3, menu3) --Cancel Cb
           		     menu3.close()
       			 end,
       			 function(data3, menu3) --Change Cb
         
        		 end
   			 )
        end
      --[[
		 if
		 
		 ESX.UI.Menu.CloseAll()
  			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'mykey',
				{css='mescles',
				title = 'Voulez vous ?',
				align = 'left',
				elements = {						
						{label = 'Jeter les clés', value = 'jeter'},
			  		},
	  			},
        		function(data3, menu3) --Submit Cb
 					local player, distance = ESX.Game.GetClosestPlayer()
       				if data3.current.value == 'jeter' then
					  --TriggerServerEvent('esx_vehiclelock:deletekey2', data2.current.value)
					  --ESX.ShowNotification('~r~Vous avez jeté les clés')
       					 ESX.UI.Menu.CloseAll()						 
					end
				 end,
       			 function(data3, menu3) --Cancel Cb
           		     menu3.close()
       			 end,
       			 function(data3, menu3) --Change Cb
         
        		 end
   			 )
         end
	  --]]
	  end,
        
        function(data2, men2) --Cancel Cb
                men2.close()
        end,
        function(dat2, men2) --Change Cb
        end
      )
  end)
end)

RegisterNetEvent('esx_menu:key2')
AddEventHandler('esx_menu:key2', function()
ESX.TriggerServerCallback('esx_vehiclelock:allkey', function(mykey)
	local elements = {}
		for i=1, #mykey, 1 do
			if mykey[i].got == 'true' then 				
				if 	mykey[i].NB == 3 then									
						table.insert(elements, {label = '<span style="color:brown;">Clés de société : '.. ' </span><span style="text-align: center">[' .. mykey[i].plate .. ']', value = mykey[i].plate})
					elseif mykey[i].NB == 4 then
						table.insert(elements, {label = '<span style="color:brown;">[DOUBLE] Véhicule de société : '.. ' </span><span style="text-align: center">[' .. mykey[i].plate .. ']', value = nil })
					end
				end				
			end
ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'mykey',
	{css='mescles',
		title = 'Mes clés',
		align = 'left',
		elements = elements
	  },
        function(data2, menu2) --Submit Cb
 
        if data2.current.value ~= nil then
        ESX.UI.Menu.CloseAll()
  			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'mykey',
				{css='mescles',
				title = 'Voulez vous ?',
				align = 'left',
				elements = {
						{label = 'Prêter double des clés pro', value = 'preter2'}, 
						{label = 'Donner les clés pro', value = 'donner'},
						{label = 'Jeter les clés pro', value = 'jeter'},
						},
	  			},
        		function(data3, menu3) --Submit Cb
 					local player, distance = ESX.Game.GetClosestPlayer()
       				if data3.current.value == 'preter2' then
       					 ESX.UI.Menu.CloseAll()
       					if distance ~= -1 and distance <= 3.0 then
       					  TriggerServerEvent('esx_vehiclelock:givekey2', GetPlayerServerId(player), data2.current.value)
						  ESX.ShowNotification('~g~Vous avez donné un double des clés pro')
						else
						  ESX.ShowNotification('~r~Aucun citoyen à proximité')
       					end
      				end
					if data3.current.value == 'donner' then
       					 ESX.UI.Menu.CloseAll()
       					if distance ~= -1 and distance <= 3.0 then
       					  TriggerServerEvent('esx_vehiclelock:donnerkey2', GetPlayerServerId(player), data2.current.value)
       					  TriggerServerEvent('esx_vehiclelock:deletekey2', data2.current.value)
						  ESX.ShowNotification('~g~Vous avez donné les clés.\n~r~Vous ne les avez plus.')
						else
						  ESX.ShowNotification('~r~Aucun citoyen à proximité')
						end
      				end
					if data3.current.value == 'jeter' then
					  TriggerServerEvent('esx_vehiclelock:deletekey2', data2.current.value)
					  --ESX.ShowNotification('~r~Vous avez jeté les clés')
       					 ESX.UI.Menu.CloseAll()						 
					end
				 end,
       			 function(data3, menu3) --Cancel Cb
           		     menu3.close()
       			 end,
       			 function(data3, menu3) --Change Cb
         
        		 end
   			 )
       end
       
--[[
 if 
		 
		 ESX.UI.Menu.CloseAll()
  			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'mykey',
				{css='mescles',
				title = 'Voulez vous ?',
				align = 'left',
				elements = {						
						{label = 'Jeter les clés', value = 'jeter'},
			  		},
	  			},
        		function(data3, menu3) --Submit Cb
 					local player, distance = ESX.Game.GetClosestPlayer()
       				if data3.current.value == 'jeter' then
					 -- TriggerServerEvent('esx_vehiclelock:deletekey4', data2.current.value)
					 -- ESX.ShowNotification('~r~Vous avez jeté les clés')
       					 ESX.UI.Menu.CloseAll()						 
					end
				 end,
       			 function(data3, menu3) --Cancel Cb
           		     menu3.close()
       			 end,
       			 function(data3, menu3) --Change Cb
         
        		 end
   			 )
         end
	  
--]]
	   end,
        
        function(data2, men2) --Cancel Cb
                men2.close()
        end,
        function(dat2, men2) --Change Cb
        end
      )
  end)
end)
--
AddEventHandler('esx_vehiclelock:hasEnteredMarker', function(zone)

	CurrentAction     = 'Serrurier'
	CurrentActionMsg  = 'Serrurier'
	CurrentActionData = {zone = zone}

end)

AddEventHandler('esx_vehiclelock:hasExitedMarker', function(zone)

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()

end)

function OpenCloseVehicle()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed, true)

	local vehicle = nil

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 71)
	end

	ESX.TriggerServerCallback('esx_vehiclelock:mykey', function(gotkey)

		if gotkey then
			local locked = GetVehicleDoorLockStatus(vehicle)
			if locked == 1 or locked == 0 then -- if unlocked
				SetVehicleDoorsLocked(vehicle, 2)	
                SetVehicleLights(vehicle, 2)
                Wait(200)
                SetVehicleLights(vehicle, 0)
                StartVehicleHorn(vehicle, 100, 1, false)
                Wait(200)
                SetVehicleLights(vehicle, 2)
                Wait(400)
                SetVehicleLights(vehicle, 0)	
				-- PlayVehicleDoorCloseSound(vehicle, 1)
				TriggerEvent('InteractSound_CL:PlayOnOne', 'lock', 1.0)
				ESX.ShowNotification("Vous avez ~r~fermé~s~ le véhicule.")
			elseif locked == 2 then -- if locked
				SetVehicleDoorsLocked(vehicle, 1)
				SetVehicleLights(vehicle, 2)
                Wait(200)
                SetVehicleLights(vehicle, 0)
                StartVehicleHorn(vehicle, 100, 1, false)
                Wait(200)
                SetVehicleLights(vehicle, 2)
                Wait(400)
                SetVehicleLights(vehicle, 0)
				-- PlayVehicleDoorOpenSound(vehicle, 0)
				TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 1.0)
				ESX.ShowNotification("Vous avez ~g~ouvert~s~ le véhicule.")
			end
		else
			ESX.ShowNotification("~r~Vous n'avez pas les clés de ce véhicule.")
		end
	end, GetVehicleNumberPlateText(vehicle))
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 303) then -- Touche U 303
			OpenCloseVehicle()
		end
	end
end)

Citizen.CreateThread(function()
    local dict = "anim@mp_player_intmenu@key_fob@"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 303) then -- When you press "U"
               TaskPlayAnim(GetPlayerPed(-1), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
        end
    end
end)

-----------------------------Car Dealer --------------------------------

RegisterNetEvent('esx_menu:keycardealer')
AddEventHandler('esx_menu:keycardealer', function()
ESX.TriggerServerCallback('esx_vehiclelock:allkey', function(mykey)
	local elements = {}
		for i=1, #mykey, 1 do
			if mykey[i].got == 'true' then 
				if 	mykey[i].NB == 3 then									
						table.insert(elements, {label = '[PRO] Clés : '.. ' [' .. mykey[i].plate .. ']', value = mykey[i].plate})
					end
				end
			end

ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'mykey',
	{css='mescles',
		title = 'Clé Pro',
		align = 'left',
		elements = elements
	  },
        function(data2, menu2) --Submit Cb
 
        if data2.current.value ~= nil then
        ESX.UI.Menu.CloseAll()
  			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'mykey',
				{css='mescles',
				title = 'Voulez vous ?',
				align = 'left',
				elements = {{label = 'Donner', value = data2.current.value}, -- Donné un double
			  		},
	  			},
        		function(data3, menu3) --Submit Cb
 					local player, distance = ESX.Game.GetClosestPlayer()

       				 if data3.current.value ~= nil then
       					 ESX.UI.Menu.CloseAll()
       					if distance ~= -1 and distance <= 3.0 then
       					  TriggerServerEvent('esx_vehiclelock:givekeycardealer', GetPlayerServerId(player), data2.current.value)
       					  TriggerServerEvent('esx_vehiclelock:deletekeycardealer', GetPlayerServerId(player), data2.current.value)
       					end
      				 end
       			 end,
        
       			 function(data3, menu3) --Cancel Cb
           		     menu3.close()
       			 end,
       			 function(data3, menu3) --Change Cb
         
        		 end
   			 )
        end
        end,
        function(data2, men2) --Cancel Cb
                men2.close()
        end,
        function(dat2, men2) --Change Cb
        end
      )
  end)
end)

--Menu Serrurier
function OpenSerrurierMenu()

	local elements = {
						{label = ('Faire une nouvelle clé'),	value = 'registerkey'},
					}
	 if PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' then
	 	table.insert(elements, {label = 'Faire une nouvelle clé véhicule de société job', value = 'registerkeyjob'})
     end
	 
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'GetKey',
	{css='mescles',
		title = 'Que voulez vous ? ',
		align = 'left',
		elements = elements
	  },
        function(data, menu) --Submit Cb

        if data.current.value == 'registerkey' and (GetGameTimer() - GUI.Time) > 350 then
					ESX.TriggerServerCallback('esx_vehiclelock:getVehiclesnokey', function(Vehicles2)
						local elements = {}

						if Vehicles2 == nil then
							table.insert(elements, {label = 'Aucun véhicule sans clés ', value = nil})
						else
							for i=1, #Vehicles2, 1 do
								model = Vehicles2[i].model
								modelname = GetDisplayNameFromVehicleModel(model)
								Vehicles2[i].model = GetLabelText(modelname)
							end

							for i=1, #Vehicles2, 1 do
								table.insert(elements, {label = Vehicles2[i].model .. ' [' .. Vehicles2[i].plate .. ']', value = Vehicles2[i].plate})					
							end

							ESX.UI.Menu.Open(
							'default', GetCurrentResourceName(), 'backey',
							{css='mescles',
							title    = 'Faire de nouvelles clés.',
							align    = 'left',
							elements = elements
							},
							function(data2, menu2)
									ESX.UI.Menu.CloseAll()	
									TriggerServerEvent('esx_vehiclelock:registerkey', data2.current.value, 'no')
							end,
							function(data2, menu2)
								menu2.close()
							end
							)
						end
					end)
			end
       
	    if data.current.value == 'registerkeyjob' then
			ESX.TriggerServerCallback('esx_vehiclelock:getVehiclesnokeyjob', function(Vehicles2)
				local elements = {}

				if Vehicles2 == nil then
					table.insert(elements, {label = 'Aucun véhicule sans clés ', value = nil})
				else
					for i=1, #Vehicles2, 1 do
						model = Vehicles2[i].model
						modelname = GetDisplayNameFromVehicleModel(model)
						Vehicles2[i].model = GetLabelText(modelname)
					end
						for i=1, #Vehicles2, 1 do
						table.insert(elements, {label ='<span style="color:brown;">'.. Vehicles2[i].model .. ' </span><span style="text-align: center">[' .. Vehicles2[i].plate .. ']</span>', value = Vehicles2[i].plate})					
						end

					ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'backey',
					{css='mescles',
					title    = '500 $ Pour de nouvelles clés.',
					align    = 'left',
					elements = elements
					},
					function(data2, menu2)
							ESX.UI.Menu.CloseAll()
							TriggerServerEvent('esx_vehiclelock:registerkeyjob', data2.current.value, 'no')
					end,
					function(data2, menu2)
						menu2.close()
					end
					)
				end
			end)
		end
    end,   
        function(data, menu) --Cancel Cb
                menu.close()
        end,
        function(data, menu) --Change Cb
        end
      )
end

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.place.Pos.x, Config.Zones.place.Pos.y, Config.Zones.place.Pos.z)
	SetBlipSprite (blip, 134)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 3)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Serrurier')
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
local blip = AddBlipForCoord(Config.Zones.redline.Pos.x, Config.Zones.redline.Pos.y, Config.Zones.redline.Pos.z)
SetBlipSprite (blip, 134)
SetBlipDisplay(blip, 4)
SetBlipScale  (blip, 1.0)
SetBlipColour (blip, 3)
SetBlipAsShortRange(blip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString('Serrurier')
EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.concess.Pos.x, Config.Zones.concess.Pos.y, Config.Zones.concess.Pos.z)
	SetBlipSprite (blip, 134)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 3)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Serrurier')
	EndTextCommandSetBlipName(blip)
	end)

-- Display markers
Citizen.CreateThread(function()
	while true do

		Wait(0)

			local coords = GetEntityCoords(GetPlayerPed(-1))

			for k,v in pairs(Config.Zones) do
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Wait(0)
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
				TriggerEvent('esx_vehiclelock:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_vehiclelock:hasExitedMarker', LastZone)
			end

		end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString('Appuyez sur  ~INPUT_CONTEXT~ pour ~b~Ouvrir le menu')
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlJustReleased(0, 38) then

        if CurrentAction == 'Serrurier' then
          OpenSerrurierMenu(CurrentActionData.zone)
        end

        CurrentAction = nil

      end

    end
  end
end)

AddEventHandler("esx_vehiclelock:lockUnLockVehicle", function()
	OpenCloseVehicle()
end)