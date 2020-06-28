
ESX					= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)
Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(0)
        for _, v in pairs(Config.Zones) do
            local marker = v.marker
            DrawMarker(
                30,
                marker.x, marker.y, marker.z,
                0.0, 0.0, 0.0,
                0, 0.0, 0.0,
                1.0, 1.0, 1.0,
                6, 152, 253, 100,
                false, true, 2, true, false, false, false
            )
            -- DrawMarker(20, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
            -- print("Draw marker for " .. v.name)
        end
    end
end)

local playerPed = PlayerPedId()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())

        for _,v in pairs(Config.Zones) do
            local distance = GetDistanceBetweenCoords(playerCoords, v.marker.x, v.marker.y, v.marker.z, true)

            local maxDistance = 1.5
            local size = 1
            

            if distance < maxDistance then
                -- print("In marker: " .. v.name)
                local displayText = "Pour utilisez l'ascenseur \n il vous faut un badge du LSPD"
                ESX.Game.Utils.DrawText3D(v.marker, displayText, size)
                -- ESX.ShowAdvancedNotification('Ascenseur LSPD', "Badge D'accées", displayText, playerPed, 110)

            end
        end
    end
end)

RegisterNetEvent('jackMarker:onBadge')
AddEventHandler('jackMarker:onBadge', function()

    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local isInMarker, currentPad, currentAction, currentPadData = false, nil, nil, nil
    

    for pad,padData in pairs(Config.Zones) do
        if GetDistanceBetweenCoords(coords, padData.marker.x, padData.marker.y, padData.marker.z, true) <  1.5 then
            isInMarker, currentPad, currentAction, currentPadData = true, pad, 'asc.' .. string.lower(pad), padData
            break
            
        end
    end


    
    if isInMarker == false then
        -- ESX.ShowAdvancedNotification('Ascenseur LSPD', "Badge D'accées", "Vous devez être à coter de l'ascenseur", playerPed, 110)
        TriggerEvent("jackMarker:notify", "CHAR_CALL911", 1, "LSPD", 'Badge Police', 'Vous devez être à coter de l\'ascenseur')
        return 
    end
    
    --[[    Menu Default    ]]
    
    local elems = {}
    for k,v in pairs(Config.Zones) do 
        table.insert(elems, {label = v.name, value = k})
    end
        -- Etage de l'ascenseur LSPD 
    
    

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menuPerso',{
        title    = 'Police | Ascenseur',
        align = 'top-left',
        elements = elems
    },
        
    function(data, menu)
        ESX.Game.Teleport(PlayerPedId(), Config.Zones[data.current.value].marker, function()end)
    end,
    function(data, menu)
        menu.close()
    end)

end)

RegisterNetEvent("jackMarker:notify")
AddEventHandler("jackMarker:notify", function(icon, type, sender, title, text)
    Citizen.CreateThread(function()
		Wait(1)
		SetNotificationTextEntry("STRING");
		AddTextComponentString(text);
		SetNotificationMessage(icon, icon, true, type, sender, title, text);
		DrawNotification(false, true);
    end)
end)