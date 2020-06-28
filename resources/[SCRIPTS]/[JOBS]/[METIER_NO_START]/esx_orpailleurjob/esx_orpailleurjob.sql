INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_orpailleur','Orpailleur',1)
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_orpailleur','Orpailleur', 1)
;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_orpailleur', 'Orpailleur', 1)
;

INSERT INTO `jobs`(`name`, `label`, `whitelisted`) VALUES
	('orpailleur', 'Orpailleur', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('orpailleur',0,'recrue','Intérimaire', 400, '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":155,\"torso_2\":2,\"shoes_1\":38,\"shoes_2\":1,\"pants_1\":68, \"pants_2\":8, \"arms\":61, \"helmet_1\":13, \"helmet_2\":1, \"chains_1\":54, \"chains_2\":0, \"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
	('orpailleur',1,'novice','Chef équipe', 600, '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":155,\"torso_2\":2,\"shoes_1\":38,\"shoes_2\":1,\"pants_1\":68, \"pants_2\":8, \"arms\":61, \"helmet_1\":13, \"helmet_2\":1, \"chains_1\":54, \"chains_2\":0, \"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
	('orpailleur',2,'cdisenior','Adjoint', 800, '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":155,\"torso_2\":2,\"shoes_1\":38,\"shoes_2\":1,\"pants_1\":68, \"pants_2\":8, \"arms\":61, \"helmet_1\":13, \"helmet_2\":1, \"chains_1\":54, \"chains_2\":0, \"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
	('orpailleur',3,'boss','Patron', 1000,'{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":155,\"torso_2\":2,\"shoes_1\":38,\"shoes_2\":1,\"pants_1\":68, \"pants_2\":8, \"arms\":61, \"helmet_1\":13, \"helmet_2\":1, \"chains_1\":54, \"chains_2\":0, \"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}')
;


INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('pepite', 'Pépite dor', '40', '0', '1'),
	('pepite_raffin', 'Pépite lavée', '40', '0', '1'),
	('lingot', 'Lingot dor', '20', '0', '1')
;

