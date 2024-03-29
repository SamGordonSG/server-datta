-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------


Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 42
Config.MarkerSize                		= { x = 1.3, y = 1.3, z = 1.0 }
Config.MarkerColor                		= { r = 0, g = 0, b = 0 }
Config.EnablePlayerManagement    		= true
Config.EnableArmoryManagement    		= true
Config.EnableESXIdentity         		= false -- only turn this on if you are using esx_identity
Config.EnableOrganisationOwnedVehicles 	= false
Config.EnableLicenses             		= false
Config.MaxInService               		= -1
Config.Locale                     		= 'fr'

Config.ShadowsStations = {

  Shadows = {

		AuthorizedWeapons = {
			{ name = 'WEAPON_KNIFE',       price = 250 },
			{ name = 'WEAPON_COMBATPISTOL',        price = 1500 },
		},

  --[[  Cloakrooms = {
      { x = 342.370, y = -2024.921, z = 22.394 }, -- fait
    },]]--
		
		Stocks = {
			{ x = 107.431, y = -1975.003, z = 19.95 }, --???
		},
		
    Armories = {
      { x = 1405.7432861328,y = 1138.0656738281,z = 109.74568176274 }, -- fait
    },

    Vehicles = {
      {
        Spawner    = { x = 1400.6292724609,y = 1122.3995361328,z = 114.83802032471 }, -- fait
        SpawnPoint = { x = 1395.4311523438,y = 1117.4038085938,z = 114.83771514893 }, -- fait
        Heading    = 87.109, -- fait
      }
    },

    VehicleDeleters = {
      { x = 1410.9074707031,y = 1118.6343994141,z = 114.83794403076 }, -- fait
    },

    BossActions = {
      { x = 1393.1929931641,y = 1159.9919433594,z = 114.33339691162 } -- fait
    },

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles

Config.AuthorizedVehicles = {
	Shared = {   
		{model = 'bison', label = 'Bison', price = 49500},
	},
    
    lieutenant = {
		{model = 'vstr', label = 'V-str', price = 49500},
    },
    
    boss = {
		{model = 'vstr', label = 'V-str', price = 49500},
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