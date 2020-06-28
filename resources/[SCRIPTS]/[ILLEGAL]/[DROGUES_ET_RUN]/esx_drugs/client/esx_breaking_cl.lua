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
local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0
ESX = nil

local LastCar

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_methcar:stop')
AddEventHandler('esx_methcar:stop', function()
	started = false
	DisplayHelpText("~r~Production arrêtée...")
	FreezeEntityPosition(LastCar, false)
end)
RegisterNetEvent('esx_methcar:stopfreeze')
AddEventHandler('esx_methcar:stopfreeze', function(id)
	FreezeEntityPosition(id, false)
end)
RegisterNetEvent('esx_methcar:notify')
AddEventHandler('esx_methcar:notify', function(message)
	ESX.ShowNotification(message)
end)

RegisterNetEvent('esx_methcar:startprod')
AddEventHandler('esx_methcar:startprod', function()
	DisplayHelpText("~g~Demarrage de la Production")
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	print('Début de la production de méthamphétamine')
	ESX.ShowNotification("~y~La production de méthamphétamine à commencé")	
	SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('esx_methcar:blowup')
AddEventHandler('esx_methcar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)
	
end)


RegisterNetEvent('esx_methcar:smoke')
AddEventHandler('esx_methcar:smoke', function(posx, posy, posz, bool)

	if bool == 'a' then

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_h_fire", posx, posy, posz + 0.5, 1.0, 1.0, 1.0, 0.2, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		Citizen.Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end

end)
RegisterNetEvent('esx_methcar:drugged')
AddEventHandler('esx_methcar:drugged', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)

	Citizen.Wait(300000)
	ClearTimecycleModifier()
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if IsPedInAnyVehicle(playerPed) then
			
			
			CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId())

			car = GetVehiclePedIsIn(playerPed, false)
			LastCar = GetVehiclePedIsUsing(playerPed)
	
			local model = GetEntityModel(CurrentVehicle)
			local modelName = GetDisplayNameFromVehicleModel(model)
			
			if modelName == 'JOURNEY' and car then
				
					if GetPedInVehicleSeat(car, -1) == playerPed then
						if started == false then
							if displayed == false then
								DisplayHelpText("Appuyez sur ~INPUT_THROW_GRENADE~ pour commencer à cuisiner.")
								displayed = true
							end
						end
						if IsControlJustReleased(0, Keys['G']) then
							if pos.y >= 0 then
								if IsVehicleSeatFree(CurrentVehicle, 3) then
									TriggerServerEvent('esx_methcar:start')	
									progress = 0
									pause = false
									selection = 0
									quality = 0
									
								else
									DisplayHelpText('~b~Dégage c\'est mon Van')
								end
							else
								ESX.ShowNotification('~y~Vous êtes trop proche de la ville, allez plus au nord pour commencer à produire de la méthamphétamine')
							end
							
							
							
							
		
						end
					end
					
				
				
			
			end
			
		else

				
				if started then
					started = false
					displayed = false
					TriggerEvent('esx_methcar:stop')
					print('Arrêté de faire de la drogue')
					FreezeEntityPosition(LastCar,false)
				end
		end
		
		if started == true then
			
			if progress < 96 then
				Citizen.Wait(6000)
				if not pause and IsPedInAnyVehicle(playerPed) then
					progress = progress +  1
					ESX.ShowNotification('~y~production de méthamphétamine: ~g~~h~' .. progress .. '%')
					Citizen.Wait(6000) 
				end

				--
				--   EVENT 1
				--
				if progress > 22 and progress < 24 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Le tuyau de propane fuit, que faites-vous?')	
						ESX.ShowNotification('~o~1. je le Fixe avec de la ~y~Super Glue')
						ESX.ShowNotification('~o~2. J\'attend en esperant que ça ne ~y~fuit plus')
						ESX.ShowNotification('~o~3. Je remplace ~y~le Tuyau')
						ESX.ShowNotification('~c~Appuyez sur le numéro de votre Choix')
					end
					if selection == 1 then
						print("Sélectionné 1")
						ESX.ShowNotification('~y~La Super Glue à un peu arrêté la fuite')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Sélectionné 2")
						ESX.ShowNotification('~r~Le réservoir de propane a explosé, ~y~Putin de merde...')
						TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Arrêté de faire de la drogue')
					end
					if selection == 3 then
						print("Sélectionné 3")
						ESX.ShowNotification('~b~Bravo, Tu n\'est pas si con que ça')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 5
				--
				if progress > 30 and progress < 32 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Merde tu à renversé une bouteille d\'acétone sur le sol, que faites-tu?')	
						ESX.ShowNotification('~o~1. Sa pue j\'ouvre les fenêtres ... Haa l\'odeur')
						ESX.ShowNotification('~o~2. J\'attend en esperant que ~y~ça ne me tuera pas')
						ESX.ShowNotification('~o~3. Heureusement que j\'ai pris ~y~un masque à Gaz')
						ESX.ShowNotification('~c~Appuyez sur le numéro de votre Choix')
					end
					if selection == 1 then
						print("Sélectionné 1")
						ESX.ShowNotification('~b~Bravo, Tu n\'est pas si con que ça')
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						print("Sélectionné 2")
						ESX.ShowNotification('~r~Quelle con mes poumons')
						pause = false
						TriggerEvent('esx_methcar:drugged')
					end
					if selection == 3 then
						print("Sélectionné 3")
						ESX.ShowNotification('~g~C\'est un moyen facile de résoudre le problème .. Je suppose')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 2
				--
				if progress > 38 and progress < 40 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~La méthamphétamine devient solide trop vite, que faites-tu? ')	
						ESX.ShowNotification('~o~1. ~y~Augmenter la pression')
						ESX.ShowNotification('~o~2. ~y~Augmenter la température')
						ESX.ShowNotification('~o~3. ~y~Baisser la pression')
						ESX.ShowNotification('~c~Appuyez sur le numéro de votre Choix')
					end
					if selection == 1 then
						print("Sélectionné 1")
						ESX.ShowNotification('~r~Quelle con tu veux crevé ou quoi... Réfléchit un peu')
						pause = false
					end
					if selection == 2 then
						print("Sélectionné 2")
						ESX.ShowNotification('~b~Bravo, Tu n\'est pas si con que ça...')
						quality = quality + 5
						pause = false
					end
					if selection == 3 then
						print("Sélectionné 3")
						ESX.ShowNotification('~y~Réduire la pression ne faisait qu\'aggravé les choses...')
						pause = false
						quality = quality -4
					end
				end
				--
				--   EVENT 8 - 3
				--
				if progress > 41 and progress < 43 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Tu à versez accidentellement trop d\'acétone, que faites-tu?')	
						ESX.ShowNotification('~o~1. Tu te branle')
						ESX.ShowNotification('~o~2. J\'essaye de l\'aspiré avec une seringue')
						ESX.ShowNotification('~o~3. J\'ajoute plus de lithium pour équilibré')
						ESX.ShowNotification('~c~Appuyez sur le numéro de votre Choix')
					end
					if selection == 1 then
						print("Sélectionné 1")
						ESX.ShowNotification('~r~Arrète tu m\'énerve')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Sélectionné 2")
						ESX.ShowNotification('~y~Cela a fonctionné mais c\'est encore trop')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Sélectionné 3")
						ESX.ShowNotification('~b~Enfin tu as réussi à équilibrer les deux produits chimiques et son bon à nouveau')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 3
				--
				if progress > 46 and progress < 49 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Tu as trouvé du colorant dans le Van, que faites-tu?')	
						ESX.ShowNotification('~o~1. Je l\'ajoute dans le melange')
						ESX.ShowNotification('~o~2. Je range le colorant')
						ESX.ShowNotification('~o~3. Je le Bois')
						ESX.ShowNotification('~c~Appuyez sur le numéro de votre Choix')
					end
					if selection == 1 then
						print("Sélectionné 1")
						ESX.ShowNotification('~b~Bonne idée, les gens aiment les couleurs')
						quality = quality + 4
						pause = false
					end
					if selection == 2 then
						print("Sélectionné 2")
						ESX.ShowNotification('~y~Ouais ça pourrait détruire le goût de la méthamphétamine')
						pause = false
					end
					if selection == 3 then
						print("Sélectionné 3")
						ESX.ShowNotification('~r~J\'ai un peu mal à la tete, mais ça va aller')
						pause = false
					end
				end
				--
				--   EVENT 4
				--
				if progress > 55 and progress < 58 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Le filtre est bouché, que faites-tu?')	
						ESX.ShowNotification('~o~1. Je le nettoie-le à l\'air comprimé')
						ESX.ShowNotification('~o~2. Je Remplace le filtre')
						ESX.ShowNotification('~o~3. Je le Nettoie avec ma brosse à dents')
						ESX.ShowNotification('~c~Appuyez sur le numéro de votre Choix')
					end
					if selection == 1 then
						print("Sélectionné 1")
						ESX.ShowNotification('~r~L\'air comprimé à pulvérisé de la méthamphétamine sur toi')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Sélectionné 2")
						ESX.ShowNotification('~b~je vais le remplacé c\'est probablement la meilleure option')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Sélectionné 3")
						ESX.ShowNotification('~y~Cela a fonctionné assez bien mais c\'est le bordel')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 5
				--
				if progress > 58 and progress < 60 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Tu as renversé une bouteille d\'acétone sur le sol, que faites-tu?')	
						ESX.ShowNotification('~o~1. J\'ouvre les fenêtres pour me débarrasser de l\'odeur')
						ESX.ShowNotification('~o~2. Je fume une clope')
						ESX.ShowNotification('~o~3. Je mets mon masque à gaz')
						ESX.ShowNotification('~c~Appuyez sur le numéro de votre Choix')
					end
					if selection == 1 then
						print("Sélectionné 1")
						ESX.ShowNotification('~b~Tu as ouvert les fenêtres pour vous débarrasser de l\'odeur')
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						print("Sélectionné 2")
						ESX.ShowNotification('~y~L\'inhalation d\'acétone me fait tourner la tete')
						pause = false
						TriggerEvent('esx_methcar:drugged')
					end
					if selection == 3 then
						print("Sélectionné 3")
						ESX.ShowNotification('~g~C\'est un moyen facile, mais pas sans risque')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 1 - 6
				--
				if progress > 63 and progress < 65 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Le tuyau de propane fuit, que faites-tu?')	
						ESX.ShowNotification('~o~1. Je le Fixe avec du scotch')
						ESX.ShowNotification('~o~2. Je me branle')
						ESX.ShowNotification('~o~3. Je remplace le tuyau')
						ESX.ShowNotification('~c~Appuyez sur le numéro de votre Choix')
					end
					if selection == 1 then
						print("Sélectionné 1")
						ESX.ShowNotification('~y~Le scotch a un peu arrêté la fuite')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Sélectionné 2")
						ESX.ShowNotification('~r~Putain le réservoir de propane a explosé...')
						TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Arrêté de faire de la drogue')
					end
					if selection == 3 then
						print("Sélectionné 3")
						ESX.ShowNotification('~b~Bon travail, le tuyau n\'était pas en bon état')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 4 - 7
				--
				if progress > 71 and progress < 73 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Le filtre est bouché, que faites-tu?')	
						ESX.ShowNotification('~o~1. Je le nettoie à l\'air comprimé')
						ESX.ShowNotification('~o~2. Je Remplace le filtre')
						ESX.ShowNotification('~o~3. Je le nettoie avec ma brosse à dents')
						ESX.ShowNotification('~c~Appuyez sur le numéro de votre Choix')
					end
					if selection == 1 then
						print("Sélectionné 1")
						ESX.ShowNotification('~r~L\'air comprimé à pulvérisé de la méthamphétamine sur toi')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Sélectionné 2")
						ESX.ShowNotification('~b~je vais le remplacé c\'est probablement la meilleure option')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Sélectionné 3")
						ESX.ShowNotification('~y~Cela a fonctionné assez bien mais c\'est le bordel')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 8
				--
				if progress > 76 and progress < 78 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Tu a mis trop d\'acétone, que faites-tu?')	
						ESX.ShowNotification('~o~1. Ca fait rien')
						ESX.ShowNotification('~o~2. J\'aspire le trop d\'acetone')
						ESX.ShowNotification('~o~3. J\'ajoute du lithium pour équilibrer')
						ESX.ShowNotification('~c~Appuyez sur le numéro de votre Choix')
					end
					if selection == 1 then
						print("Sélectionné 1")
						ESX.ShowNotification('~r~La méthamphétamine n\'est pas équilibré')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Sélectionné 2")
						ESX.ShowNotification('~y~Cela a fonctionné mais c\'est encore trop')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Sélectionné 3")
						ESX.ShowNotification('~b~Tu as réussi à équilibrer les deux produits')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 9
				--
				if progress > 82 and progress < 84 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Tu as envie de pissé, que faites-tu?')	
						ESX.ShowNotification('~o~1. Je me retiens')
						ESX.ShowNotification('~o~2. Aller dehors et pissé')
						ESX.ShowNotification('~o~3. Je pisse à l\'intérieur')
						ESX.ShowNotification('~c~Appuyez sur le numéro de votre Choix')
					end
					if selection == 1 then
						print("Sélectionné 1")
						ESX.ShowNotification('~b~Bon travail, tu dois finir la meth puis pissé plus tard')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Sélectionné 2")
						ESX.ShowNotification('~r~Lol tous s\'est renverser...')
						pause = false
						quality = quality - 2
					end
					if selection == 3 then
						print("Sélectionné 3")
						ESX.ShowNotification('~y~Sa pue la pisse, et la meth aussi')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 10
				--
				if progress > 88 and progress < 90 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Je coupe la méthamphétamine avec du verre à la fin tu en n\'auras davantage?')
						ESX.ShowNotification('~o~1. Oui!')
						ESX.ShowNotification('~o~2. Non')
						ESX.ShowNotification('~o~3. Quoi-que?')
						ESX.ShowNotification('~c~Appuyez sur le numéro de votre Choix')
					end
					if selection == 1 then
						print("Sélectionné 1")
						ESX.ShowNotification('~y~Maintenant, tu en as plus')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Sélectionné 2")
						ESX.ShowNotification('~b~Tu est un bon fabricant de méthamphétamine, votre produit est de haute qualité')
						pause = false
						quality = quality + 1
					end
					if selection == 3 then
						print("Sélectionné 3")
						ESX.ShowNotification('~g~C\'est un peu trop, pour moi')
						pause = false
						quality = quality - 1
					end
				end
				
				
				
				
				
				
				
				if IsPedInAnyVehicle(playerPed) then
					TriggerServerEvent('esx_methcar:make', pos.x,pos.y,pos.z)
					if pause == false then
						selection = 0
						quality = quality + 1
						progress = progress +  math.random(1, 2)
						ESX.ShowNotification('~y~Production de méthamphétamine: ~g~~h~' .. progress .. '%')
					end
				else
					TriggerEvent('esx_methcar:stop')
				end

			else
				TriggerEvent('esx_methcar:stop')
				progress = 100
				ESX.ShowNotification('~y~Production de méthamphétamine: ~g~~h~' .. progress .. '%')
				ESX.ShowNotification('~g~~h~Fin de la production')
				TriggerServerEvent('esx_methcar:finish', quality)
				FreezeEntityPosition(LastCar, false)
			end	
			
		end
		
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			else
				if started then
					started = false
					displayed = false
					TriggerEvent('esx_methcar:stop')
					print('Arrêté de faire de la drogue')
					FreezeEntityPosition(LastCar,false)
				end		
			end
	end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)		
		if pause == true then
			if IsControlJustReleased(0, Keys['1']) then
				selection = 1
				ESX.ShowNotification('~g~Option sélectionnée numéro 1')
			end
			if IsControlJustReleased(0, Keys['2']) then
				selection = 2
				ESX.ShowNotification('~g~Option sélectionnée numéro 2')
			end
			if IsControlJustReleased(0, Keys['3']) then
				selection = 3
				ESX.ShowNotification('~g~Option sélectionnée numéro 3')
			end
		end

	end
end)




