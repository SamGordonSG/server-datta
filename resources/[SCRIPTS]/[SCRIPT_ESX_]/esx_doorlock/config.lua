Config = {}
Config.Locale = 'fr'

Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors
	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = { 'police', 'sheriff' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ph_door01',
				objYaw = -90.0,
				objCoords = vector3(434.7, -980.6, 30.8)
			},

			{
				objName = 'v_ilev_ph_door002',
				objYaw = -90.0,
				objCoords = vector3(434.7, -983.2, 30.8)
			}
		}
	},

	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 90.0,
		objCoords  = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objYaw = 90.0,
		objCoords  = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -984.0, 44.8),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = 90.0,
		objCoords  = vector3(461.2, -985.3, 30.8),
		textCoords = vector3(461.5, -986.0, 31.5),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true
	},

	-- Armory
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = -90.0,
		objCoords  = vector3(452.6, -982.7, 30.6),
		textCoords = vector3(453.0, -982.6, 31.7),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = -180.0,
		objCoords  = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.2, -980.0, 31.7),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true
	},

	-- To downstairs (double doors)
	{
		textCoords = vector3(444.6, -989.4, 31.7),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 180.0,
				objCoords = vector3(443.9, -989.0, 30.6)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 0.0,
				objCoords = vector3(445.3, -988.7, 30.6)
			}
		}
	},

	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -90.0,
		objCoords  = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true
	},

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(463.4, -1003.5, 25.0),
		textCoords = vector3(464.0, -1003.5, 25.5),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true
	},
	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 0.0,
				objCoords  = vector3(467.3, -1014.4, 26.5)
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = 180.0,
				objCoords  = vector3(469.9, -1014.4, 26.5)
			}
		}
	},

	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objYaw = 90.0,
		objCoords  = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true,
		distance = 14,
		size = 2
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objYaw = 30.0,
		objCoords  = vector3(1855.1, 3683.5, 34.2),
		textCoords = vector3(1855.1, 3683.5, 35.0),
		authorizedJobs = { 'police', 'sheriff' },
		locked = false
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		textCoords = vector3(-443.5, 6016.3, 32.0),
		authorizedJobs = { 'police', 'sheriff' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_shrf2door',
				objYaw = -45.0,
				objCoords  = vector3(-443.1, 6015.6, 31.7),
			},

			{
				objName = 'v_ilev_shrf2door',
				objYaw = 135.0,
				objCoords  = vector3(-443.9, 6016.6, 31.7)
			}
		}
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true,
		distance = 12,
		size = 2
	},
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true
	},
	
	--MECANO/LS CUSTOMS/BENNY'S
	-- LS Customs Centre ville
	{
		objName = 'prop_com_ls_door_01',
		objCoords  = vector3(-356.09, -134.77, 40.01),
		textCoords = vector3(-356.09, -134.77, 41.01),
		authorizedJobs = { 'mecano', 'mechanic' },
		locked = true,
		distance = 12,
		size = 2
	},
	-- LS Customs Sous le pont
	{
		objName = 'prop_id2_11_gdoor',
		objCoords  = vector3(723.116, -1088.831, 23.23),
		textCoords = vector3(723.116, -1088.831, 24.23),
		authorizedJobs = { 'mecano', 'mechanic' },
		locked = true,
		distance = 18,
		size = 2
	},
	-- LS Customs Aéroport
	{
		objName = 'prop_com_ls_door_01',
		objCoords  = vector3(-1145.898, -1991.144, 14.18),
		textCoords = vector3(-1145.898, -1991.144, 15.18),
		authorizedJobs = { 'mecano', 'mechanic' },
		locked = true,
		distance = 18,
		size = 2
	},
	-- LS Customs Sandy Shore Portail Droit
	{
		objName = 'v_ilev_carmod3door',
		objCoords  = vector3(1174.656, 2644.159, 40.50),
		textCoords = vector3(1174.656, 2644.159, 41.50),
		authorizedJobs = { 'mecano', 'mechanic' },
		locked = true,
		distance = 18,
		size = 2
	},
	-- LS Customs Sandy Shore Portail Gauche
	{
		objName = 'v_ilev_carmod3door',
		objCoords  = vector3(1182.307, 2644.166, 40.50),
		textCoords = vector3(1182.307, 2644.166, 41.50),
		authorizedJobs = { 'mecano', 'mechanic' },
		locked = true,
		distance = 18,
		size = 2
	},
	-- LS Customs Paleto Portail Droit 
	{
		objName = 'v_ilev_carmod3door',
		objCoords  = vector3(114.3135, 6623.233, 32.67),
		textCoords = vector3(114.3135, 6623.233, 33.67),
		authorizedJobs = { 'mecano', 'mechanic' },
		locked = true,
		distance = 18,
		size = 2
	},
	-- LS Customs Paleto Portail Gauche 
	{
		objName = 'v_ilev_carmod3door',
		objCoords  = vector3(108.8502, 6617.877, 32.67),
		textCoords = vector3(108.8502, 6617.877, 33.67),
		authorizedJobs = { 'mecano', 'mechanic' },
		locked = true,
		distance = 18,
		size = 2
	},
	-- Benny's Customs
	{
		objName = 'lr_prop_supermod_door_01',
		objCoords  = vector3(-205.6828, -1310.683, 30.29),
		textCoords = vector3(-205.6828, -1310.683, 31.29),
		authorizedJobs = { 'mecano', 'mechanic' },
		locked = true,
		distance = 18,
		size = 2
	},


	-- Double portes Gouvernement
	{
		textCoords = vector3(-74.79, -821.76, 244.541),
		authorizedJobs = { 'police', 'sheriff', 'state', 'ambulance' },
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'ex_prop_exec_office_door01',
				objYaw = 159.9530029296875,
				objCoords = vector3(-75.56609344482422, -821.4784545898438, 243.54104614257812)
			},

			{
				objName = 'ex_prop_exec_office_door01',
				objYaw = -19.934186935424805,
				objCoords = vector3(-74.0156021118164, -822.0427856445312, 243.54104614257812)
			}
		}
	},

	--Portail accès garage Gouvernement
	{
		objName = 'prop_facgate_07',
		objCoords  = vector3(-388.83428955078125, 1167.615966796875, 325.0751037597656),
		textCoords = vector3(-388.83428955078125, 1167.615966796875, 325.5751037597656),
		authorizedJobs = { 'police', 'sheriff', 'state' },
		locked = true,
		distance = 14,
		size = 2
	},	

		-- Portail droit Gouv
        {
			objName = 'prop_gate_tep_01_r',
			objYaw = -24.040491104125977,
			objCoords  = vector3(-409.1111145019531, 1169.204833984375, 326.6372375488281),
			textCoords = vector3(-409.1111145019531, 1169.204833984375, 327.6372375488281),
			authorizedJobs = { 'police', 'state', 'ambulance', 'sheriff'},
			locked = true,
			distance = 14,
			size = 0.8
			 },
	--
	-- Addons
	--

	--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(420.1, -1017.3, 28.0),
		textCoords = vector3(420.1, -1021.0, 32.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}