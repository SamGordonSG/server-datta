Config.Jobs.miner = {

	BlipInfos = {
		Sprite = 318,
		Color = 5
	},

	Vehicles = {

		Truck = {
			Spawner = 1,
			Hash = "rubble",
			Trailer = "none",
			HasCaution = false
		}

	},

	Zones = {

		CloakRoom = {
			Pos = {x = 892.35, y = -2172.77, z = 31.29},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 255, g = 255, b = 255},
			Marker = 23,
			Blip = true,
			Name = _U("m_miner_locker"),
			Type = "cloakroom",
			Hint = _U("cloak_change"),
			GPS = {x = 884.86, y = -2176.51, z = 29.51}
		},

		Mine = {
			Pos = {x = 2962.40, y = 2746.20, z = 42.50},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 255, g = 255, b = 255},
			Marker = 23,
			Blip = true,
			Name = _U("m_rock"),
			Type = "work",
			Item = {
				{
					name = _U("m_rock"),
					db_name = "stone",
					time = 10000,
					max = 5,
					add = 1,
					remove = 1,
					requires = "nothing",
					requires_name = "Nothing",
					drop = 100
				}
			},
			Hint = _U("m_pickrocks"),
			GPS = {x = 289.24, y = 2862.90, z = 42.64}
		},

		StoneWash = {
			Pos = {x = 289.24, y = 2862.90, z = 42.70},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 255, g = 255, b = 255},
			Marker = 23,
			Blip = true,
			Name = _U("m_washrock"),
			Type = "work",
			Item = {
				{
					name = _U("m_washrock"),
					db_name = "washed_stone",
					time = 8000,
					max = 5,
					add = 1,
					remove = 1,
					requires = "stone",
					requires_name = _U("m_rock"),
					drop = 100
				}
			},
			Hint = _U("m_rock_button"),
			GPS = {x = 1109.14, y = -2007.87, z = 30.01}
		},

		Foundry = {
			Pos = {x = 1074.94, y = -1951.59, z = 30.41},
			Size = {x = 8.0, y = 8.0, z = 1.0},
			Color = {r = 255, g = 255, b = 255},
			Marker = 23,
			Blip = true,
			Name = _U("m_rock_smelting"),
			Type = "work",
			Item = {
				{
					name = _U("m_copper"),
					db_name = "copper",
					time = 8000,
					max = 25,
					add = 1,
					remove = 1,
					requires = "washed_stone",
					requires_name = _U("m_washrock"),
					drop = 100
				},
				{
					name = _U("m_iron"),
					db_name = "iron",
					max = 25,
					add = 1,
					drop = 100
				},
				{
					name = _U("m_gold"),
					db_name = "gold",
					max = 25,
					add = 1,
					drop = 100
				},
				{
					name = _U("m_diamond"),
					db_name = "diamond",
					max = 25,
					add = 1,
					drop = 5
				}
			},
			Hint = _U("m_melt_button"),
			GPS = {x = -169.48, y = -2659.16, z = 5.00}
		},

		VehicleSpawner = {
			Pos = {x = 884.86, y = -2176.51, z = 29.60},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 255, g = 255, b = 255},
			Marker = 23,
			Blip = true,
			Name = _U("spawn_veh"),
			Type = "vehspawner",
			Spawner = 1,
			Hint = _U("spawn_veh_button"),
			Caution = 0,
			GPS = {x = 2962.40, y = 2746.20, z = 42.39}
		},

		VehicleSpawnPoint = {
			Pos = {x = 879.55, y = -2189.79, z = 29.51},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Marker = -1,
			Blip = false,
			Name = _U("service_vh"),
			Type = "vehspawnpt",
			Spawner = 1,
			Heading = 90.1,
			GPS = 0
		},

		VehicleDeletePoint = {
			Pos = {x = 881.93, y = -2198.01, z = 29.51},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Marker = 23,
			Blip = false,
			Name = _U("return_vh"),
			Type = "vehdelete",
			Hint = _U("return_vh_button"),
			Spawner = 1,
			Caution = 0,
			GPS = 0,
			Teleport = 0
		},

		CopperDelivery = {
			Pos = {x = -169.481, y = -2659.16, z = 5.55},
			Color = {r = 255, g = 255, b = 255},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			Marker = 23,
			Blip = true,
			Name = _U("m_sell_copper"),
			Type = "delivery",
			Spawner = 1,
			Item = {
				{
					name = _U("delivery"),
					time = 5000,
					remove = 1,
					max = 10, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 10,
					requires = "copper",
					requires_name = _U("m_copper"),
					drop = 100
				}
			},
			Hint = _U("m_deliver_copper"),
			GPS = {-169.481, y = -2659.16, z = 5.05}
		},

		IronDelivery = {
			Pos = {x = -140.82, y = -2664.08, z = 5.55},
			Color = {r = 1, g = 255, b = 255},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			
			Marker = 23,
			Blip = true,
			Name = _U("m_sell_iron"),
			Type = "delivery",
			Spawner = 1,
			Item = {
				{
					name = _U("delivery"),
					time = 5000,
					remove = 1,
					max = 10, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 5,
					requires = "iron",
					requires_name = _U("m_iron"),
					drop = 100
				}
			},
			Hint = _U("m_deliver_iron"),
			GPS = {x = -140.82, y = -2664.08, z = 5.05}
		},

		GoldDelivery = {
			Pos = {x = -183.30, y = -2640.78, z = 5.55},
			Color = {r = 255, g = 255, b = 255},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			
			Marker = 23,
			Blip = true,
			Name = _U("m_sell_gold"),
			Type = "delivery",
			Spawner = 1,
			Item = {
				{
					name = _U("delivery"),
					time = 5000,
					remove = 1,
					max = 10, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 5,
					requires = "gold",
					requires_name = _U("m_gold"),
					drop = 100
				}
			},
			Hint = _U("m_deliver_gold"),
			GPS = {x = -183.30, y = -2640.78, z = 5.05}
		},

		DiamondDelivery = {
			Pos = {x = -170.20, y = -2707.48, z = 5.55},
			Color = {r = 255, g = 255, b = 255},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			
			Marker = 23,
			Blip = true,
			Name = _U("m_sell_diamond"),
			Type = "delivery",
			Spawner = 1,
			Item = {
				{
					name = _U("delivery"),
					time = 5000,
					remove = 1,
					max = 10, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 12,
					requires = "diamond",
					requires_name = _U("m_diamond"),
					drop = 100
				}
			},
			Hint = _U("m_deliver_diamond"),
			GPS = {x = -170.20, y = -2707.48, z = 5.05}
		}

	}
}
