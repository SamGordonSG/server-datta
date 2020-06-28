INSERT INTO `addon_account` (name, label, shared) VALUES
	('organisation_lost','Lost',1),
	('lost_black_money', 'Argent sale Lost', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('organisation_lost','Lost',1),
	('organisation_lostboss','Lostboss',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('organisation_lost', 'Lost', 1),
	('organisation_lostboss','Lostboss',1)
;

INSERT INTO `org` (name, label) VALUES
	('lost','Lost')
;

INSERT INTO `org_gradeorg` (`org_name`, `gradeorg`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('lost',0,'recruit','Secretaire', '0','{}','{}'),
	('lost',1,'sergeant','Sergent d arme', '0','{}','{}'),
	('lost',2,'lieutenant','Vice président', '0','{}','{}'),
	('lost',3,'boss','Président', '0','{}','{}')
;