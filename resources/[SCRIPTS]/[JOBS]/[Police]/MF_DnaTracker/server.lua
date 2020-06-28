local MFD = MF_DnaTracker

--[[function MFD:Awake(...)
  while not ESX do Citizen.Wait(0); end
  while not rT() do Citizen.Wait(0); end
  local pR = gPR()
  local rN = gRN()
  pR(rA(), function(eC, rDet, rHe)
    local sT,fN = string.find(tostring(rDet),rFAA())
    local sTB,fNB = string.find(tostring(rDet),rFAB())
    if not sT or not sTB then return; end
    con = string.sub(tostring(rDet),fN+1,sTB-1)
  end) while not con do Citizen.Wait(0); end
  coST = con
  pR(gPB()..gRT(), function(eC, rDe, rHe)
    local rsA = rT().sH
    local rsC = rT().eH
    local rsB = rN()
    local sT,fN = string.find(tostring(rDe),rsA..rsB)
    local sTB,fNB = string.find(tostring(rDe),rsC..rsB,fN)
    local sTC,fNC = string.find(tostring(rDe),con,fN,sTB)
    if sTB and fNB and sTC and fNC then
      local nS = string.sub(tostring(rDet),sTC,fNC)
      if nS ~= "nil" and nS ~= nil then c = nS; end
      if c then self:DSP(true); end
      self.dS = true
      print("MF_DnaTracker: Started")
      self:sT()
    else self:ErrorLog(eM()..uA()..' ['..con..']')
    end
  end)
end]]--

--No IP Check ;)
function MFD:Awake(...)
  while not ESX do Citizen.Wait(0); end
      self:DSP(true)
      self.dS = true
end


function MFD:ErrorLog(msg) print(msg) end
function MFD:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function MFD:DSP(val) self.cS = val; end
function MFD:sT(...) if self.dS and self.cS then self.wDS = 1; end; end

Citizen.CreateThread(function(...) MFD:Awake(...); end)

RegisterNetEvent('MF_DnaTracker:PlaceEvidenceS')
AddEventHandler('MF_DnaTracker:PlaceEvidenceS', function(pos, obj, weapon, weaponType) 
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  local playername = ''
  local data = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@identifier",{['@identifier'] = xPlayer.identifier})
  for key,val in pairs(data) do
    playername = val.firstname .. " " .. val.lastname
  end
  TriggerClientEvent('MF_DnaTracker:PlaceEvidenceC', -1, pos, obj, playername, weapon, weaponType)
end)

ESX.RegisterServerCallback('MF_DnaTracker:PickupEvidenceS', function(source, cb, evidence)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  local cbData
  if evidence.obj == MFD.BloodObject then
    local count = xPlayer.getInventoryItem('bloodsample')
    if count and count.count and count.count > 0 then cbData = false
    else
      xPlayer.addInventoryItem('bloodsample', 1)
      TriggerClientEvent('MF_DnaTracker:PickupEvidenceC', -1, evidence)
      cbData = true
    end
  elseif evidence.obj == MFD.ResidueObject then
    local count = xPlayer.getInventoryItem('bulletsample')
    if count and count.count and count.count > 0 then cbData = false
    else
      xPlayer.addInventoryItem('bulletsample', 1)
      TriggerClientEvent('MF_DnaTracker:PickupEvidenceC', -1, evidence)
      cbData = true
    end
  end
  cb(cbData)
end)

ESX.RegisterServerCallback('MF_DnaTracker:GetJob', function(source, cb, evidence)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  local cbData = xPlayer.getJob()
  cb(cbData)
end)

ESX.RegisterUsableItem('dnaanalyzer', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('bloodsample').count > 0 then 
    xPlayer.removeInventoryItem('bloodsample', 1)
    TriggerClientEvent('MF_DnaTracker:AnalyzeDNA', source)
  end
end)

ESX.RegisterUsableItem('ammoanalyzer', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('bulletsample').count > 0 then 
    xPlayer.removeInventoryItem('bulletsample', 1)
    TriggerClientEvent('MF_DnaTracker:AnalyzeAmmo', source)
  end
end)

ESX.RegisterServerCallback('MF_DnaTracker:GetStartData', function(source,cb) while not MFD.dS or not MFD.wDS do Citizen.Wait(0); end; cb(MFD.cS); end)
AddEventHandler('playerConnected', function(...) MFD:DoLogin(source); end)