INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_peche','Pecheur',1)
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_peche','Pecheur', 1)
;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_peche', 'Pecheur', 1)
;

INSERT INTO `jobs`(`name`, `label`, `whitelisted`) VALUES
	('peche', 'Pecheur', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('peche',0,'recrue','Intérimaire', 400, '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":217,\"torso_2\":7,\"shoes_1\":46,\"shoes_2\":2,\"pants_1\":36, \"pants_2\":0, \"arms\":66, \"helmet_1\":104, \"helmet_2\":10, \"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
	('peche',1,'novice','Pêcheur', 600, '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":217,\"torso_2\":7,\"shoes_1\":46,\"shoes_2\":2,\"pants_1\":36, \"pants_2\":0, \"arms\":66, \"helmet_1\":104, \"helmet_2\":10, \"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
	('peche',2,'cdisenior','Chef Batelier', 800, '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":217,\"torso_2\":7,\"shoes_1\":46,\"shoes_2\":2,\"pants_1\":36, \"pants_2\":0, \"arms\":66, \"helmet_1\":104, \"helmet_2\":10, \"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
	('peche',3,'boss','Patron', 1000,'{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":217,\"torso_2\":7,\"shoes_1\":46,\"shoes_2\":2,\"pants_1\":36, \"pants_2\":0, \"arms\":66, \"helmet_1\":104, \"helmet_2\":10, \"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}')
;


INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('saumon', 'saumon', '40', '0', '1'),
	('thon', 'Thon', '40', '0', '1'),
	('crevette', 'Crevette', '40', '0', '1'),
	('saumon_fume', 'Saumon Fumé', '40', '0', '1'),
	('boite_thon', 'Boite de thon', '40', '0', '1'),
	('samoussa_crevette', 'Samoussa aux crevettes', '20', '0', '1')
;

