--------------------------------
------- Created by Hamza -------
-------------------------------- 

Config = {}

-- Pawn Shop Positions:
Config.PawnZones = {
	PawnShops = {
		Pos = {
			{x = -39.16,  y = -1388.12, z = 30.49 - 0.7}
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
Config.ShopDraw3DText = "Appuyez sur ~g~[E]~s~ pour ouvrir le ~y~ magasin illégal~s~"					-- set your desired text here

-- Pawn Shop Item List:
Config.ItemsInPawnShop = {
	{ itemName = 'seed_weed', label = 'Graines', BuyInPawnShop = true, BuyPrice = 50, SellInPawnShop = false, SellPrice = 2500 },
	{ itemName = 'cagoule', label = 'Cagoule', BuyInPawnShop = true, BuyPrice = 50, SellInPawnShop = false, SellPrice = 2500 },
	{ itemName = 'rope', label = 'Corde', BuyInPawnShop = true, BuyPrice = 50, SellInPawnShop = false, SellPrice = 2500 },
	{ itemName = 'id_card', label = 'Pass', BuyInPawnShop = true, BuyPrice = 3000, SellInPawnShop = false, SellPrice = 2500 },
	{ itemName = 'thermal_charge', label = 'Charge thermique', BuyInPawnShop = true, BuyPrice = 1500, SellInPawnShop = false, SellPrice = 2500 },
	{ itemName = 'laptop_h', label = 'Ordi portable', BuyInPawnShop = true, BuyPrice = 2000, SellInPawnShop = false, SellPrice = 2500 },
	{ itemName = 'lockpick', label = 'Crochet', BuyInPawnShop = true, BuyPrice = 500, SellInPawnShop = false, SellPrice = 2500 },
	{ itemName = 'gold_bar', label = 'Lingot d or', BuyInPawnShop = false, BuyPrice = 1500, SellInPawnShop = true, SellPrice = 300 },
	{ itemName = 'dia_box', label = 'Diamants', BuyInPawnShop = false, BuyPrice = 1500, SellInPawnShop = true, SellPrice = 500 },
}

