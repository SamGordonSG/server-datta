--------------------------------
------- Created by Hamza -------
-------------------------------- 

Config = {}

-- Pawn Shop Positions:
Config.PawnZones = {
	PawnShops = {
		Pos = {
			{x = -1097.4895019531,y = -839.85504150391,z = 19.00150680542}
		}
	}
}

-- Pawn Shop Blip Settings:
Config.EnablePawnShopBlip = false
Config.BlipSprite = 59
Config.BlipDisplay = 4
Config.BlipScale = 0.65
Config.BlipColour = 5
Config.BlipName = "Pawn Shop"

-- Pawn Shop Marker Settings:
Config.KeyToOpenShop = 38														-- default 38 is E
Config.ShopMarker = 27 															-- marker type
Config.ShopMarkerColor = { r = 255, g = 255, b = 0, a = 100 } 					-- rgba color of the marker
Config.ShopMarkerScale = { x = 1.0, y = 1.0, z = 1.0 }  						-- the scale for the marker on the x, y and z axis
Config.ShopDraw3DText = "Appuyez sur ~g~[E]~s~ pour demander à ~y~Gina~s~ des badges"					-- set your desired text here

-- Pawn Shop Item List:
Config.ItemsInPawnShop = {
	{ itemName = 'badgepolice', label = 'Badge d accès ascenseur', BuyInPawnShop = true, BuyPrice = 100, SellInPawnShop = false, SellPrice = 2500 },
}

