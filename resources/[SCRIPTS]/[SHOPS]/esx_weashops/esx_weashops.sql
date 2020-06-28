USE `essentialmode`;

CREATE TABLE `weashops` (

  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,

  PRIMARY KEY (`id`)
);

INSERT INTO `licenses` (type, label) VALUES
  ('weapon', "Permis de port d'arme")
;

INSERT INTO `weashops` (name, item, price) VALUES
	('BlackWeashop', 'WEAPON_FLASHLIGHT', 700),
	('BlackWeashop', 'WEAPON_BAT', 1000),
    ('BlackWeashop', 'WEAPON_NIGHTSTICK', 1500),
	('BlackWeashop', 'WEAPON_SWITCHBLADE', 1500),
	('BlackWeashop', 'WEAPON_MACHETE', 2000),
	('BlackWeashop', 'WEAPON_STONE_HATCHET', 2500),
	('BlackWeashop','WEAPON_PISTOL',5000),
	('BlackWeashop','WEAPON_HEAVYPISTOL',10000),
	('BlackWeashop','WEAPON_PISTOL50',15000),
	('BlackWeashop', 'WEAPON_APPISTOL', 100000),
    ('BlackWeashop', 'WEAPON_SMOKEGRENADE', 10000),
	('BlackWeashop', 'WEAPON_MICROSMG', 17000),
	('BlackWeashop', 'WEAPON_MACHINEPISTOL', 17000),
	('BlackWeashop', 'WEAPON_SAWOFFSHOTGUN', 35000),
	('BlackWeashop', 'WEAPON_DBSHOTGUN', 17000),
	('BlackWeashop', 'WEAPON_ASSAULTRIFLE', 110000),
	('BlackWeashop', 'WEAPON_CARBINERIFLE', 150000),
	('BlackWeashop', 'WEAPON_SPECIALCARBINE', 165000),
	('BlackWeashop', 'WEAPON_GUSENBERG', 180000),
	('BlackWeashop', 'WEAPON_HEAVYSNIPER', 1500000),
	('BlackWeashop', 'WEAPON_STICKYBOMB', 150000),
	('BlackWeashop', 'WEAPON_SNIPERRIFLE', 1000000),
	('BlackWeashop', 'WEAPON_MOLOTOV', 45000),
	('BlackWeashop', 'WEAPON_GRENADE', 65000),
	('BlackWeashop', 'WEAPON_BZGAS', 3500),
	('GunShop', 'WEAPON_BALL', 250),
	('GunShop', 'WEAPON_KNUCKLE', 500),
	('GunShop', 'WEAPON_FLASHLIGHT', 600),
	('GunShop', 'WEAPON_BAT', 1500),
	('GunShop', 'WEAPON_GOLFCLUB', 1500),
	('GunShop', 'WEAPON_KNIFE', 2500),
    ('GunShop', 'WEAPON_DAGGER', 2500),
	('GunShop', 'WEAPON_FLARE', 2500),
	('GunShop', 'WEAPON_FLAREGUN', 2500),
	('GunShop', 'WEAPON_FIREWORK', 20000)
;
