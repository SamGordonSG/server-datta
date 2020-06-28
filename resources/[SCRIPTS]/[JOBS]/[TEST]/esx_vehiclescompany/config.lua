---------------------------------------------------------------------------------------
---------------------------------SCRIPT VEHICLES SHOP ENTREPRISES----------------------
---------------------------------CONFIG GLOBALE----------------------------------------
---------------------------------------------------------------------------------------
Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnableESXService 		  = false
Config.StoreOnServerStart		  = true

Config.Locale                     = 'fr'

---------------------------------------------------------------------------------------
-------------------------------CONFIG BRASSEURS----------------------------------------
---------------------------------------------------------------------------------------
Config.BrasseurStations = {

	Brasserie = {

		Vehicles = {
			{
				Spawner = vector3(1547.905, 2190.264, 78.819),
				InsideShop = vector3(1530.771, 2188.005, 79.221),
				SpawnPoints = {
					{coords =  vector3(1552.682, 2193.063, 78.874), heading = 3.08, radius = 6.0},
					{coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
					{coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
					{coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
				}
			}

        }
    }

}

Config.AuthorizedVehicles = {
	Shared = {   
		{ model = 'gburrito2', label = 'Burrito', price = 68200},
	},

	recrue = {
		{ model = 'gburrito2', label = 'Burrito', price = 68200},
    },
    
    novice = {
		{ model = 'gburrito2', label = 'Burrito', price = 68200},
    },
    
    cdisenior = {
		{ model = 'gburrito2', label = 'Burrito', price = 68200},
		{ model = 'dominator2', label = 'Véhicule de Fonction', price = 66000},
    },
    
    boss = {
		{ model = 'gburrito2', label = 'Burrito', price = 68200},
		{ model = 'dominator2', label = 'Véhicule de Fonction', price = 66000},
	}
}

---------------------------------------------------------------------------------------
-------------------------------CONFIG AMBULANCE----------------------------------------
---------------------------------------------------------------------------------------

Config.AmbulanceStations = {

	Hopital = {

		Vehicles2 = {
			{
				Spawner = vector3(297.103, -615.718, 43.461),
				InsideShop = vector3(290.117, -611.413, 43.381),
				SpawnPoints = {
					{coords =  vector3(290.598, -612.979, 43.400), heading = 61.13, radius = 6.0},
					{coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
					{coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
					{coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
				}
			}

        }
    }

}

Config.AuthorizedVehicles2 = {
	Shared = {   
		{model = 'ambulance', label = 'Ambulance', price = 1},
		{model = 'ambulance2', label = 'Ambulance 2', price = 1},
		{model = 'emscar', label = 'Voiture', price = 1},
		{model = 'emscar2', label = 'Voiture 2', price = 1},
		{model = 'emssuv', label = '4x4', price = 1},
	},

	ambulance = {
		{model = 'ambulance', label = 'Ambulance', price = 1},
		{model = 'ambulance2', label = 'Ambulance 2', price = 1},
		{model = 'emscar', label = 'Voiture', price = 1},
		{model = 'emscar2', label = 'Voiture 2', price = 1},
		{model = 'emssuv', label = '4x4', price = 1},

    },
    
    doctor = {
		{model = 'ambulance', label = 'Ambulance', price = 1},
		{model = 'ambulance2', label = 'Ambulance 2', price = 1},
		{model = 'emscar', label = 'Voiture', price = 1},
		{model = 'emscar2', label = 'Voiture 2', price = 1},
		{model = 'emssuv', label = '4x4', price = 1},

    },
    
    chief_doctor = {
		{model = 'ambulance', label = 'Ambulance', price = 1},
		{model = 'ambulance2', label = 'Ambulance 2', price = 1},
		{model = 'emscar', label = 'Voiture', price = 1},
		{model = 'emscar2', label = 'Voiture 2', price = 1},
		{model = 'emssuv', label = '4x4', price = 1},

    },
    
    boss = {
		{model = 'ambulance', label = 'Ambulance', price = 1},
		{model = 'ambulance2', label = 'Ambulance 2', price = 1},
		{model = 'emscar', label = 'Voiture', price = 1},
		{model = 'emscar2', label = 'Voiture 2', price = 1},
		{model = 'emssuv', label = '4x4', price = 1},

	}
}

---------------------------------------------------------------------------------------
-------------------------------CONFIG PETIT-STUDIO-------------------------------------
---------------------------------------------------------------------------------------

---BAHAMA_MAMAS

Config.BahaStations = {

	Baha = {

		Vehicles3 = {
			{
				Spawner = vector3(-1421.626, -641.435, 28.673),
				InsideShop = vector3(-1414.916, -646.707, 28.673),
				SpawnPoints = {
					{coords =  vector3(-1408.563, -637.533, 28.673), heading = 210.42, radius = 6.0},
					{coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
					{coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
					{coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
				}
			}

        }
	}
	
}

Config.AuthorizedVehicles3 = {
	Shared = {   
		{model = 'dubsta', label = '4x4', price = 49500},
	},

	barman = {
		{model = 'dubsta', label = '4x4', price = 49500},
    },
    
    dancer = {
		{model = 'dubsta', label = '4x4', price = 49500},
    },
    
    viceboss = {
		{model = 'baller2', label = '4x4', price = 68000},
		{model = 'dubsta', label = '4x4', price = 49500},
		{model = 'stretch', label = '4x4', price = 125000},
    },
    
    boss = {
		{model = 'baller2', label = '4x4', price = 68000},
		{model = 'dubsta', label = '4x4', price = 49500},
		{model = 'stretch', label = '4x4', price = 125000},
	}
}


---UNICORN---


Config.UniStations = {

	Uni = {

		Vehicles5 = {
			{
				Spawner = vector3(148.936, -1288.186, 29.183),
				InsideShop = vector3(149.254, -1279.182, 29.156),
				SpawnPoints = {
					{coords =  vector3(142.042, -1282.879, 29.337), heading = 299.13, radius = 6.0},
					{coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
					{coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
					{coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
				}
			}

        }
    }

}

Config.AuthorizedVehicles5 = {
	Shared = {   
		{model = 'dubsta', label = '4x4', price = 49500},
	},

	barman = {
		{model = 'dubsta', label = '4x4', price = 49500},
    },
    
    dancer = {
		{model = 'dubsta', label = '4x4', price = 49500},
    },
    
    viceboss = {
		{model = 'baller2', label = '4x4', price = 68000},
		{model = 'dubsta', label = '4x4', price = 49500},
		{model = 'stretch', label = '4x4', price = 125000},
    },
    
    boss = {
		{model = 'baller2', label = '4x4', price = 68000},
		{model = 'dubsta', label = '4x4', price = 49500},
		{model = 'stretch', label = '4x4', price = 125000},
	}
}


---------------------------------------------------------------------------------------
-------------------------------CONFIG FOODTRUCK----------------------------------------
---------------------------------------------------------------------------------------

Config.FoodStations = {

	Resto = {

		Vehicles4 = {
			{
				Spawner = vector3(403.665, -1935.741, 24.351),
				InsideShop = vector3(429.307, -1926.952, 24.344),
				SpawnPoints = {
					{coords =  vector3(414.478, -1928.451, 24.524), heading = 219.69, radius = 6.0},
					{coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
					{coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
					{coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
				}
			}

        }
	}

}

Config.AuthorizedVehicles4 = {
	Shared = {   
		{model = 'taco', label = 'FoodTruck', price = 65000},
	},

	recruit = {
		{model = 'taco', label = 'FoodTruck', price = 65000},
    },
    
    cook = {
		{model = 'taco', label = 'FoodTruck', price = 65000},
    },
    
    chief = {
		{model = 'taco', label = 'FoodTruck', price = 65000},
		{model = 'stalion2', label = 'Vehicule de Fonction', price = 85000},
    },
    
    boss = {
		{model = 'taco', label = 'FoodTruck', price = 65000},
		{model = 'stalion2', label = 'Vehicule de Fonction', price = 85000},
	}
}