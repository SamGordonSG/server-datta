INSERT INTO `addon_account` (name, label, shared) VALUES
	('organisation_shadows','Shadows',1),
	('shadows_black_money', 'Argent sale Shadows', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('organisation_shadows','Shadows',1),
	('organisation_shadowsboss','Shadowsboss',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('organisation_shadows', 'Shadows', 1),
	('organisation_shadowsboss','Shadowsboss',1)
;

INSERT INTO `org` (name, label) VALUES
	('shadows','Shadows')
;

INSERT INTO `org_gradeorg` (`org_name`, `gradeorg`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('shadows',0,'recruit','Recrue', 0, '{}','{}'),
	('shadows',1,'sergeant','Fantôme', 0, '{}','{}'),
	('shadows',2,'lieutenant','Ombre', 0, '{}','{}'),
	('shadows',3,'boss','Faucheur', 0, '{}','{}')
;