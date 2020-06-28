Config                            = {}

Config.platePrefix                = "EMS"
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 102, g = 0, b = 102 }
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.ReviveReward               = 0  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders
-- Max m�decin en service
Config.MaxInService               = -1
Config.Locale                     = 'fr'

local second = 1000
local minute = 60 * second

-- How much time before auto respawn at hospital
Config.RespawnDelayAfterRPDeath   = 8 * minute

Config.EnablePlayerManagement       = true
Config.EnableSocietyOwnedVehicles   = false
Config.EnableVaultManagement        = true

Config.RemoveWeaponsAfterRPDeath    = false
Config.RemoveCashAfterRPDeath       = true
Config.RemoveItemsAfterRPDeath      = false

-- Will display a timer that shows RespawnDelayAfterRPDeath as a countdown
Config.ShowDeathTimer               = true

-- Will allow respawn after half of RespawnDelayAfterRPDeath has elapsed.
Config.EarlyRespawn                 = true
-- The player will be fined for respawning early (on bank account)
Config.EarlyRespawnFine                  = true
Config.EarlyRespawnFineAmount            = 600

Config.Blip = {
	Pos     = { x = 297.895, y = -584.094, z = 43.261 },
	Sprite  = 61,
	Display = 4,
	Scale   = 1.2,
	Colour  = 2,
}

Config.HelicopterSpawner = {
	SpawnPoint = { x = 351.65, y = -588.248, z = 73.165 },   
	Heading    = 78.86
}

-- Ajout Armes
Config.AuthorizedWeapons = {
	{ name = 'WEAPON_FLASHLIGHT',       price = 250 },
	{ name = 'WEAPON_FLAREGUN',         price = 150 },
	{ name = 'WEAPON_FIREEXTINGUISHER', price = 100 }

}
-- https://wiki.fivem.net/wiki/Vehicles

	Config.AuthorizedVehicles = {

		{
			model = 'ambulance',
			label = 'Ambulance',
		},
		{
			model = 'ambulance2',
			label = 'Ambulance 2',
		},
		{
			model = 'emscar',
			label = 'Voiture',
		},
		{
			model = 'emscar2',
			label = 'Voiture 2',
		},
		{
			model = 'emssuv',
			label = '4x4',
		},
	
	}
	Config.Uniforms = {
		ambulance_wear = {
			male = {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 3,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 77,
				['pants_1'] = 20,   ['pants_2'] = 0,
				['shoes_1'] = 8,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 126,    ['chain_2'] = 0,
				['ears_1'] = 2,     ['ears_2'] = 0
			},
			female = {
				['tshirt_1'] = 159,  ['tshirt_2'] = 0,
				['torso_1'] = 27,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 98,
				['pants_1'] = 23,   ['pants_2'] = 0,
				['shoes_1'] = 1,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 96,    ['chain_2'] = 0,
				['ears_1'] = 2,     ['ears_2'] = 0
			}
		},
		doctor_wear = {
			male = {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 3,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 77,
				['pants_1'] = 20,   ['pants_2'] = 0,
				['shoes_1'] = 8,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 126,    ['chain_2'] = 0,
				['ears_1'] = 2,     ['ears_2'] = 0
			},
			female = {
				['tshirt_1'] = 159,  ['tshirt_2'] = 0,
				['torso_1'] = 27,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 98,
				['pants_1'] = 23,   ['pants_2'] = 0,
				['shoes_1'] = 1,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 96,    ['chain_2'] = 0,
				['ears_1'] = 2,     ['ears_2'] = 0
			}
		},
		chief_doctor_wear = {
			male = {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 3,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 77,
				['pants_1'] = 20,   ['pants_2'] = 0,
				['shoes_1'] = 8,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 126,    ['chain_2'] = 0,
				['ears_1'] = 2,     ['ears_2'] = 0
			},
			female = {
				['tshirt_1'] = 159,  ['tshirt_2'] = 0,
				['torso_1'] = 27,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 98,
				['pants_1'] = 23,   ['pants_2'] = 0,
				['shoes_1'] = 1,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 96,    ['chain_2'] = 0,
				['ears_1'] = 2,     ['ears_2'] = 0
			}
		},
		boss_wear = {
			male = {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 3,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 77,
				['pants_1'] = 20,   ['pants_2'] = 0,
				['shoes_1'] = 8,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 126,    ['chain_2'] = 0,
				['ears_1'] = 2,     ['ears_2'] = 0
			},
			female = {
				['tshirt_1'] = 159,  ['tshirt_2'] = 0,
				['torso_1'] = 27,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 98,
				['pants_1'] = 23,   ['pants_2'] = 0,
				['shoes_1'] = 1,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 96,    ['chain_2'] = 0,
				['ears_1'] = 2,     ['ears_2'] = 0
			}
		},
		bullet_wear = {
			male = {
				['bproof_1'] = 11,  ['bproof_2'] = 1
			},
			female = {
				['bproof_1'] = 13,  ['bproof_2'] = 1
			}
		},
	}	

Config.Zones = {	

    Cloakroom = { -- CLOAKROOM --
        Pos  = { x = 302.06, y = -599.26, z = 43.28 -0.90 },   
        Size  = { x = 5.3, y = 5.3, z = 0.1 },
        Color = { r = 102, g = 0, b = 102 },
        Type  = 27
    },

	Vaults = {
		Pos = {x=303.89, y=-569.65,  z=43.28 -0.90},
		Size = { x = 1.3, y = 1.3, z = 0.1 },
		Color = { r = 30, g = 144, b = 255 },
		Type = 26
	},

	BossActions = {
		Pos = {x=340.29, y=-591.25,  z=43.28 -0.90},
		Size = { x = 1.3, y = 1.3, z = 0.5 },
		Color = { r = 30, g = 144, b = 255 },
		Type = 27
	},

	HelicopterSpawn = { -- Main entrance
		Pos	= { x = 339.998, y = -590.709, z = 73.165 },   
		Type = 1
	},

	--HospitalInteriorEntering1 = { -- Main entrance
	--	Pos	= { x = -447.758, y = -341.122, z = 33.5 },
	--	Type = 1
	--},

	HospitalInteriorInside1 = {
		Pos	= { x = 297.36822509766,y = -584.06970214844,z = 43.132610321045 },
		Type = -1
	},

	--HospitalInteriorInside1 = {
	--	Pos	= { x = 320.052, y = -593.575, z = 43.292 },
	--	Type = -1
	--},

	--HospitalInteriorOutside1 = {
	--	Pos	= { x = -450.398, y = -340.629, z = 33.501 },
	--	Type = -1
	--},

	--HospitalInteriorExit1 = {
	--	Pos	= { x = 275.7, y = -1361.5, z = 23.5 },
	--	Type = 1
	--},

	--HospitalInteriorExit1 = {
	--	Pos	= { x = -458.3774, y = -367.2123, z = -187.4548 },
	--	Type = 1
	--},

	HospitalInteriorEntering2 = { -- Lift go to the roof
	Pos	= { x = 327.0817565918,y = -603.79638671875,z = 43.284019470215 -0.90 },   
		Type = 1
	},

	HospitalInteriorInside2 = { -- Roof outlet
		Pos	= { x = 339.105,	y = -585.197, z = 73.165 },
		Type = -1
	},

	HospitalInteriorOutside2 = { -- Lift back from roof
		Pos	= { x = 323.228,	y = -598.583, z = 41.29 },   
		Heading    = 220.500,
		Type = -1
	},

	HospitalInteriorExit2 = { -- Roof entrance
		Pos	= { x = 339.86, y = -583.531, z = 73.165 },    
		Type = 1
	},

--	VehicleSpawner = {
--		Pos	= { x = 300.848, y = -602.718, z = 42.396 }, 
--		Type = 1
--	},
--
--	VehicleSpawnPoint = {
--		Pos	= { x = 292.218, y = -612.048, z = 42.40 },
  --              Heading    = 61.44,
--		Type = -1
--	},
--
--	VehicleDeleter = {
--		Pos	= { x = 295.60, y = -605.984, z = 42.30 },
--		Type = 1
--	},
--
--	VehicleDeleter2 = {
--		Pos	= { x = 351.603, y = -588.237, z = 74.55 },
--		Type = 2
--	},

	Pharmacy = {
		Pos	= { x = 309.96, y = -568.70, z = 43.28 -0.90 },
		Type = 1
	}

	--ParkingDoorGoOutInside = {
	--	Pos	= { x = 234.56, y = -1373.77, z = -120.97 },
	--	Type = 1
	--},

	--ParkingDoorGoOutOutside = {
	--	Pos	= { x = 320.98, y = -1478.62, z = -128.81 },
	--	Type = -1
	--},

	--ParkingDoorGoInInside = {
	--	Pos	= { x = 238.64, y = -1368.48, z = -123.53 },
	--	Type = -1
	--},

	--ParkingDoorGoInOutside = {
	--	Pos	= { x = 317.97, y = -1476.13, z = -128.97 },
	--	Type = 1
	--},

	--StairsGoTopTop = {
	--	Pos	= { x = 251.91, y = -1363.3, z = 38.53 },
	--	Type = -1
	--},

	--StairsGoTopBottom = {
	--	Pos	= { x = 237.45, y = -1373.89, z = 26.30 },
	--	Type = -1
    
	--},

	--StairsGoBottomTop = {
	--	Pos	= { x = 256.58, y = -1357.7, z = 37.30 },
	--	Type = -1
	--},

	--StairsGoBottomBottom = {
	--	Pos	= { x = 235.45, y = -1372.89, z = 26.30 },
	--	Type = -1
	--}

}
