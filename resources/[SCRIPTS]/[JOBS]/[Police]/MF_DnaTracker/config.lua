MF_DnaTracker = {}
local MFD = MF_DnaTracker
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

MFD.Version = '1.0.10'

MFD.BloodObject = "p_bloodsplat_s"
MFD.ResidueObject = "w_pi_flaregun_shell"

-- JOB Database Table: LABEL
MFD.PoliceJob = "Police"
MFD.AmbulanceJob = "police"


MFD.DNAAnalyzePos = vector3(-1096.980, -826.778, 10.276)
MFD.AmmoAnalyzePos = vector3(-1103.022, -830.216, 10.276)
MFD.DrawTextDist = 3.0
MFD.MaxObjCount = 10