-- /ref for police
-- Made by Crishe

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('ref:addBlip')
AddEventHandler('ref:addBlip', function(id)
	if isPolice() then
	
		local id = GetPlayerFromServerId(id)
		local pedUser = GetPlayerPed(id)
		local blip = GetBlipFromEntity(pedUser)

		if not DoesBlipExist(blip) then
			local blipPoli = AddBlipForEntity(pedUser)

			SetBlipSprite(blipPoli, 15)
			Citizen.InvokeNative( 0x5FBCA48327B914DF, blipPoli, true)
			SetBlipAsShortRange(blipPoli, false)
			SetBlipColour(blipPoli, 2)
			SetBlipScale(blipPoli, 1.1)

			SetBlipNameToPlayerName(blipPoli, id)

			if pedUser == GetPlayerPed(-1) then
				ESX.ShowNotification('Votre demande d assistance LSPD à été envoyée.')
			else
				ESX.ShowNotification('Un EMS à besoin d assistance LSPD.')
			end
			

		else
			RemoveBlip(blip)
			if pedUser == GetPlayerPed(-1) then
				ESX.ShowNotification('Votre demande d assistance LSPD à été supprimée.')
			else
				ESX.ShowNotification('Un EMS n à plus besoin d assistance LSPD.')
			end
		end
	end
end)

function isPolice()
    if PlayerData ~= nil then
        local isPolice = false
        if PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
            isPolice = true
        end
        return isPolice
    end
end

function showNotification(string)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(string)
	DrawNotification(false, false)
end

RegisterCommand("gps", function (src, args, raw)
    TriggerServerEvent("ref:reference")
end, false)