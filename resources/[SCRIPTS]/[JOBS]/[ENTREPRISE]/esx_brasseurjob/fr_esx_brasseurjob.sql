INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_brasseur','Brasseur',1)
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_brasseur','Brasseur', 1)
;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_brasseur', 'Brasseur', 1)
;

INSERT INTO `jobs`(`name`, `label`, `whitelisted`) VALUES
	('brasseur', 'Brasseur', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('brasseur',0,'recrue','Intérimaire', 300, '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":281,\"torso_2\":19,\"shoes_1\":80,\"shoes_2\":0,\"pants_1\":27, \"pants_2\":0, \"arms\":48, \"helmet_1\":37, \"helmet_2\":0, \"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
	('brasseur',1,'novice','Brasseur', 500, '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":281,\"torso_2\":19,\"shoes_1\":80,\"shoes_2\":0,\"pants_1\":27, \"pants_2\":0, \"arms\":48, \"helmet_1\":37, \"helmet_2\":0, \"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
	('brasseur',2,'cdisenior','Adjoint', 750, '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":281,\"torso_2\":19,\"shoes_1\":80,\"shoes_2\":0,\"pants_1\":27, \"pants_2\":0, \"arms\":48, \"helmet_1\":37, \"helmet_2\":0, \"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
	('brasseur',3,'boss','Patron', 1000,'{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":281,\"torso_2\":19,\"shoes_1\":80,\"shoes_2\":0,\"pants_1\":27, \"pants_2\":0, \"arms\":48, \"helmet_1\":37, \"helmet_2\":0, \"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}')
;


INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('houblon', 'Houblon', '40', '0', '1'),
	('bierenoel', 'Bière de Noel', '20', '0', '1'),
	('biereblonde', 'Bière Blonde', '20', '0', '1'),
	('orge', 'Orge', '40', '0', '1'),
	('malt', 'Malt', '40', '0', '1'),
	('bierebrune', 'Bière Brune', '20', '0', '1'),
	('whisky', 'Whisky', '20', '0', '1')
;
