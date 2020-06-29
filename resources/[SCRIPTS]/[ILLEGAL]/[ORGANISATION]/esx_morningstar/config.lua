-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------

Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                		= { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                		= { r = 255, g = 255, b = 255 }
Config.EnablePlayerManagement    		= true
Config.EnableArmoryManagement    		= true
Config.EnableESXIdentity         		= true -- only turn this on if you are using esx_identity
Config.EnableOrganisationOwnedVehicles 	= true
Config.EnableLicenses             		= false
Config.MaxInService               		= 10
Config.Locale                     		= 'fr'

Config.MafiaStations = {

  Mafia = {

    AuthorizedWeapons = {
		{ name = 'WEAPON_FLASHLIGHT',     price = 250 },
    { name = 'WEAPON_STUNGUN',        price = 500 },
    { name = 'WEAPON_KNUCKLE',        price = 125 },
    { name = 'WEAPON_HATCHET',        price = 125 },
    { name = 'WEAPON_MACHETE',        price = 125 },
    { name = 'WEAPON_SWITCHBLADE',    price = 125 },
    { name = 'WEAPON_POOLCUE',        price = 125 },
    { name = 'WEAPON_PISTOL_MK2',     price = 10000 },
    { name = 'GADGET_PARACHUTE',      price = 1000 }

    },

    Cloakrooms = {
      { x = -1562.3941650391, y = -577.46600341797, z = 104.90416717529 -0.90 },
    },

    Armories = {
      {x = -1555.7141113281, y = -574.8876953125, z = 100.05380249023 -0.90},
    },

    Vehicles = {
      {
        Spawner    = { x = -1514.9787597656, y = -544.37445068359, z = 25.707895278931 -0.90 },
        SpawnPoint = { x = -1512.4727783203, y = -542.38592529297, z = 25.707895278931 },
        Heading    = 210.82,
      }
    },

    VehicleDeleters = {
      {x = -1523.171875, y = -550.36083984375, z = 25.707901000977 -0.90},
    },

    BossActions = {
      {x = -1580.4683837891, y = -564.97619628906, z = 104.90416717529 -0.90}
    },

  },

}

Config.AuthorizedVehicles = {
	Shared = {

	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
    
  recruit_wear = {
    male = {
        ['tshirt_1'] = 31,  ['tshirt_2'] = 0,
        ['torso_1'] = 31,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 10,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 28,    ['chain_2'] = 12,
        ['ears_1'] = -1,     ['ears_2'] = 0
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
        ['tshirt_1'] = 31,  ['tshirt_2'] = 0,
        ['torso_1'] = 31,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 10,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = 7,  ['helmet_2'] = 2,
        ['chain_1'] = 28,    ['chain_2'] = 12,
        ['ears_1'] = -1,     ['ears_2'] = 0
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
        ['tshirt_1'] = 31,  ['tshirt_2'] = 0,
        ['torso_1'] = 31,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 10,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = 12,  ['helmet_2'] = 0,
        ['chain_1'] = 28,    ['chain_2'] = 12,
        ['ears_1'] = -1,     ['ears_2'] = 0
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
        ['tshirt_1'] = 31,  ['tshirt_2'] = 0,
        ['torso_1'] = 31,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 10,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = 26,  ['helmet_2'] = 0,
        ['chain_1'] = 28,    ['chain_2'] = 12,
        ['ears_1'] = -1,     ['ears_2'] = 0
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