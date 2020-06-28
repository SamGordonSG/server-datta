Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.platePrefix                = "AMMU"
Config.NPCJobEarnings             = { min = 200, max = 200 }
Config.Locale                     = 'fr'
Config.PrixClip					  = 300

--PRIX CONSTRUCTION ARMES

Config.Price = {

    weapon_nightstick 	= 0,
    weapon_stungun 		= 0 ,
	  weapon_snspistol		= 0 ,
    weapon_pistol 		= 0 ,
    weapon_pistol_mk2 		= 0,
	  weapon_combatpistol 	= 0 , 
	  weapon_pistol50 		= 0,    
	  weapon_doubleaction 	= 0, 
    weapon_musket 		= 0 ,      
    weapon_pumpshotgun 		= 0,   
    weapon_pumpshotgun_mk2 		= 0,
    weapon_bullpupshotgun 		= 0,
    weapon_carbinerifle 	= 0 ,
    weapon_carbinerifle_mk2 	= 0,
    weapon_specialcarbine 	= 0 ,
    weapon_specialcarbine_mk2 	= 0 ,
	  weapon_combatpdw 		= 0 ,        
	  weapon_smg 			= 0 ,           
	  weapon_assaultsmg 	= 0 ,       
	  weapon_assaultshotgun = 0 ,     
    weapon_sniperrifle 	= 0 ,       
    weapon_heavysniper 	= 0 ,
}

Config.Zones = {
  AmmunationActions = {
    Pos   = { x = 826.94, y = -2151.82, z = 28.61 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  Matos = {
    Pos   = { x = 883.821, y = -3207.646, z = -98.196 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 25,
  },
  --- farm munition
  Poudre = { --EST
    Pos   = { x = 887.515, y = -3209.379, z = -98.196 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 25,
  },
  Douille = {--SANDY SHORE 
    Pos   = { x = 892.209, y = -3197.919, z = -98.190 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 25,
  },
  Revente = {--merryweather
    Pos   = { x = 610.263, y = -3079.730, z = 6.069 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 25,
  },
--- fin farm munition
  Craft = {--port
    Pos   = { x = 905.733, y = -3230.186, z = -98.294 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 25,
  },

  VehicleSpawnPoint = { 
    Pos   = { x = 821.73, y = -2142.62, z = 27.75 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Type  = -1,
  },

  VehicleDeleter = {
    Pos   = { x = 821.73, y = -2142.62, z = 27.75 },
    Size  = { x = 3.0, y = 3.0, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  }
}