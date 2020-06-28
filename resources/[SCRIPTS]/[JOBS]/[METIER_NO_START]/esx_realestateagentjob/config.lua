Config              = {}
Config.DrawDistance = 100.0
Config.MarkerColor  = { r = 120, g = 120, b = 240 }
Config.Locale       = 'fr'
Config.EnableSocietyOwnedVehicles = false
Config.platePrefix  = "IMMO"

Config.Zones = {
  OfficeEnter = {
    Pos   = { x = -199.151, y = -575.000, z = 39.489 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 1,
  },

  OfficeExit = {
    Pos   = { x = -141.226, y = -614.166, z = 167.820 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 1,
  },

  OfficeInside = {
    Pos   = { x = -140.969, y = -616.785, z = 167.820 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  OfficeOutside = {
    Pos   = { x = -202.238, y = -578.193, z = 39.500 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  OfficeActions = {
    Pos   = { x = -124.786, y = -641.486, z = 167.820 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },
  
  VehicleSpawner = {
		Pos   = {x = -181.20, y = -632.78, z = 32.01},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Garage véhicule",
		Type  = 0
	},

	VehicleSpawnPoint = {
		Pos   = {x = -179.74, y = -620.87, z = 31.42},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Spawn point",
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = {x = -169.47, y = -632.01, z = 31.98},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Ranger son véhicule",
		Type  = 0
	},
}
