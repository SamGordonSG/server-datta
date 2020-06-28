-------------------------------------------------
--Created and modified by Dominic Stanfford 
---aka Manta aka Anthony Maertens
-------------------------------------------------------

Config                        = {}
Config.DrawDistance           = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = false
Config.MaxInService               = -1
Config.Locale                 = 'fr'

Config.platePrefix                = "FOOD"

Config.MissCraft                  = 0 -- %

Config.AuthorizedVehicles = {
}

Config.Blips = {
    
    Blip = {
     -- Pos     = { x = -1720.0735, y = -1132.9444, z = 12.5977 },
	  Pos     = { x = 417.173, y = -1911.748, z = 25.47 },
      Sprite  = 479,
      Display = 4,
      Scale   = 1.0,
      Colour  = 5,
    },

}

Config.Zones = {
	Actions = {
		--Pos   = {x = -1720.5277099, y = -1132.8874511, z = 12.282},
		Pos   = {x = 428.751, y = -1914.388, z = 24.471},
		Size  = {x = 1.5, y = 1.5, z = 0.4},
		Color = {r = 102, g = 102, b = 204},
		Type  = 25
	},
    
    Delivery = {
        Pos   = { x = 123.997, y = -1040.547, z = 28.214 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 146, g = 0, b = 255 },
        Name  = "Livraison",
        Type  = 23,
        Items = {
            {name ='haydari', label = 'haydari',  price = 40 },
            {name ='cacik',   label = 'cacik',  price = 40 },
            {name ='karides', 	label = 'karides',  price = 40 },
            {name ='salade',  label = 'salade',  price = 40 },
            {name ='wrap',  label = 'wrap',  price = 40},
            {name ='chips',  label = 'chips',  price = 40},
            {name ='tacos',   label = 'tacos',  price = 40},
            {name ='fishburger',  label = 'fishburger',  price = 40},
            {name ='pizza',  label = 'pizza',  price = 40},
            {name ='couscousa', label = 'couscousa',  price = 40},
            {name ='couscousp', label = 'couscousp',  price = 40},
            {name ='couscousm', label = 'couscousm',  price = 40},
            {name ='nuggetss', label = 'nuggetss',  price = 40},
            {name ='kebab',  label = 'kebab',  price = 40},
            {name ='burger',  label = 'burger',  price = 40},
            {name ='tajine_agneau', label = 'tajine',  price = 40},
            {name ='iskender', label = 'iskender',  price = 40},
            {name ='dame_blanche', label = 'dame_blanche',  price = 40},
            {name ='banana_split',   label = 'banana_split',  price = 40},
            {name ='coupe_anglaise',   label = 'coupe_anglaise',  price = 40},
            {name ='donuts', 	label = 'donuts',  price = 40},
			{name ='batonnets_de_mozzarella', 	label = 'batonnets_de_mozzarella',  price = 40},
			{name ='oignon_rings', 	label = 'oignon_rings',  price = 40},
			{name ='mais_grille', 	label = 'mais_grille',  price = 40},
			{name ='chicken_wings', 	label = 'chicken_wings',  price = 40},
			{name ='sunny_cheese_fries', 	label = 'sunny_cheese_fries',  price = 40},
			{name ='salade_de_tomates', 	label = 'salade_de_tomates',  price = 40},
			{name ='salade_cobb', 	label = 'salade_cobb',  price = 40},
			{name ='salade_cesar', 	label = 'salade_cesar',  price = 40},
			{name ='salade_marilyn', 	label = 'salade_marilyn',  price = 40},
			{name ='jambon_grille', 	label = 'jambon_grille',  price = 40},
			{name ='chief_steak', 	label = 'chief_steak',  price = 40},
			{name ='chicken_delight', 	label = 'chicken_delight',  price = 40},
			{name ='brochette', 	label = 'brochette',  price = 40},
			{name ='ribs', 	label = 'ribs',  price = 40},
			{name ='toasty_cheese', 	label = 'toasty_cheese',  price = 40},
			{name ='cheese', 	label = 'cheese',  price = 40},
			{name ='fish', 	label = 'fish',  price = 40},
			{name ='new_sunny', 	label = 'new_sunny',  price = 40},
			{name ='mountain', 	label = 'mountain',  price = 40},
			{name ='fish_and_chips', 	label = 'fish_and_chips',  price = 40},
			{name ='americain_eggs', 	label = 'americain_eggs',  price = 40},
			{name ='delicious_chicken', 	label = 'delicious_chicken',  price = 40},
			{name ='americain_hot_dog', 	label = 'americain_hot_dog',  price = 40},
			{name ='macaroni_cheese', 	label = 'macaroni_cheese',  price = 40},
			{name ='chicken_wrap', 	label = 'chicken_wrap',  price = 40},
			{name ='patty_melt', 	label = 'patty_melt',  price = 40},
			{name ='blue_beef_wrap', 	label = 'blue_beef_wrap',  price = 40},
			{name ='milkshake', 	label = 'milkshake',  price = 40},
			{name ='smoothie', 	label = 'smoothie',  price = 40},
			{name ='sundae', 	label = 'sundae',  price = 40},
			{name ='cookie', 	label = 'cookie',  price = 40},
			{name ='brownie', 	label = 'brownie',  price = 40},
			{name ='pancakes', 	label = 'pancakes',  price = 40},
			{name ='churros', 	label = 'churros',  price = 40},
			{name ='tutti_frutti', 	label = 'tutti_frutti',  price = 40},
			{name ='cheesecake', 	label = 'cheesecake',  price = 40}
			
        },
    },

	Cloakrooms = {
		--Pos   = {x = -1711.771240, y = -1130.0577, z = 12.175},
		Pos   = {x = 419.630, y = -1919.324, z = 24.371},
		Size  = {x = 1.5, y = 1.5, z = 0.4},
		Color = {r = 102, g = 102, b = 204},
		Type  = 27
	},
	
	Fridge = {
		--Pos   = {x = -1713.4699, y = -1128.559936, z = 12.175},
		Pos   = {x = 423.367, y = -1921.255, z = 24.471},
		Size  = {x = 1.5, y = 1.5, z = 0.4},
		Color = {r = 102, g = 102, b = 204},
		Type  = 25
	},
	
	VehicleDeleter = {
		--Pos   = {x = -1735.63696, y = -1103.327156, z = 12.037},
		Pos   = {x = 404.924, y = -1935.822, z = 23.265},
		Size  = {x = 3.0, y = 3.0, z = 0.4},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1,
		
	},
	
	VehicleSpawnPoint = {
		--Pos   = {x = -1743.5355, y = -1121.83251, z = 13.1250},
		Pos   =  {x = 415.355, y = -1930.035, z = 23.42},
		Size  = {x = 3.0, y = 3.0, z = 0.4},		
		Type  = -1,
		Heading      = 222.728,
	},
--{{	
	Meat = { -- viande Flacons
       -- Pos   = { x = -1693.442, y = -1084.5979, z = 12.182 },--
	   Pos   = { x = 1170.630, y = -303.269, z = 68.097 },--
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 0, g = 125, b = 0 },
		Name  = "Magasin de viande",
        Type  = 23,
        Items = {
			{ name = 'agneau',      label = 'agneau',  price = 2 },
			{ name = 'poisson',      label = 'poisson',  price = 2 },
			{ name = 'poulet',      label = 'poulet',  price = 2 },
			{ name = 'boeuf',      label = 'boeuf',  price = 2 },
			{ name = 'merguez',     label = 'merguez', price = 2 },
			{ name = 'bacon',      label = 'bacon',  price = 2 },
			{ name = 'sel',    		label = 'sel', 	   price = 2 },
			{ name = 'sucre',    	label = 'sucre',   price = 2 },
			{ name = 'farine',    	label = 'farine',  price = 2 },
			{ name = 'meat',      	label = 'viande',  price = 2 },
			{ name = 'bread',      	label = 'Pain',  price = 2 },
			{ name = 'sauce',      	label = 'Sauce',  price = 2 },
           -- { name = 'cheval',      label = 'cheval',  price = 1 }
            
        },
    },
	Vegetables = {
        --Pos   = { x = -1692.8155, y = -1109.7297, z = 12.182 },
		Pos   = { x = 1165.862, y = -297.606, z = 68.097 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 0, g = 125, b = 0 },
		Name  = "Magasin de légumes",
        Type  = 23,
        Items = {
			{ name = 'pates',   		label = 'pâtes',     		price = 2 },
			{ name = 'frites',   		label = 'Frites',     		price = 2 },
			{ name = 'salade',    	label = 'Salade', 			price = 1 },
			{ name = 'avocat',    	label = 'avocat', 			price = 1 },
            { name = 'concombre',    	label = 'Concombre', 			price = 1 },
            { name = 'carotte',     	label = 'Carotte',     			price = 1 },
            { name = 'persil',       	label = 'Persil',         		price = 1 },
            { name = 'crevette',        label = 'Crevette',             price = 1 },
			{ name = 'tomate',     		label = 'Tomate',            	price = 1 },
			{ name = 'patate',     		label = 'Patate',            	price = 1 },
            { name = 'poivron',   		label = 'Poivron',     		price = 1 },
			{ name = 'vegetables',   		label = 'Légumes',     		price = 1 },
			{ name = 'fruits',   		label = 'Fruits',     		price = 1 },
			{ name = 'oignon',   		label = 'Oignon',     		price = 1 },
			{ name = 'couscous1',   		label = 'Grain de couscous',     		price = 1 },
			{ name = 'courgette',   		label = 'courgette',     		price = 1 },
			{ name = 'menthe',   		label = 'Menthe',     		price = 1 },
			{ name = 'oeuf',   		label = 'Oeuf',     		price = 1 },
			{ name = 'mozzarella',   		label = 'Mozzarella',     		price = 1 },
			{ name = 'mais',   		label = 'Mais',     		price = 1 },
			{ name = 'fromage',   		label = 'Fromage',     		price = 1 }
			
        },
    },
	
	Dessert = {
       -- Pos   = {x = -1690.01342, y = -1076.679, z = 12.180},--
	    Pos   = {x = 1153.897, y = -297.271, z = 68.097},--
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 0, g = 125, b = 0 },
		Name  = "Magasin de produit frais",
        Type  = 23,
        Items = {
            { name = 'yaourt',    			label = 'yaourt', 			price = 1 },
            { name = 'boule_vanille',     	label = 'boule vanille',    price = 1 },
            { name = 'boule_fraise',       	label = 'boule fraise',     price = 1 },
            { name = 'boule_chocolat',      label = 'boule chocolat',   price = 1 },
			{ name = 'banane',     			label = 'banane',           price = 1 },
			{ name = 'sauce_chocolat',     	label = 'sauce chocolat',   price = 1 },
			{ name = 'boule_menthe',     	label = 'boule menthe',     price = 1 },
            { name = 'chantilly',   		label = 'chantilly',        price = 1 }
        },
    },
	
	
	
	 NoAlcool = {
       -- Pos   = { x = -1703.8446, y = -1101.8463, z = 12.18 },--
	    Pos   = { x = 1164.686, y = -291.670, z = 68.098 },--
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 0, g = 110, b = 0 },
		Name  = "Magasin de boissons",
        Type  = 23,
        Items = {
            { name = 'coca',        label = 'coca',          	price = 5 },
            { name = 'orangina',    label = 'Orangina', 	 	price = 5 },
            { name = 'oasis',       label = 'Oasis',    	 	price = 5 },
            { name = 'sprite',      label = 'Sprite',  		 	price = 5 },
            { name = 'jusfruit',    label = 'Jus de fruits',    price = 5 },
            { name = 'water',    	label = 'eau',      		price = 2 },
			{ name = 'milk',    	label = 'lait de biquette',      		price = 2 }
			
			
			
			
        },
    }
	
	
}





Config.AuthorizedWeapons = {
      { name = 'WEAPON_GOLFCLUB',         price = 1000 },
}

Config.Uniforms = {
    
   recruit_wear = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 82,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 19,
        ['pants_1'] = 37,   ['pants_2'] = 0,
        ['shoes_1'] = 46,   ['shoes_2'] = 0,
        ['helmet_1'] = 77,  ['helmet_2'] = 4,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,  ['tshirt_2'] = 0,
        ['torso_1'] = 258,   ['torso_2'] = 0,
        ['decals_1'] = 66,   ['decals_2'] = 0,
        ['arms'] = 109,
        ['pants_1'] = 99,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 1,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 97,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    }
  },
  
  cooking_wear = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 82,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 19,
        ['pants_1'] = 37,   ['pants_2'] = 0,
        ['shoes_1'] = 46,   ['shoes_2'] = 0,
        ['helmet_1'] = 77,  ['helmet_2'] = 4,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,  ['tshirt_2'] = 0,
        ['torso_1'] = 258,   ['torso_2'] = 0,
        ['decals_1'] = 66,   ['decals_2'] = 0,
        ['arms'] = 109,
        ['pants_1'] = 99,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 1,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 97,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    }
  },
  
  chief_wear = {
    male = {
        ['tshirt_1'] = 31,  ['tshirt_2'] = 0,
        ['torso_1'] = 11,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 29,
        ['pants_1'] = 12,   ['pants_2'] = 5,
        ['shoes_1'] = 36,   ['shoes_2'] = 3,
        ['helmet_1'] = 29,  ['helmet_2'] = 2,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,  ['tshirt_2'] = 0,
        ['torso_1'] = 258,   ['torso_2'] = 0,
        ['decals_1'] = 66,   ['decals_2'] = 0,
        ['arms'] = 109,
        ['pants_1'] = 99,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 1,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 97,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    }
  },
  
  boss_wear = {
    male = {
        ['tshirt_1'] = 26,  ['tshirt_2'] = 0,
        ['torso_1'] = 20,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 28,
        ['pants_1'] = 28,   ['pants_2'] = 8,
        ['shoes_1'] = 16,   ['shoes_2'] = 1,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 12,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,  ['tshirt_2'] = 0,
        ['torso_1'] = 9,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 109,
        ['pants_1'] = 6,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 1,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 96,   ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    }
  },
  

}

-----------------------
------ DELIVERY -------