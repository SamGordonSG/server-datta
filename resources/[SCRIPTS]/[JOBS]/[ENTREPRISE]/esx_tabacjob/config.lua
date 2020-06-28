Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.EnableESXIdentity          = false
Config.Locale                     = 'fr'

Config.Cig = {
  'malbora',
  'gitanes'
}

Config.CigResellChances = {
  malbora = 50,
  gitanes = 50,
}

Config.CigResellQuantity= {
  malbora = {min = 5, max = 10},
  gitanes = {min = 5, max = 10},
}

Config.CigPrices = {
  malbora = {min = 16, max = 20},
  gitanes = {min = 16,   max = 20},
}

Config.CigPricesHigh = {
  malbora = {min = 16, max = 20},
  gitanes = {min = 16,   max = 20},
}

Config.Time = {
	malbora = 5 * 60,
	gitanes = 5 * 60,
}

Config.Blip = {
  Pos     = { x = 2434.8383789063, y = 4988.5268554688, z = 45.974857330322 },
  Sprite  = 181,
  Display = 4,
  Scale   = 0.8,
  Colour  = 48,
}

Config.Zones = {

  TabacActions = {
    Pos   = { x = 2437.5256347656,y = 4970.6625976563,z = 46.810600280762 -0.90 },
    Size  = { x = 1.6, y = 1.6, z = 1.0 },
	Color = {r = 136, g = 243, b = 216},
    Type  = 23,
  },

  Garage = {
    Pos   = { x = 2494.07421875,y = 4852.3037109375,z = 36.303279876709 -0.90 },
    Size  = { x = 1.6, y = 1.6, z = 1.0 },
	Color = {r = 136, g = 243, b = 216},
    Type  = 23,
  },

  Craft = {
    Pos   = { x = 2435.7770996094,y = 4965.5151367188,z = 42.347602844238 -0.90 },
    Size  = { x = 1.6, y = 1.6, z = 1.0 },
	Color = {r = 136, g = 243, b = 216},
    Type  = 27,
  },

  Craft2 = {
    Pos   = { x = 2433.7768554688,y = 4969.0986328125,z = 42.347602844238 -0.90 },
    Size  = { x = 1.6, y = 1.6, z = 1.0 },
	Color = {r = 136, g = 243, b = 216},
    Type  = 27,
  },

  VehicleSpawnPoint = {
    Pos   = { x = 2433.3215332031,y = 4986.1259765625,z = 45.942916870117 -0.90 },
    Size  = { x = 1.6, y = 1.6, z = 1.0 },
    Type  = -1,
  },

  VehicleDeleter = {
    Pos   = { x = 2413.3151855469,y = 4990.9384765625,z = 46.25447845459 -0.90 },
    Size  = { x = 1.6, y = 1.6, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  SellFarm = {
    Pos   = {x = 116.03833770752,y = -1292.025390625,z = 28.260950088501 -0.90},
    Size  = { x = 1.6, y = 1.6, z = 1.0 },
	Color = {r = 136, g = 243, b = 216},
    Name  = "Vente des produits",
    Type  = 1
  },
    
}
