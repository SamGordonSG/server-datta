Config              = {}
Config.MarkerType   = -1
Config.DrawDistance = 100.0
Config.ZoneSize     = {x = 5.0, y = 5.0, z = 3.0}
Config.MarkerColor  = {r = 100, g = 204, b = 100}
Config.ShowBlips    = false

Config.RequiredCopsCoke  	= 0
--------------------------------
--------------------------------
Config.RequiredCopsMeth     = 0
Config.RequiredCopsMethlab  = 0
Config.RequiredCopsAcetone  = 0
Config.RequiredCopsLithium  = 0
--------------------------------
--------------------------------
Config.RequiredCopsCrack    = 0
Config.RequiredCopsKetamine = 0
Config.RequiredCopsEcstasy  = 0
-------------------------------
Config.RequiredCopsBillet   = 0
-------------------------------
Config.RequiredCopsOpium    = 0

Config.TimeToFarm           = 2 * 1000
Config.TimeToProcess        = 2 * 1000
Config.TimeToSell           = 2 * 1000

Config.Locale = 'fr'

Config.Zones = {
    CokeField           = {x = 778.08227539063, y = 4183.7612304688,z = 41.789203643799 -0.90,   name = _U('coke_field'),         sprite = 501,    color = 40},
    CokeProcessing      = {x = 1981.9660644531, y = 5178.1201171875,z = 47.639114379883 -0.90,   name = _U('coke_processing'),    sprite = 478,    color = 40},
    CokeDealer          = {x = -1101.5760498047, y = 4940.8940429688,z = 218.35398864746 -0.90,   name = _U('coke_dealer'),        sprite = 500,    color = 75},
	---------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------
	MethField           = {x = 1905.7355957031, y = 4828.01171875, z = 45.674133300781 -0.90,     name = _U('meth_field'),         sprite = 499,    color = 26},
	MethlabField        = {x = -2168.4477539063, y = 5197.6372070313, z = 17.028646469116 -0.90,   name = _U('methlab_field'),      sprite = 499,    color = 26},
	AcetoneField        = {x = 3725.2182617188, y = 4525.6513671875, z = 22.471559524536 -0.90,   name = _U('acetone_field'),      sprite = 499,    color = 26},
	LithiumField        = {x = -233.89, y=6276.41,    z=31.68,   name = _U('lithium_field'),      sprite = 499,    color = 26},
	MethProcessing      = {x = 1444.0928955078, y = 6333.013671875, z = 23.895652770996 -0.90,     name = _U('meth_processing'),    sprite = 499,    color = 26},
    MethDealer          = {x = 2168.2263183594, y = 3330.8664550781, z = 46.517101287842 -0.90,   name = _U('meth_dealer'),        sprite = 500,    color = 75},
	---------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------
	CrackField          = {x = 51.113803863525,y = 4467.201171875, z = 60.79264831543 -0.90,	name = _U('crack_field'),		 sprite = 501,	color = 40},
	CrackProcessing     = {x = 200.99481201172,y = 2441.8264160156, z = 60.455101013184 -0.90,	name = _U('crack_processing'),	 sprite = 478,	color = 40},
	CrackDealer         = {x = -1928.2407226563,y = 1779.13671875, z = 173.09524536133 -0.90,	name = _U('crack_dealer'),		 sprite = 500,	color = 75},
	KetamineField       = {x = 3120.7136230469,y = 1164.4984130859, z = 19.83819770813 -0.90,	name = _U('ketamine_field'),	 sprite = 499,	color = 26},
	KetamineProcessing  = {x = -75.666397094727,y = -2666.8977050781, z = 6.0010118484497 -0.90,	name = _U('ketamine_processing'),sprite = 499,	color = 26},
	KetamineDealer      = {x = -1579.9099121094,y = 769.07818603516, z = 189.19430541992 -0.90,	name = _U('ketamine_dealer'),	 sprite = 500,	color = 75},
	EcstasyField        = {x = -248.85534667969,y = 6330.9599609375, z = 32.42618560791 -0.90,	name = _U('ecstasy_field'),		 sprite = 496,	color = 52},
	EcstasyProcessing   = {x = 681.66223144531,y = -2700.3869628906, z = 7.1716914176941 -0.90,	name = _U('ecstasy_processing'), sprite = 496,	color = 52},
	EcstasyDealer       = {x = 2510.2102050781,y = -1222.7843017578, z = 2.9071178436279 -0.90,	name = _U('ecstasy_dealer'),	 sprite = 500,	color = 75},
	---------------------------------------------------------------------------------------------------------------------------
	BilletField         = {x=605.4480,  y=-3093.4470, z=6.0692,	name = _U('billet_field'),		 sprite = 500,	color = 1},
	BilletProcessing    = {x=-1077.92,  y=-1678.19,  z=3.57,	name = _U('billet_processing'),	 sprite = 500,	color = 1},
	BilletDealer        = {x = -805.46917724609,y = 169.46632385254,z = 72.844665527344,	name = _U('billet_dealer'),		 sprite = 500,	color = 1},
	---------------------------------------------------------------------------------------------------------------------------
	OpiumField      	= {x=1838.24,	y=5035.191,  z=57.272,	name = _U('opium_field'),		 sprite = 51,	color = 60},
	OpiumProcessing 	= {x=-438.544,  y=-2184.25,  z=10.522,	name = _U('opium_processing'),	 sprite = 51,	color = 60},
	OpiumDealer     	= {x=-1217.199, y=-1055.398, z=8.412,	name = _U('opium_dealer'),		 sprite = 500,	color = 75}
}
