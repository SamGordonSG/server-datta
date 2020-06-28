______________________________________________________

CREATE TABLE `shops2` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`store` varchar(100) NOT NULL,
	`item` varchar(100) NOT NULL,
	`price` int(11) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `shops2` (store, item, price) VALUES
	('narekshop','yusuf',3000),
	('narekshop','grip',500),
	('narekshop','flashlight',500),
	('narekshop','silencieux',50000),
	('narekshop','clip',5000),
	('narekshop','rope',5000),
	('narekshop','handcuffs',5000),
	('narekshop','cagoule',5000),
	('narekshop','piluleoubli',5000),
	('narekshop','drill',50000),
	('narekshop','blowtorch',50000),
	('narekshop','c4_bank',50000),
	('narekshop','raspberry',50000),
	('narekshop','lockpick',5000),
	('narekshop','tunerchip',50000)

;

INSERT INTO `items`(`name`, `label`, `limit`, `rare`, `can_remove`) VALUES 
('yusuf', 'Skin de luxe', -1, 0, 1),
('grip', 'Poignée', -1, 0, 1),
('flashlight', 'Lampe', -1, 0, 1),
('silencieux', 'Silencieux', 2, 0, 1),
('clip', 'Chargeur', 5, 0, 1)
;