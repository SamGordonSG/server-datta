
RegisterCommand('coords', function(source, args, rawCommand)
	local coords = GetEntityCoords(PlayerPedId())
	local heading = GetEntityHeading(PlayerPedId())
	SendNUIMessage({
		coords = "x = "..coords.x..",y = "..coords.y..",z = "..coords.z
	})
end)
