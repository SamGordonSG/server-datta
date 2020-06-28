

INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_ammunation','Ammunation',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_ammunation','Ammunation',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_ammunation','Ammunation',1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('ammunation','Ammunation')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('ammunation',0,'stagiaire','Stagiaire',300,'{}','{}'),
  ('ammunation',1,'employé','Employé',500,'{}','{}'),
  ('ammunation',2,'professionnel','Professionnel',750,'{}','{}'),
  ('ammunation',3,'second','Adjoint',850,'{}','{}'),
  ('ammunation',4,'boss','Patron',1000,'{}','{}')
;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('carbon', 'Carbone', '150', '0', '1'),
	('acier', 'Acier','150', '0', '1'),
	('poudre', 'Boite de poudre','40', '0', '1'),
	('douille', 'Boite de douille','40', '0', '1')
;
