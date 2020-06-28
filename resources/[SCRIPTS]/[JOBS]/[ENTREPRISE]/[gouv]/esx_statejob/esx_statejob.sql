INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_state','State',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_state','State',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_state', 'State', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('state', 'Gouvernement', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('state', 0, 'recrue', 'recrue', 250, '{}', '{}'),
('state', 1, 'garde', 'Garde du corp', 500, '{}', '{}'),
('state', 2, 'vicepresident', 'Vice President', 1000, '{}', '{}'),
('state', 3, 'boss', 'President', 0, '{}', '{}');