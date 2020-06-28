INSERT INTO `addon_account` (name, label, shared) VALUES
	('organisation_mafia','Mafia',1),
	('mafia_black_money', 'Argent sale Mafia', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('organisation_mafia','Mafia',1),
	('organisation_mafiaboss','Mafiaboss',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('organisation_mafia', 'Mafia', 1),
	('organisation_mafiaboss','Mafiaboss',1)
;

INSERT INTO `org` (name, label) VALUES
	('mafia','Mafia')
;

INSERT INTO `org_gradeorg` (`org_name`, `gradeorg`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('mafia',0,'recruit','Soldat', '0','{}','{}'),
	('mafia',1,'sergeant','Capo', '0','{}','{}'),
	('mafia',2,'lieutenant','Consigliere', '0','{}','{}'),
	('mafia',3,'boss','Parrain', '0','{}','{}')
;