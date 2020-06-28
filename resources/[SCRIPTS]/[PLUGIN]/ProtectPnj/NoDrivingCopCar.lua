local PlayerData              = {}

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        if IsPedInAnyPoliceVehicle(GetPlayerPed(PlayerId())) then
            local veh = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
            if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(PlayerId())) then
                if (PlayerData.job ~= nil and (PlayerData.job.name ~= 'police' or PlayerData.job.name ~= 'ambulance' or PlayerData.job.name ~= 'security' or PlayerData.job.name ~= 'mecano' or PlayerData.job.name ~= 'mechanic' or PlayerData.job.name ~= 'state' or PlayerData.job.name ~= 'gouvernement' or PlayerData.job.name ~= 'brinks')) then
                  ESX.ShowNotification("Un véhicule d'Etat n'est pas réservé aux civils..")
                  SetVehicleUndriveable(veh, true)
                end
            end
        end
    end
end)
