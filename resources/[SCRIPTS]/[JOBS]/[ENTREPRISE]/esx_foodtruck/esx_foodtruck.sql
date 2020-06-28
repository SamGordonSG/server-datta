SET @job_name = 'foodtruck';
SET @society_name = 'society_foodtruck';
SET @job_Name_Caps = 'Foodtruck';



INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_foodtruck', 'foodtruck', 1),
  ('foodtruck_black_money','Argent Sale Foodtruck',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_foodtruck', 'Foodtruck', 1)
  ;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_foodtruck', 'Foodtruck', 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  ('foodtruck', 'Foodtruck', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
 
('foodtruck', 0, 'recruit', 'Recrue', 200, '{}', '{}'),
  ('foodtruck', 1, 'cook', 'Cuisinier', 300, '{}', '{}'),
 ('foodtruck', 2, 'chief', 'Gérant', 400, '{}', '{}'),
  ('foodtruck', 3, 'boss', 'Patron', 500, '{}', '{}')
;

 
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES 

--entrées--
	('batonnets_de_mozzarella', 'Batonnets de Mozzarella', '20', '0', '1'),
	('oignon_rings', 'Oignon Rings', '20', '0', '1'),
	('mais_grille', 'Mais Grille', '20', '0', '1'),
	('chicken_wings', 'Chicken Wings', '20', '0', '1'),
	('sunny_cheese_fries', 'Sunny Cheese Fries', '20', '0', '1'),
--salades--
	('salade_de_tomates', 'Salade de Tomates', '20', '0', '1'),
	('salade_cobb', 'Salade Cobb', '20', '0', '1'),
	('salade_cesar', 'salade Cesar', '20', '0', '1'),
	('salade_marilyn', 'Salade Marilyn', '20', '0', '1'),
--grillades--
	('jambon_grille', 'Jambon Grille', '20', '0', '1'),
	('chief_steak', 'Chief Steak', '20', '0', '1'),
	('chicken_delight', 'Chicken Delight', '20', '0', '1'),
	('brochette', 'Brochette', '20', '0', '1'),
	('ribs', 'Ribs', '20', '0', '1'),
--burgers--
	('toasty_cheese', 'Toasty Cheese', '20', '0', '1'),
	('cheese', 'CheeseBurger', '20', '0', '1'),
	('fish', 'FishBurger', '20', '0', '1'),
	('new_sunny', 'New Sunny', '20', '0', '1'),
	('mountain', 'Mountain', '20', '0', '1'),
--spécialités--
	('fish_and_chips', 'Fish and Chips', '20', '0', '1'),
	('americain_eggs', 'Américain Eggs', '20', '0', '1'),
	('delicious_chicken', 'Delicious Chicken', '20', '0', '1'),
	('americain_hot_dog', 'Américain Hot-Dog', '20', '0', '1'),
	('macaroni_cheese', 'Macaroni Cheese', '20', '0', '1'),
--wraps--
	('chicken_wrap', 'Chicken Wrap', '20', '0', '1'),
	('patty_melt', 'Patty Melt', '20', '0', '1'),
	('blue_beef_wrap', 'Blue Beef Wrap', '20', '0', '1'),
--desserts--
	('milkshake', 'Milkshake', '20', '0', '1'),
	('smoothie', 'Smoothie', '20', '0', '1'),
	('sundae', 'Sundae', '20', '0', '1'),
	('cookie', 'Cookie', '20', '0', '1'),
	('brownie', 'Brownie', '20', '0', '1'),
	('pancakes', 'Pancakes', '20', '0', '1'),
	('churros', 'Churros', '20', '0', '1'),
	('tutti_frutti', 'Tutti Frutti', '20', '0', '1'),
	('cheesecake', 'Cheesecake', '20', '0', '1'),
--anciens--
   ('milk', 'Lait de biquette', '20', '0', '1'),
   ('donuts', 'Donuts', '50', '0', '1'),
   ('sucre', 'Sucre', '50', '0', '1'),
   ('farine', 'Farine', '50', '0', '1'),
   ('patate', 'Patate', '50', '0', '1'),
   ('sel', 'Sel', '50', '0', '1'),
   ('merguez', 'Merguez', '50', '0', '1'),
   ('cheval', 'Cheval', '50', '0', '1'), 
   ('poulet', 'Poulet', '50', '0', '1'), 
   ('agneau', 'Agneau', '50', '0', '1'), 
   ('boule_menthe', 'Boule menthe', '50', '0', '1'),
   ('sauce_chocolat', 'Sauce chocolat', '50', '0', '1'),
   ('chantilly', 'Chantilly', '50', '0', '1'), 
   ('banane', 'Banane', '50', '0', '1'),
   ('boule_chocolat', 'Boule chocolat', '50', '0', '1'),
   ('boule_fraise', 'Boule fraise', '50', '0', '1'),
   ('boule_vanille', 'Boule vanille', '50', '0', '1'),
   ('yaourt', 'Yaourt', '50', '0', '1'),
   ('poivron', 'Poivron', '50', '0', '1'),
   ('crevette', 'Crevette', '50', '0', '1'),
   ('courgette', 'Courgette', '50', '0', '1'),
   ('oignon', 'Oignon', '50', '0', '1'),
   ('persil', 'Persil', '50', '0', '1'),
   ('tomate', 'Tomate', '50', '0', '1'), 
   ('carotte', 'Carotte', '50', '0', '1'), 
   ('concombre', 'Concombre', '50', '0', '1'), 
   ('burger', 'Burger', '20', '0', '1'), 
   ('tacos', 'Tacos', '20', '0', '1'), 
   ('meat', 'Viande', '50', '0', '1'), 
   ('vegetables', 'Légume', '50', '0', '1'),
   ('coupe_anglaise', 'Coupe Anglaise', '20', '0', '1'), 
   ('banana_split', 'Banana Split', '20', '0', '1'), 
   ('dame_blanche', 'Dame Blanche', '20', '0', '1'),
   ('iskender', 'Iskender', '20', '0', '1'),
   ('tajine', 'Tajine d\'agneau', '20', '0', '1'),
   ('couscous1', 'Grain de Couscous', '50', '0', '1'),
   ('couscousm', 'Couscous merguez', '20', '0', '1'),
   ('couscousp', 'Couscous au poulet', '20', '0', '1'),
   ('couscousa', 'Couscous à l\'agneau', '20', '0', '1'),
   ('karides', 'Karides', '20', '0', '1'),
   ('cacik', 'Cacik', '20', '0', '1'), 
   ('haydari', 'Haydari', '20', '0', '1'), 	
   ('pizza', 'Pizza', '20', '0', '1') 
   ('sauce', 'Sauce', '50', '0', '1'), 
   ('oeuf', 'Oeuf', '20', '0', '1'), 
   ('mozzarella', 'Mozzarella', '20', '0', '1'), 
   ('mais', 'Mais', '20', '0', '1'),
   ('fromage', 'Fromage', '20', '0', '1'),
('salade', 'Salade', '20', '0', '1'),
('avocat', 'Avocat', '20', '0', '1'),
('poisson', 'Poisson', '20', '0', '1'),
('boeuf', 'Boeuf', '20', '0', '1'),
('bacon', 'Bacon', '20', '0', '1'),
('pates', 'Pâtes', '20', '0', '1'),
('frites', 'Frites', '20', '0', '1'),
('fruits', 'Fruits', '20', '0', '1')
; 

--INSERT INTO `shops` (`name`, `item`, `price`) VALUES
--('Market', 'cola', 100),
--('Market', 'vegetables', 100),
--('Market', 'meat', 100)
--;
