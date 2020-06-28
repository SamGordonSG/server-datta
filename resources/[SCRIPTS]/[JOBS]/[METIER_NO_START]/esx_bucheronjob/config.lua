-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------

Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.Locale                     = 'fr'
Config.platePrefix                = "BUCHE"

Config.Zones = {

	WoodFarm = {
		Pos   = {x = 347.707, y = 4450.786, z = 61.89},
		Size  = {x = 10.0, y = 10.0, z = 2.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Récolte du Bois 1",
		Type  = 1
	},


	TraitementWood = {
		Pos   = {x = -535.51, y = 5267.08, z = 73.17},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Traitement du Bois 2",
		Type  = 1
	},

	TraitementPlank = {
		Pos   = {x = -509.52, y = 5258.05, z = 79.62},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Traitement du bois coupé 3",
		Type  = 1
	},
	
	SellFarm = {
		Pos   = {x = 1201.35, y = -1327.51, z = 34.30},
		Size  = {x = 4.5, y = 4.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Vente des produits 4",
		Type  = 1
	},

	BucheronActions = {
		Pos   = {x = -560.535, y = 5282.643, z = 72.05},
		Size  = {x = 2.0, y = 2.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Scierie",
		Type  = 1
	 },
	  
	VehicleSpawner = {
		Pos   = {x = -568.278, y = 5253.023, z = 69.487},
		Size = {x = 2.0, y = 2.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Garage Véhicules",
		Type  = 1
	},

	VehicleSpawnPoint = {
		Pos   = {x = -576.430, y = 5252.06, z = 69.46},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Spawn point",
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = {x = -600.328, y = 5304.579, z = 69.21},
		Size  = {x = 5.0, y = 5.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Name  = "Ranger son véhicule",
		Type  = 1
	}

}

