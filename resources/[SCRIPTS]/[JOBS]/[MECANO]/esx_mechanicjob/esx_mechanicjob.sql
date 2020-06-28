USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mechanic', 'Mécano', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mechanic', 'Mécano', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mechanic', 'Mécano')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mechanic',0,'recrue','Recrue',300,'{\"tshirt_2\":0,\"shoes_1\":60,\"shoes_2\":0,\"torso_2\":0,\"pants_1\":97,\"tshirt_1\":15,\"arms\":59,\"torso_1\":43,\"pants_2\":1,\"helmet_1\":56,\"helmet_2\":4}','{}'),
	('mechanic',1,'novice','Novice',500,'{\"tshirt_2\":0,\"shoes_1\":60,\"shoes_2\":0,\"torso_2\":0,\"pants_1\":97,\"tshirt_1\":15,\"arms\":59,\"torso_1\":43,\"pants_2\":1,\"helmet_1\":56,\"helmet_2\":4}','{}'),
	('mechanic',2,'experimente','Experimente',700,'{\"tshirt_2\":0,\"shoes_1\":60,\"shoes_2\":0,\"torso_2\":0,\"pants_1\":97,\"tshirt_1\":15,\"arms\":59,\"torso_1\":43,\"pants_2\":1,\"helmet_1\":56,\"helmet_2\":4}','{}'),
	('mechanic',3,'chief',"Chef d\'équipe",800,'{\"tshirt_2\":0,\"shoes_1\":60,\"shoes_2\":0,\"torso_2\":0,\"pants_1\":97,\"tshirt_1\":15,\"arms\":59,\"torso_1\":43,\"pants_2\":1,\"helmet_1\":56,\"helmet_2\":4}','{}'),
	('mechanic',4,'boss','Patron',1000,'{\"tshirt_2\":0,\"shoes_1\":60,\"shoes_2\":0,\"torso_2\":0,\"pants_1\":97,\"tshirt_1\":15,\"arms\":59,\"torso_1\":43,\"pants_2\":1,\"helmet_1\":56,\"helmet_2\":4}','{}')
;

INSERT INTO `items` (name, label, `limit`) VALUES
	('gazbottle', 'bouteille de gaz', 11),
	('fixtool', 'outils réparation', 6),
	('carotool', 'outils carosserie', 4),
	('blowpipe', 'Chalumeaux', 10),
	('fixkit', 'Kit réparation', 5),
	('carokit', 'Kit carosserie', 3)
;
