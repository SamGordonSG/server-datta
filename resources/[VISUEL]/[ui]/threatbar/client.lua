function openGui(disturbance)
 local msg = "Quiet"
 if disturbance > 80 then
  msg = "Danger"
 elseif disturbance > 60 then
  msg = "Unsafe"
 elseif disturbance > 30 then
  msg = "Safe"
 end
 SendNUIMessage({runProgress = true, Length = disturbance, Task = msg})
end

function closeGui()
 SendNUIMessage({closeProgress = true})
end

local lastmessage = false

RegisterNetEvent("robbery:guiupdate")
AddEventHandler("robbery:guiupdate", function(disturbance)
 if not lastmessage then
  lastmessage = true
  openGui(disturbance)
  Citizen.Wait(2000)
  closeGui()
  Citizen.Wait(8500)
  lastmessage = false
 end
end)

RegisterNetEvent("robbery:guiclose")
AddEventHandler("robbery:guiclose", function()
 TriggerEvent("robbery:guiupdate",0)
 closeGui()
end)
