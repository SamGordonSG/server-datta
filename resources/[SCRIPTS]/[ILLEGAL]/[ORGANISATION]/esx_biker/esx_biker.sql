INSERT INTO `addon_account` (name, label, shared) VALUES
	('organisation_biker','Biker',1),
	('biker_black_money', 'Argent sale Biker', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('organisation_biker','biker',1),
	('organisation_bikerboss','Bikerboss',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('organisation_biker', 'Biker', 1),
	('organisation_bikerboss','Bikerboss',1)
;

INSERT INTO `org` (name, label) VALUES
	('biker','Biker')
;

INSERT INTO `org_gradeorg` (`org_name`, `gradeorg`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('biker',0,'recruit','Prospect', '0','{}','{}'),
	('biker',1,'sergeant','Sergent', '0','{}','{}'),
	('biker',2,'lieutenant','VP', '0','{}','{}'),
	('biker',3,'boss','Président', '0','{}','{}')
;