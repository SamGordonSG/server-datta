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

Config.LostStations = {

  Lost = {

		AuthorizedWeapons = {
			{ name = 'WEAPON_FLASHLIGHT',       price = 250 },
      { name = 'WEAPON_COMBATPISTOL',        price = 2000 },
      { name = 'WEAPON_SWITCHBLADE',        price = 1000 },
		},

    Cloakrooms = {
      { x = 886.29, y = -2109.33, z = 30.76 }, -- fait
    },

    Armories = {
      { x = 884.63, y = -2102.99, z = 35.59 }, -- fait
    },

    Vehicles = {
      {
        Spawner    = { x = 899.70, y = -2107.17, z = 30.76 }, -- fait
        SpawnPoint = { x = 889.96, y = -2101.70, z = 30.76 }, -- fait
        Heading    = 348.41, -- fait
      }
    },

    VehicleDeleters = {
      { x = 895.44, y = -2107.23, z = 30.76 }, -- fait
    },

    BossActions = {
      { x = 884.55, y = -2106.91, z = 30.76 } -- fait
    },

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
  { name = 'bagger',    label = 'Moto' },
  { name = 'sanctus',  label = 'Sanctus' },
  { name = 'bison',     label = 'Pick up' }
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
    
  recruit_wear = {
    male = {
        ['tshirt_1'] = 130,  ['tshirt_2'] = 0,
        ['torso_1'] = 128,   ['torso_2'] = 4,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 0,
        ['pants_1'] = 64,   ['pants_2'] = 4,
        ['shoes_1'] = 57,   ['shoes_2'] = 8,
        ['helmet_1'] = 14,  ['helmet_2'] = 3,
        ['chain_1'] = 111,    ['chain_2'] = 0,
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
        ['tshirt_1'] = 76,  ['tshirt_2'] = 0,
        ['torso_1'] = 127,   ['torso_2'] = 10,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 0,
        ['pants_1'] = 43,   ['pants_2'] = 0,
        ['shoes_1'] = 32,   ['shoes_2'] = 5,
        ['helmet_1'] = 14,  ['helmet_2'] = 3,
        ['chain_1'] = 51,    ['chain_2'] = 0,
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
        ['tshirt_1'] = 130,  ['tshirt_2'] = 0,
        ['torso_1'] = 126,   ['torso_2'] = 10,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 0,
        ['pants_1'] = 38,   ['pants_2'] = 0,
        ['shoes_1'] = 48,   ['shoes_2'] = 0,
        ['helmet_1'] = 77,  ['helmet_2'] = 19,
        ['chain_1'] = 0,    ['chain_2'] = 0,
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
  boss_wear = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 127,   ['torso_2'] = 10,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 39,
        ['pants_1'] = 79,   ['pants_2'] = 0,
        ['shoes_1'] = 57,   ['shoes_2'] = 8,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 17,    ['chain_2'] = 0,
        ['ears_1'] = 0,     ['ears_2'] = 11
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
  }

}