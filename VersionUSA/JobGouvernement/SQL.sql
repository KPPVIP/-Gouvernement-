INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_gouv', 'Gouvernement', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_gouv', 'Gouvernement', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_gouv', 'Gouvernement', 1)
;

INSERT INTO `jobs` (`name`, `label`) VALUES
('gouv', 'Gouvernement');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('gouv', 0, 'recrue', 'Employé', 800, '', ''),
('gouv', 0, 'secretaire', 'Secretaire', 1300, '', ''),
('gouv', 1, 'ministre', 'Ministre', 1650, '', ''),
('gouv', 2, 'boss', 'Président', 2000, '', '');