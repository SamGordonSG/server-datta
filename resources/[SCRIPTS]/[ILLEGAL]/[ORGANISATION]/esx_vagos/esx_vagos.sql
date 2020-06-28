INSERT INTO `addon_account` (name, label, shared) VALUES
	('organisation_vagos','Vagos',1),
	('vagos_black_money', 'Argent sale Vagos', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('organisation_vagos','Vagos',1),
	('organisation_vagosboss','Vagosboss',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('organisation_vagos', 'Vagos', 1),
	('organisation_vagosboss','Vagosboss',1)
;

INSERT INTO `org` (name, label) VALUES
	('vagos','Vagos')
;

INSERT INTO `org_gradeorg` (`org_name`, `gradeorg`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('vagos',0,'recruit','Ptit slip', 0, '{}','{}'),
	('vagos',1,'sergeant','Vagos', 0, '{}','{}'),
	('vagos',2,'lieutenant','Bras droit', 0, '{}','{}'),
	('vagos',3,'boss','Chef', 0, '{}','{}')
;