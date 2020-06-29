Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = false
Config.EnableMoneyWash            = true
Config.MaxInService               = -1
Config.Locale                     = 'fr'
Config.EnableESXIdentity          = false
Config.EnableLicenses             = false

Config.MissCraft                  = 10 -- %


Config.AuthorizedVehicles = {
	{ name = 'baller2',  label = '4x4' },
	{ name = 'stretch',  label = 'Limousine' },
	{ name = 'dubsta',  label = '4x4 Employer' },
}

Config.Blips = {
    
    Blip = {
      Pos     = { x = -1386.306, y = -627.525, z = 30.819 },
      Sprite  = 93,
      Display = 4,
      Scale   = 1.2,
      Colour  = 27,
    },

}

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = -1381.103, y = -612.621, z = 29.988 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 27,
    },
	
	    Cloakrooms2 = {
        Pos   = { x = -1379.358, y = -615.295, z = 29.919 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 27,
    },

    Cloakrooms3 = {
        Pos   = { x = 108.128, y = -1304.960, z = 28.768 -0.70 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 27,
    },

    Vaults = {
        Pos   = { x = -1383.443, y = -610.495, z = 29.500 },
        Size  = { x = 1.0, y = 1.0, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 23,
    },

    Vaults2 = {
        Pos   = { x = 93.035, y = -1291.647, z = 29.268 -0.70 },
        Size  = { x = 1.0, y = 1.0, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 23,
    },

    Fridge = {
        Pos   = { x = -1391.357, y = -605.497, z = 29.500 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 23,
    },
	
	Fridge2 = {
        Pos   = { x = -1377.972, y = -630.545, z = 29.919 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 23,
    },

    Fridge3 = {
        Pos   = { x = 128.61489868164,y = -1280.3153076172,z = 29.26953125 -0.90 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 23,
    },

--    Vehicles = {
  --      Pos          = { x = -1357.171, y = -596.753, z = 28.239 },
    --    SpawnPoint   = { x = -1364.046, y = -579.378, z = 28.785 },
      --  Size         = { x = 1.8, y = 1.8, z = 1.0 },
     --   Color = { r = 204, g = 0, b = 204 },
     --   Type         = 23,
    --    Heading      = 30.056,
   -- },

 --[[   Vehicles2 = {
        Pos          = { x = 137.151, y = -1278.473, z = 29.352 -0.70 },
        SpawnPoint   = { x = 142.344, y = -1282.551, z = 29.334 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type         = 23,
        Heading      = 302.079,
    },

    VehicleDeleters = {
        Pos   = { x = -1369.203, y = -584.706, z = 28.740 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 1,
    },

    VehicleDeleters2 = {
        Pos   = { x = 138.587, y = -1275.108, z = 29.297 -0.90 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 1,
    }, ]]--

    Helicopters = {
        Pos          = { x = -1378.586, y = -605.287, z = 42.250 },
        SpawnPoint   = { x = -1388.717, y = -605.827, z = 43.243 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type         = 23,
        Heading      = 207.43,
    },

    HelicopterDeleters = {
        Pos   = { x = -1393.629, y = -625.908, z = 42.243 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 1,
    },

    BossActions = {
        Pos   = { x = -1386.726, y = -608.260, z = 29.419 },
        Size  = { x = 1.0, y = 1.0, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 1,
    },

    BossActions2 = {
        Pos   = { x = 94.822, y = -1292.615, z = 29.268 -0.70 },
        Size  = { x = 1.0, y = 1.0, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 1,
    },

-----------------------
-------- SHOPS --------

    Flacons = {
        Pos   = { x = 381.809, y = 326.240, z = 103.566 -0.70 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 23,
        Items = {
            { name = 'jager',      label = _U('jager'),   price = 30 },
            { name = 'vodka',      label = _U('vodka'),   price = 40 },
            { name = 'rhum',       label = _U('rhum'),    price = 35 },
            { name = 'whisky',     label = _U('whisky'),  price = 70 },
            { name = 'tequila',    label = _U('tequila'), price = 30 },
            { name = 'martini',    label = _U('martini'), price = 50 }
        },
    },

    NoAlcool = {
        Pos   = { x = -714.901, y = -912.641, z = 19.215 -0.70 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 23,
        Items = {
            { name = 'soda',        label = _U('soda'),     price = 25 },
            { name = 'jusfruit',    label = _U('jusfruit'), price = 25 },
            { name = 'icetea',      label = _U('icetea'),   price = 10 },
            { name = 'energy',      label = _U('energy'),   price = 20 },
            { name = 'drpepper',    label = _U('drpepper'), price = 20 },
            { name = 'limonade',    label = _U('limonade'), price = 15 }
        },
    },

    Apero = {
        Pos   = { x = -1824.416, y = 792.954, z = 138.172 -0.70 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 23,
        Items = {
            { name = 'bolcacahuetes',   label = _U('bolcacahuetes'),    price = 7 },
            { name = 'bolnoixcajou',    label = _U('bolnoixcajou'),     price = 10 },
            { name = 'bolpistache',     label = _U('bolpistache'),      price = 15 },
            { name = 'bolchips',        label = _U('bolchips'),         price = 5 },
            { name = 'saucisson',       label = _U('saucisson'),        price = 20 },
            { name = 'grapperaisin',    label = _U('grapperaisin'),     price = 15 }
        },
    },

    Ice = {
        Pos   = { x = -1390.277, y = -600.198, z = 30.319 -0.70 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 204, g = 0, b = 204 },
        Type  = 23,
        Items = {
            { name = 'ice',     label = _U('ice'),      price = 1 },
            { name = 'menthe',  label = _U('menthe'),   price = 2 }
        },
    },

}


-----------------------
----- TELEPORTERS -----


 Config.TeleportZones = {
  EnterBarBaha = {
    Pos       = { x = -1389.436, y = -591.788, z = 30.319 },
    Size      = { x = 1.2, y = 1.2, z = 1.0 },
    Color     = { r = 153, g = 51, b = 255 },
    Marker    = 3,
    Hint      = _U('e_to_enter_1'),
    Teleport  = { x = -1385.232, y = -606.344, z = 30.319 }
  },

  ExitBarBaha = {
    Pos       = { x = -1385.232, y = -606.344, z = 30.319 },
    Size      = { x = 1.2, y = 1.2, z = 1.0 },
    Color     = { r = 153, g = 51, b = 255 },
    Marker    = 3,
    Hint      = _U('e_to_exit_1'),
    Teleport  = { x = -1389.436, y = -591.788, z = 30.319 },
  },
  
  EnterBarBaha2 = {
    Pos       = { x = -1385.946, y = -627.267, z = 30.819 },
    Size      = { x = 1.2, y = 1.2, z = 1.0 },
    Color     = { r = 153, g = 51, b = 255 },
    Marker    = 3,
    Hint      = _U('e_to_enter_1'),
    Teleport  = { x = -1371.348, y = -625.935, z = 30.819 }
  },

  ExitBarBaha2 = {
    Pos       = { x = -1371.348, y = -625.935, z = 30.819 },
    Size      = { x = 1.2, y = 1.2, z = 1.0 },
    Color     = { r = 153, g = 51, b = 255 },
    Marker    = 3,
    Hint      = _U('e_to_exit_1'),
    Teleport  = { x = -1385.946, y = -627.267, z = 30.819 },
  },

  EnterBarUni = {
    Pos       = { x = 133.014, y = -1293.725, z = 29.269 -0.70 },
    Size      = { x = 1.2, y = 1.2, z = 1.0 },
    Color     = { r = 153, g = 51, b = 255 },
    Marker    = 3,
    Hint      = _U('e_to_enter_1'),
    Teleport  = { x = 132.31069946289,y = -1287.1605224609,z = 29.27384185791 -0.90 }
  },

  ExitBarUni = {
    Pos       = { x = 132.31069946289,y = -1287.1605224609,z = 29.27384185791 -0.90 },
    Size      = { x = 1.2, y = 1.2, z = 1.0 },
    Color     = { r = 153, g = 51, b = 255 },
    Marker    = 3,
    Hint      = _U('e_to_exit_1'),
    Teleport  = { x = 133.014, y = -1293.725, z = 29.269 -0.70 },
  },
  
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
  barman_outfit = {
    male = {
        ['tshirt_1'] = 6,  ['tshirt_2'] = 0,
        ['torso_1'] = 11,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 11,
        ['pants_1'] = 24,   ['pants_2'] = 0,
        ['shoes_1'] = 36,   ['shoes_2'] = 3
    },
    female = {
        ['tshirt_1'] = 6,   ['tshirt_2'] = 0,
        ['torso_1'] = 12,    ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 12,
        ['pants_1'] = 8,   ['pants_2'] = 0,
        ['shoes_1'] = 0,    ['shoes_2'] = 0
    }
  },
  dancer_outfit_1 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 40,
        ['pants_1'] = 61,   ['pants_2'] = 9,
        ['shoes_1'] = 16,   ['shoes_2'] = 9,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 6,   ['tshirt_2'] = 0,
        ['torso_1'] = 22,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 4,
        ['pants_1'] = 19,   ['pants_2'] = 1,
        ['shoes_1'] = 42,   ['shoes_2'] = 2
    }
  },
  dancer_outfit_2 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 62,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 14,
        ['pants_1'] = 4,    ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 6,   ['tshirt_2'] = 0,
        ['torso_1'] = 22,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 4,
        ['pants_1'] = 19,   ['pants_2'] = 0,
        ['shoes_1'] = 42,   ['shoes_2'] = 8
    }
  },
  dancer_outfit_3 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 4,    ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 8,   ['tshirt_2'] = 0,
        ['torso_1'] = 112,   ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 4,
        ['pants_1'] = 15,   ['pants_2'] = 0,
        ['shoes_1'] = 42,   ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  }
}
