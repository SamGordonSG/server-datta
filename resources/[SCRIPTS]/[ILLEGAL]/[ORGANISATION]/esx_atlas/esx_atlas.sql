INSERT INTO `addon_account` (name, label, shared) VALUES
	('organisation_atlas','Atlas',1),
	('atlas_black_money', 'Argent sale Atlas', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('organisation_atlas','Atlas',1),
	('organisation_atlasboss','Atlasboss',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('organisation_atlas', 'Atlas', 1),
	('organisation_atlasboss','Atlasboss',1)
;

INSERT INTO `org` (name, label) VALUES
	('atlas','Atlas')
;

INSERT INTO `org_gradeorg` (`org_name`, `gradeorg`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('atlas',0,'recruit','Inconnu', '0','{}','{}'),
	('atlas',1,'sergeant','Inconnu', '0','{}','{}'),
	('atlas',2,'lieutenant','Zira', '0','{}','{}'),
	('atlas',3,'boss','Scar', '0','{}','{}')
;