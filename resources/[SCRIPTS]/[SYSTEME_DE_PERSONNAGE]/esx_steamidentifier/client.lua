Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(500)
  end
end)

Citizen.CreateThread(function()
	if true then
		Citizen.Wait(2000)
		ESX.TriggerServerCallback('steamidentifier:id', function(id)
				steam = id
				steam = steam:sub(Config.Long)
			while true do
				Citizen.Wait(0)
				SimpleText(Config.X, Config.Y, Config.SCALE, " " .. steam .. "  | ID [ " .. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) .. " ]", Config.Color.R, Config.Color.G, Config.Color.B, 255)
			end
		end)
	end
end)


function SimpleText(X, Y, SCALE, TEXT, R, G, B, A)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(SCALE, SCALE)
	SetTextColour(R, G, B, A)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(TEXT)
    DrawText(X, Y)
end
