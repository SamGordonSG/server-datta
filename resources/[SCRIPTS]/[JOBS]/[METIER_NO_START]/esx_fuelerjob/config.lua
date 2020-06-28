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
Config.platePrefix                = "FUEL"

Config.Zones = {

	PetrolFarm = {
		Pos   = {x = 696.413, y = 2889.107, z = 49.0},
		Size  = {x = 10.0, y = 10.0, z = 2.0},
		Color = {r = 0, g = 0, b = 0},
		Name  = "Récolte du pétrole 1",
		Type  = 1
	},


	TraitementPetrol = {
		Pos   = {x = 2746.750, y = 1653.339, z = 23.0},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Traitement du pétrole 2",
		Type  = 1
	},

	TraitementRaffin = {
		Pos   = {x = 2765.624, y = 1709.929, z = 23.0},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Traitement du pétrole raffiné 3",
		Type  = 1
	},
	
	SellFarm = {
		Pos   = {x = -175.947, y = -2385.40, z = 5.0},
		Size  = {x = 4.5, y = 4.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Vente des produits 4",
		Type  = 1
	},

	FuelerActions = {
		Pos   = {x = 1384.053, y = -2079.345, z = 50.99},
		Size  = {x = 2.0, y = 2.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Dépot Raffineurs",
		Type  = 27
	 },
	  
	VehicleSpawner = {
		Pos   = {x = 1385.967, y = -2074.449, z = 50.99},
		Size = {x = 2.0, y = 2.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Garage Véhicules",
		Type  = 27
	},

	VehicleSpawnPoint = {
		Pos   = {x = 1387.569, y = -2057.028, z = 50.99},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Spawn point",
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = {x = 1359.824, y = -2073.328, z = 50.99},
		Size  = {x = 5.0, y = 5.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Name  = "Ranger son véhicule",
		Type  = 27
	}

}

