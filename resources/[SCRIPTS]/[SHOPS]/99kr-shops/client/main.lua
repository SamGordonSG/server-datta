Keys = {["E"] = 38, ["L"] = 182, ["G"] = 47}

payAmount = 0
Basket = {}

--[[ Gets the ESX library ]]--
ESX = nil 
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)

        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
    end
end)

DrawText3D = function(x, y, z, text)
    local onScreen,x,y = World3dToScreen2d(x, y, z)
    local factor = #text / 370

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x,y)
        DrawRect(x,y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 120)
    end
end

--[[ Requests specified model ]]--
_RequestModel = function(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
end

--[[ Deletes the caissiers ]]--
DeleteCaissier = function()
    for i=1, #Config.Locations do
        local caissier = Config.Locations[i]["caissier"]
        if DoesEntityExist(caissier["entity"]) then
            DeletePed(caissier["entity"])
            SetPedAsNoLongerNeeded(caissier["entity"])
        end
    end
end

Citizen.CreateThread(function()
    local defaultHash = 416176080
    for i=1, #Config.Locations do
        local caissier = Config.Locations[i]["caissier"]
        if caissier then
            caissier["hash"] = caissier["hash"] or defaultHash
            _RequestModel(caissier["hash"])
            if not DoesEntityExist(caissier["entity"]) then
                caissier["entity"] = CreatePed(4, caissier["hash"], caissier["x"], caissier["y"], caissier["z"], caissier["h"])
                SetEntityAsMissionEntity(caissier["entity"])
                SetBlockingOfNonTemporaryEvents(caissier["entity"], true)
                FreezeEntityPosition(caissier["entity"], true)
                SetEntityInvincible(caissier["entity"], true)
            end
            SetModelAsNoLongerNeeded(caissier["hash"])
        end
    end
end)

--[[ Creates caissiers and blips ]]--
Citizen.CreateThread(function()
    for i=1, #Config.Locations do
        local blip = Config.Locations[i]["blip"]

        if blip then
            if not DoesBlipExist(blip["id"]) then
                blip["id"] = AddBlipForCoord(blip["x"], blip["y"], blip["z"])
                SetBlipSprite(blip["id"], 52)
                SetBlipDisplay(blip["id"], 4)
                SetBlipScale(blip["id"], 1.0)
                SetBlipColour(blip["id"], 25)
                SetBlipAsShortRange(blip["id"], true)

                BeginTextCommandSetBlipName("shopblip")
                AddTextEntry("shopblip", "Shop")
                EndTextCommandSetBlipName(blip["id"])
            end
        end
    end
end)

--[[ Function to trigger pNotify event for easier use :) ]]--
pNotify = function(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
        text = message,
		type = messageType,
		queue = "shopcl",
		timeout = messageTimeout,
		layout = "topRight"
	})
end

Marker = function(pos)
    DrawMarker(25, pos["x"], pos["y"], pos["z"] - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 200, 200, 200, 60, false, false, 2, false, nil, nil, false)
    DrawMarker(25, pos["x"], pos["y"], pos["z"] - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 200, 200, 200, 60, false, false, 2, false, nil, nil, false)
end

--[[ Deletes the peds when the resource stops ]]--
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerServerEvent('esx:clientLog', "[99kr-shops]: Deleting peds...")
        DeleteCaissier()
    end
end)
