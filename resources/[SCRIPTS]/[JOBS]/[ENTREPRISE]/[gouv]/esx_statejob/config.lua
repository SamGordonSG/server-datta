Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.platePrefix                = "GOUV"
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.StateStations = {

	State = {

		Blip = {
			Pos     = {x = -538.57879638672, y = -214.32641601563, z = 37.649646759033},
			Sprite  = 419,
			Display = 4,
			Scale   = 1.2,
	        -- Colour  = 29,
		},
		-- https://wiki.fivem.net/wiki/Weapons
		AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 200 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 300 },
			{ name = 'WEAPON_ASSAULTSMG',       price = 1250 },
			{ name = 'WEAPON_CARBINERIFLE',     price = 1500 },
			{ name = 'WEAPON_PUMPSHOTGUN',      price = 600 },
			{ name = 'WEAPON_STUNGUN',          price = 500 },
			{ name = 'WEAPON_FLASHLIGHT',       price = 80 },
			{ name = 'WEAPON_FLAREGUN',         price = 60 },
			{ name = 'GADGET_PARACHUTE',        price = 300 },
		},

		Cloakrooms = {
			{x = -557.35028076172,y = -183.13623046875,z = 38.219676971436 - 0.90 }
		},

		Armories = {
			{x = -544.71643066406,y = -195.63932800293,z = 69.975318908691 -0.90}
		},

		Vehicles = {
			{
				Spawner    = { x = -556.3984375,y = -175.54779052734,z = 38.081993103027 -0.90 },
				SpawnPoint = {x = -560.93695068359,y = -173.77030944824,z = 38.130889892578},
				Heading    = 22.34,
			}
		},

		Helicopters = {
			{
				Spawner    = { x = -602.37432861328,y = -138.78044128418,z = 39.008419036865 -0.90 },
				SpawnPoint = { x = -606.44866943359,y = -126.74027252197,z = 39.008419036865},
				Heading    = 0.0,
			}
		},

		VehicleDeleters = {
			{ x = -561.06488037109,y = -177.41738891602,z = 38.043918609619 },
			{ x = -607.07257080078,y = -128.45547485352,z = 39.008430480957},
		},

		BossActions = {
			{x = -546.96643066406,y = -197.24110412598,z = 69.975341796875 -0.90},
		},

	},

}

-- https://wiki.fivem.net/wiki/Vehicles
Config.AuthorizedVehicles = {
	Shared = {
	
	},

	recrue = {
    {
			model = 'baller6',
			label = 'SUV Blindé'
		},

	},

	garde = {
    {
			model = 'baller6',
			label = 'SUV Blindé'
		},
		
	},

	vicepresident = {
    {
			model = 'fbi2',
			label = '4x4 Procureur'
		},
		{
			model = 'baller6',
			label = 'SUV Blindé'
		},
		
	},

	boss = {
    {
			model = 'stretch',
			label = 'Limousine Gouverneur'				
		},
		{
			model = 'cognoscenti2',
			label = 'Limo Blindée'
		},
		{
			model = 'cog552',
			label = 'Berline Blindée'
		},
		{
			model = 'dw_pressuv',
			label = '4x4 Gouvernemental'
		},
	
	}
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
    
  cadet_wear = {
    male = {
        ['tshirt_1'] = 22,  ['tshirt_2'] = 4,
        ['torso_1'] = 21,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 25,   ['pants_2'] = 5,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,   ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 0,     ['ears_2'] = 0,
        ['ears_1'] = 0,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 36,  ['tshirt_2'] = 1,
        ['torso_1'] = 48,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 44,
        ['pants_1'] = 34,   ['pants_2'] = 0,
        ['shoes_1'] = 27,   ['shoes_2'] = 0,
        ['helmet_1'] = 45,  ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    }
  },
  sergeant_wear = {
    male = {
        ['tshirt_1'] = 21,  ['tshirt_2'] = 0,
        ['torso_1'] = 29,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 35,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 0,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
        ['torso_1'] = 48,   ['torso_2'] = 0,
        ['decals_1'] = 7,   ['decals_2'] = 1,
        ['arms'] = 44,
        ['pants_1'] = 34,   ['pants_2'] = 0,
        ['shoes_1'] = 27,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    }
  },
  lieutenant_wear = {
    male = {
        ['tshirt_1'] = 33,  ['tshirt_2'] = 1,
        ['torso_1'] = 29,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 35,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 29,    ['chain_2'] = 13,
        ['ears_1'] = 0,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
        ['torso_1'] = 48,   ['torso_2'] = 0,
        ['decals_1'] = 7,   ['decals_2'] = 2,
        ['arms'] = 44,
        ['pants_1'] = 34,   ['pants_2'] = 0,
        ['shoes_1'] = 27,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    }
  },
  commandant_wear = {
    male = {
        ['tshirt_1'] = 33,  ['tshirt_2'] = 2,
        ['torso_1'] = 29,   ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 35,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 29,    ['chain_2'] = 4,
        ['ears_1'] = 0,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
        ['torso_1'] = 48,   ['torso_2'] = 0,
        ['decals_1'] = 7,   ['decals_2'] = 3,
        ['arms'] = 44,
        ['pants_1'] = 34,   ['pants_2'] = 0,
        ['shoes_1'] = 27,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
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
  gilet_wear = {
    male = {
        ['tshirt_1'] = 59,  ['tshirt_2'] = 1
    },
    female = {
        ['tshirt_1'] = 36,  ['tshirt_2'] = 1
    }
  }

}

Config.PublicZones = {

  --[[EnterBuilding = {
    Pos       = {x = -429.561, y = 1110., z = 326.68}, 
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 255, g = 255, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Gouvernement : Entrer",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans le Gouvernement.",
    Teleport  = {x = -75.8466, y = -826.9893, z = 243.3859}, 
  },

  ExitBuilding = {
      Pos       = {x = -77.217, y = -830.177, z = 242.585},
      Size      = { x = 1.0, y = 1.0, z = 0.2 },
      Color     = { r = 204, g = 204, b = 0 },
      Marker    = 1,
      Blip      = false,
      Name      = "Gouvernement : Sortir",
      Type      = "teleport",
      Hint      = "Appuyez sur ~INPUT_PICKUP~ pour sortir du Gouvernement.",
      Teleport  = {x = -427.689, y = 1111.682, z = 326.693},
    },
  
  
  
    EnterRoof = {
    Pos       = { x = -67.255, y = -812.020, z = 242.485 },
    Size      = { x = 1.0, y = 1.0, z = 0.0 },
    Color     = { r = 64, g = 0, b = 0 },
    Marker    = 25,
    Blip      = false,
    Name      = "Gouvernement",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour aller à l'Hélico.",
    Teleport  = { x = -468.541, y = 1128.95, z = 324.904 }
  },

  ExitRoof = {
    Pos       = { x = 157.445, y =  -764.785, z = 257.2 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 25,
    Blip      = false,
    Name      = "Gouvernement",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans l'immeuble.",
    Teleport  = { x = 135.5, y =  -766.783, z = 241.0 },
  },
  
  EnterGarage = {
    Pos       = { x = -78.92, y =  -829.617, z = 242.485 },
    Size      = { x = 1.0, y = 1.0, z = 0.0 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 25,
    Blip      = false,
    Name      = "Gouvernement",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour descendre au Parking.",
    Teleport  = { x = -420.893, y =  1064.953, z = 322.84 },
  },
  
  ExitGarage = {
    Pos       = { x = -420.168, y =  1066.498, z = 322.84 },
    Size      = { x = 2.0, y = 2.0, z = 1.0 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 25,
    Blip      = false,
    Name      = "Gouvernement",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans le Gouverment.",
    Teleport  = { x = -77.541, y =  -826.232, z = 242.385 },
  },]]--
  
}