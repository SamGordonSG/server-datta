local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("siege", function(source, args, raw) --change command here
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, true)

	SetPedIntoVehicle(ped, vehicle, -1)
end, false) --False, allow everyone to run it

RegisterCommand("passager", function(source, args, raw)
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, true)

	SetPedIntoVehicle(ped, vehicle, 0)
end, false)

RegisterCommand("arg", function(source, args, raw) 
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, true)

	SetPedIntoVehicle(ped, vehicle, 1)
end, false)

RegisterCommand("ard", function(source, args, raw) 
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, true)

	SetPedIntoVehicle(ped, vehicle, 2)
end, false)