INSERT INTO `addon_account` (name, label, shared) VALUES
	('organisation_cartel','Cartel',1),
	('cartel_black_money', 'Argent sale Cartel', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('organisation_cartel','Cartel',1),
	('organisation_cartelboss','Cartelboss',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('organisation_cartel', 'Cartel', 1),
	('organisation_cartelboss','Cartelboss',1)
;

INSERT INTO `org` (name, label) VALUES
	('cartel','cartel')
;

INSERT INTO `org_gradeorg` (`org_name`, `gradeorg`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('cartel',0,'recruit','Soldat', '0','{}','{}'),
	('cartel',1,'sergeant','Intermédiaire', '0','{}','{}'),
	('cartel',2,'lieutenant','Bras droit', '0','{}','{}'),
	('cartel',3,'boss','Chef du cartel', '0','{}','{}')
;