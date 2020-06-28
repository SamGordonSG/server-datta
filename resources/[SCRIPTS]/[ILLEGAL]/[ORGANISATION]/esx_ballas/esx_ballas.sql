INSERT INTO `addon_account` (name, label, shared) VALUES
	('organisation_ballas','Ballas',1),
	('ballas_black_money', 'Argent sale Ballas', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('organisation_ballas','Ballas',1),
	('organisation_ballasboss','Ballasboss',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('organisation_ballas', 'Ballas', 1),
	('organisation_ballasboss','Ballasboss',1)
;

INSERT INTO `org` (name, label) VALUES
	('ballas','Ballas')
;

INSERT INTO `org_gradeorg` (`org_name`, `gradeorg`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('ballas',0,'recruit','Ptit slip', 0, '{}','{}'),
	('ballas',1,'sergeant','Ballas', 0, '{}','{}'),
	('ballas',2,'lieutenant','Bras droit', 0, '{}','{}'),
	('ballas',3,'boss','Chef', 0, '{}','{}')
;