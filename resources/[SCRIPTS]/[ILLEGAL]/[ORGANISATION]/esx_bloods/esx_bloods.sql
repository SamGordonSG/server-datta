INSERT INTO `addon_account` (name, label, shared) VALUES
	('organisation_bloods','Bloods',1),
	('bloods_black_money', 'Argent sale Bloods', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('organisation_bloods','Bloods',1),
	('organisation_bloodsboss','Bloodsboss',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('organisation_bloods', 'Bloods', 1),
	('organisation_bloodsboss','Bloodsboss',1)
;

INSERT INTO `org` (name, label) VALUES
	('bloods','Bloods')
;

INSERT INTO `org_gradeorg` (`org_name`, `gradeorg`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('bloods',0,'recruit','Nigga', '0','{}','{}'),
	('bloods',1,'sergeant','Bloods', '0','{}','{}'),
	('bloods',2,'lieutenant','Brother', '0','{}','{}'),
	('bloods',3,'boss','Chef', '0','{}','{}')
;