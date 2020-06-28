-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------


Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                		= { x = 1.3, y = 1.3, z = 1.0 }
Config.MarkerColor                		= { r = 255, g = 25, b = 0 }
Config.EnablePlayerManagement    		= true
Config.EnableArmoryManagement    		= true
Config.EnableESXIdentity         		= false -- only turn this on if you are using esx_identity
Config.EnableOrganisationOwnedVehicles 	= true
Config.EnableLicenses             		= false
Config.MaxInService               		= -1
Config.Locale                     		= 'fr'

Config.BallasStations = {

  Ballas = {

		AuthorizedWeapons = {
			{ name = 'WEAPON_FLASHLIGHT',       price = 250 },
			{ name = 'GADGET_PARACHUTE',        price = 1000 },
		},

		Cloakrooms = {
			{ x = 106.470, y = -1964.484, z = 19.878 }
		},
		
		Stocks = {
			{ x = 107.431, y = -1975.003, z = 19.95 },
		},
		
		Armories = {
			{ x = 107.431, y = -1975.003, z = 19.95 }
		},

		Vehicles = {
			{
				Spawner    = { x = 83.779, y = -1973.987, z = 19.92 },
        SpawnPoint = { x = 86.641, y = -1969.537, z = 19.74 },
				Heading    = 318.78,
			}
		},

		VehicleDeleters = {
			{ x = 94.99, y = -1960.14, z = 19.56 },
		},

		BossActions = {
			{ x = 114.168, y = -1960.961, z = 20.33 },
		},

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {

	},

	recruit = {

	},

	officer = {
		
	},

	sergeant = {
		
	},

	lieutenant = {
		
	},

	boss = {
	
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
    
  recruit_wear = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 127,   ['torso_2'] = 13,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 14,
        ['pants_1'] = 86,   ['pants_2'] = 22,
        ['shoes_1'] = 26,   ['shoes_2'] = 8,
        ['helmet_1'] = 14,  ['helmet_2'] = 5,
        ['chain_1'] = 16,    ['chain_2'] = 1,
        ['ears_1'] = 0,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 11,  ['tshirt_2'] = 1,
        ['torso_1'] = 120,   ['torso_2'] = 7,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 89,   ['pants_2'] = 22,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = 53,  ['helmet_2'] = 1,
        ['chain_1'] = 69,    ['chain_2'] = 0,
        ['ears_1'] = 0,     ['ears_2'] = 0
    }
  },
  sergeant_wear = {
    male = {
      ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
      ['torso_1'] = 127,   ['torso_2'] = 13,
      ['decals_1'] = 0,   ['decals_2'] = 0,
      ['arms'] = 14,
      ['pants_1'] = 86,   ['pants_2'] = 22,
      ['shoes_1'] = 26,   ['shoes_2'] = 8,
      ['helmet_1'] = 14,  ['helmet_2'] = 5,
      ['chain_1'] = 16,    ['chain_2'] = 1,
      ['ears_1'] = 0,     ['ears_2'] = 0
  },
  female = {
    ['tshirt_1'] = 11,  ['tshirt_2'] = 1,
    ['torso_1'] = 120,   ['torso_2'] = 7,
    ['decals_1'] = 0,   ['decals_2'] = 0,
    ['arms'] = 1,
    ['pants_1'] = 89,   ['pants_2'] = 22,
    ['shoes_1'] = 10,   ['shoes_2'] = 0,
    ['helmet_1'] = 53,  ['helmet_2'] = 1,
    ['chain_1'] = 69,    ['chain_2'] = 0,
    ['ears_1'] = 0,     ['ears_2'] = 0
}
},
  lieutenant_wear = {
    male = {
      ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
      ['torso_1'] = 127,   ['torso_2'] = 13,
      ['decals_1'] = 0,   ['decals_2'] = 0,
      ['arms'] = 14,
      ['pants_1'] = 86,   ['pants_2'] = 22,
      ['shoes_1'] = 26,   ['shoes_2'] = 8,
      ['helmet_1'] = 14,  ['helmet_2'] = 5,
      ['chain_1'] = 16,    ['chain_2'] = 1,
      ['ears_1'] = 0,     ['ears_2'] = 0
  },
  female = {
    ['tshirt_1'] = 11,  ['tshirt_2'] = 1,
    ['torso_1'] = 120,   ['torso_2'] = 7,
    ['decals_1'] = 0,   ['decals_2'] = 0,
    ['arms'] = 1,
    ['pants_1'] = 89,   ['pants_2'] = 22,
    ['shoes_1'] = 10,   ['shoes_2'] = 0,
    ['helmet_1'] = 53,  ['helmet_2'] = 1,
    ['chain_1'] = 69,    ['chain_2'] = 0,
    ['ears_1'] = 0,     ['ears_2'] = 0
}
},
  boss_wear = {
    male = {
      ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
      ['torso_1'] = 127,   ['torso_2'] = 13,
      ['decals_1'] = 0,   ['decals_2'] = 0,
      ['arms'] = 14,
      ['pants_1'] = 86,   ['pants_2'] = 22,
      ['shoes_1'] = 26,   ['shoes_2'] = 8,
      ['helmet_1'] = 14,  ['helmet_2'] = 5,
      ['chain_1'] = 16,    ['chain_2'] = 1,
      ['ears_1'] = 0,     ['ears_2'] = 0
  },
  female = {
    ['tshirt_1'] = 11,  ['tshirt_2'] = 1,
    ['torso_1'] = 120,   ['torso_2'] = 7,
    ['decals_1'] = 0,   ['decals_2'] = 0,
    ['arms'] = 1,
    ['pants_1'] = 89,   ['pants_2'] = 22,
    ['shoes_1'] = 10,   ['shoes_2'] = 0,
    ['helmet_1'] = 53,  ['helmet_2'] = 1,
    ['chain_1'] = 69,    ['chain_2'] = 0,
    ['ears_1'] = 0,     ['ears_2'] = 0
}
  }

}