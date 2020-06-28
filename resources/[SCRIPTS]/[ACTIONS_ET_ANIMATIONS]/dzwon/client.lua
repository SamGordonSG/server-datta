isBlackedOut = false
injuredTime = 0

oldBodyDamage = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = GetPlayerPed(-1)

		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if DoesEntityExist(vehicle) then
			if not GetPlayerInvincible(PlayerId()) then
				local vehicleClass = GetVehicleClass(vehicle)
				if (vehicleClass >= 0 and vehicleClass <= 12) or vehicleClass == 17 or vehicleClass == 18 or vehicleClass == 20 then
					local currentDamage = GetVehicleEngineHealth(vehicle)
					if currentDamage ~= oldBodyDamage then
						if not isBlackedOut and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= 300) then
							local damage = oldBodyDamage - currentDamage
							isBlackedOut = true
							SendNUIMessage({
								transaction = 'play'
							})

							NetworkSetVoiceChannel(0)
							Citizen.CreateThread(function()
								DoScreenFadeOut(100)
								StartScreenEffect('DeathFailOut', 0, true)
								SetTimecycleModifier("hud_def_blur")
								SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
								Citizen.Wait(1000)
								ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
								DoScreenFadeIn(1000)
								Citizen.Wait(750)

								DoScreenFadeOut(100)
								Citizen.Wait(750)
								ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
								DoScreenFadeIn(750)
								Citizen.Wait(500)

								DoScreenFadeOut(100)
								Citizen.Wait(500)
								ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
								DoScreenFadeIn(500)
								Citizen.Wait(350)

								DoScreenFadeOut(100)
								Citizen.Wait(150)
								StopScreenEffect('DeathFailOut')
								DoScreenFadeIn(250)

								injuredTime = math.min(20, math.floor(damage / 20 + 0.5))
								Citizen.InvokeNative(0xE036A705F989E049)
								isBlackedOut = false
							end)
						end

						oldBodyDamage = currentDamage
					end
				end
			end
		else
			oldBodyDamage = 0
		end

		if isBlackedOut then
			DisableControlAction(0,71,true) -- veh forward
			DisableControlAction(0,72,true) -- veh backwards
			DisableControlAction(0,63,true) -- veh turn left
			DisableControlAction(0,64,true) -- veh turn right
			DisableControlAction(0,75,true) -- disable exit vehicle
		end

		if injuredTime > 0 then
			SetPedMovementClipset(playerPed, "move_m@injured", 1.0)
			ShakeGameplayCam("DRUNK_SHAKE", 3.0)

			repeat
				injuredTime = injuredTime - 1
				if math.random(1, 100) < 50 then
					Citizen.CreateThread(function()
						ClearTimecycleModifier()
						SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
						Citizen.Wait((20 - injuredTime) * 50)
						SetTimecycleModifier("hud_def_blur")
					end)
				end

				SetPedToRagdoll(playerPed, 200, 200, 3, true, false, false)
				Citizen.Wait(1400)
			until injuredTime == 0

			ClearTimecycleModifier()
			SendNUIMessage({
				transaction = 'fade',
				time = 3000
			})

			StopGameplayCamShaking(true)
			ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
			ResetPedMovementClipset(playerPed, 0.0)
		end
	end
end)