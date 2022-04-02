

-- connexion au serveur MySQL

-- mysql -h -u root -p root

-- Creation de la base de donn�e

CREATE DATABASE IF NOT EXISTS  `reservationCinema` CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Creation des tables

CREATE TABLE IF NOT EXISTS `reservationCinema`.`Cinemas` (
  `id` INT(3) PRIMARY KEY AUTO_INCREMENT NOT NULL, 
  `name` VARCHAR(60) NULL,
  `adress` VARCHAR(300) NULL,
  `postal_code` VARCHAR(5) NULL,
  `city` VARCHAR(80) NULL)
ENGINE = InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reservationCinema`.`usersDB` (
  `id` INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL, 
  `first_name` VARCHAR(60) NULL,
  `last_name` VARCHAR(60) NOT NULL,
  `mail` VARCHAR(255) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `id_cinema` INT(3) NULL,
  `administrator` TINYINT(1) NULL,	
  CONSTRAINT `manage`
    FOREIGN KEY (`id_cinema`)
    REFERENCES `reservationCinema`.`Cinemas` (`id`))
ENGINE = InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reservationCinema`.`MovieTheatres` (
  `id` INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `number` INT(2) NULL,
  `places` INT(3) NULL,
  `id_cinema` INT(3) NULL,
  CONSTRAINT `containe`
    FOREIGN KEY (`id_cinema`)
    REFERENCES `reservationCinema`.`Cinemas` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reservationCinema`.`Movies` (
  `id` INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(60) NULL,
  `time` TIME NULL,
  `director` VARCHAR(60) NULL)
ENGINE = InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reservationCinema`.`Sessions` (
  `id` VARCHAR(36) PRIMARY KEY NOT NULL,
  `start_time` DATETIME NOT NULL,
  `id_MovieTheatre` INT(10)NOT NULL,
  `id_Movie` INT(10) NOT NULL,
  CONSTRAINT `project`
    FOREIGN KEY (`id_Movie`)
    REFERENCES `reservationCinema`.`Movies` (`id`),
  CONSTRAINT `program`
    FOREIGN KEY (`id_MovieTheatre`)
    REFERENCES `reservationCinema`.`MovieTheatres` (`id`))
ENGINE = InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reservationCinema`.`prices` (
  `id` INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `type` VARCHAR(50) NOT NULL,
  `price` DECIMAL(4,2) NOT NULL)
ENGINE = InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reservationCinema`.`customers` (
  `id` VARCHAR(36) PRIMARY KEY NOT NULL,
  `firstName` VARCHAR(30) NOT NULL,
  `lastName` VARCHAR(30) NOT NULL,
  `email` VARCHAR(254) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `age` INT(2) NOT NULL,
  `id_price` INT(10) NOT NULL,
  CONSTRAINT `cost`
    FOREIGN KEY (`id_price`)
    REFERENCES `reservationCinema`.`prices` (`id`))
ENGINE = InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `reservationCinema`.`bookings` (
  `id` VARCHAR(36) PRIMARY KEY NOT NULL,
  `type_payment` VARCHAR(50) NOT NULL,
  `id_customer` VARCHAR(36) NOT NULL,
  `id_session` VARCHAR(36) NOT NULL,
  CONSTRAINT `correspond`
    FOREIGN KEY (`id_session`)
    REFERENCES `reservationCinema`.`Sessions` (`id`),
  CONSTRAINT `make`
    FOREIGN KEY (`id_customer`)
    REFERENCES `reservationCinema`.`customers` (`id`))
ENGINE = InnoDB DEFAULT CHARSET=utf8;


-- insertion des donnees


INSERT INTO `reservationCinema`.`Cinemas`(id,name ,adress,postal_code,city)
 VALUES 
( 1,'UGC ROSNY' , '16 Rue Conrad Adenauer','93110','ROSNY' ) , 
( 2,'Olympia' , '41 Rue Foch','2100','DIJON' );


INSERT INTO `reservationCinema`.`MovieTheatres`(number ,places,id_cinema)
VALUES (1,50,1),(2,250,1),(3,120,1),(1,30,2),(2,150,2),(3,900,2);

-- password hascher table usersDB
-- dupoond@usersDB,jbalroux@admin,cjolie@usersDB,elerois@admin

INSERT INTO `reservationCinema`.`usersDB`(id,first_name,last_name,mail,password,id_cinema,administrator)
 VALUES 
( 1,'eric' , 'dupond','eric.dupond@mail.com','$2y$10$eUt82clkke7U9HpC.wGYGeH6S6aB/EWF47qAiVuNG8uXNAJ0j3U9S',1,0) , 

( 2,'julien' , 'balroux','julien.balrou@mail.com','$2y$10$FjgpBLuF98afTxeWQACFxOnd79K0lcROYup76GBxPP9CtD6LBj6tG',1,1),

( 3,'camille' , 'jolie','camille.jolie@mail.com','$2y$10$SNKsIeOFC4ZN9DFi2njBduFy6v8MCz.385iiONGcxqfhAGQdjW9vK',2,0) ,
 
( 4,'emilie' , 'lerois','emilie.lerois@mail.com','$2y$10$w3Jbqx9SX47WMOkX.lCR8uEnhN0fRsN5L77F.XDyBcwJWl98CP2z6',2,1); 

INSERT INTO `reservationCinema`.`movies`(id ,name,time,director)
value
(1,'dune','02:20:00','Denis Villeneuve'),
(2,'alerte rouge','01:25:00','Domee Shi'),
(3,'permis de construire','01:30:00','eric fraticelli'),
(4,'Fast and Furious 9','02:23:00','justin lin');


INSERT INTO `reservationCinema`.`prices`(id ,type,price)
value
(1,'plein tarif',9.20),(2,'etudiant',7.60),(3,'moin de 14 ans',5.20);


INSERT INTO `reservationCinema`.`customers`(id ,firstname,lastname,email,password,age,id_price)
value
(UUID(),'piron' ,'eric ','eric.piron@email.fr','$2y$10$95CB2JSatsLn59L.7tleieti63hJsWB79.sVzsXkznmP3EYIYMZFK',
'18','2'),
(UUID(),'debloise' ,'eloise ','eloise.delboise@email.fr','$2y$10$bySDxozCkoBnlbDP8Evrq.AFk28fcLEj0r0giaYA3VbIIRdAhG1wi',
'32','1'),
(UUID(),'dupond' ,'jean ','jean.dupond@email.fr','$2y$10$JVd2WMZhvR/aIeBLZKttN.f1wPUW3RxyPJPpDJX8dbW10qxVkyRYq',
'60','1'),
(UUID(),'pelouse' ,'denis','denis.pelouse@email.fr','$2y$10$w9Kl8N2ZEC5wBwim.HrZ.eG.kl2eQra.Jx7zy99NYqwNN/ZXlsdzi',
'12','3'),
(UUID(),'milot' ,'emilie ','emilie.milot@email.fr','$2y$10$DIBRwlZQceYD5HUHXu87D.YZzXBs95Em5jZVwfv2ASqDcLbJs06pC',
'35','1'),
(UUID(),'dupuis' ,'michel','michel.dupuis@gmail.fr','$2y$10$SXl/BamvEREk1CTWbiZno.JN9/llqHCC2kAr4Kjf20YJd9f9dQiLC',
'17','2');


INSERT INTO `reservationCinema`.`sessions`(id,start_time,id_MovieTheatre,id_Movie)
 VALUES 
(UUID(),'2022-04-27 10:30:00',1,1),
(UUID(),'2022-04-27 13:30:00',1,1),
(UUID(),'2022-04-27 10:30:00',2,1),
(UUID(),'2022-04-27 13:30:00',2,1),
(UUID(),'2022-04-27 10:30:00',2,2),
(UUID(),'2022-04-27 13:30:00',2,2);

USE reservationCinema;
INSERT INTO bookings (id,type_payment,id_customer,id_session)
VALUES(
UUID(),
'CB',
(SELECT id FROM `customers` WHERE email="eric.piron@email.fr"),
(SELECT id FROM `sessions` WHERE start_time='2022-04-27 10:30:00' AND id_MovieTheatre=1 AND id_Movie=1)
),
(
UUID(),
'CB',
(SELECT id FROM `customers` WHERE email="michel.dupuis@gmail.fr"),
(SELECT id FROM `sessions` WHERE start_time='2022-04-27 10:30:00' AND id_MovieTheatre=1 AND id_Movie=1)
),
(
UUID(),
'CB',
(SELECT id FROM `customers` WHERE email="emilie.milot@email.fr"),
(SELECT id FROM `sessions` WHERE start_time='2022-04-27 10:30:00' AND id_MovieTheatre=1 AND id_Movie=1)
),
(
UUID(),
'CB',
(SELECT id FROM `customers` WHERE email="emilie.milot@email.fr"),
(SELECT id FROM `sessions` WHERE start_time='2022-04-27 13:30:00' AND id_MovieTheatre=2 AND id_Movie=2)
),
(
UUID(),
'CB',
(SELECT id FROM `customers` WHERE email="denis.pelouse@email.fr"),
(SELECT id FROM `sessions` WHERE start_time='2022-04-27 13:30:00' AND id_MovieTheatre=2 AND id_Movie=2)
),
(
UUID(),
'CB',
(SELECT id FROM `customers` WHERE email="eloise.delboise@email.fr"),
(SELECT id FROM `sessions` WHERE start_time='2022-04-27 13:30:00' AND id_MovieTheatre=2 AND id_Movie=2)
);

-- Requetes sql permettant de de montrer la fiabilit� de la 
-- bbd par rapport aux exigences du client

USE reservationCinema;

-- Liste des salles dans chaque cin�ma

SELECT cinemas.id,cinemas.name,movietheatres.places FROM cinemas as cinemas 
INNER JOIN movietheatres on cinemas.id=movietheatres.id_cinema;

-- Liste des administrateurs par cinema

SELECT usersDB.mail,cinemas.id,cinemas.name FROM usersDB AS usersDB
INNER JOIN cinemas AS cinemas
ON usersDB.id_cinema=cinemas.id
WHERE usersDB.administrator=1;



/* Liste des clients qui ont r�serv� un film, avec le nom du  film, la date de la s�ance, mode de paiement utilis�, montant pay�.*/

SELECT customer.email,bookings.type_payment,prices.price,sessions.start_time,movies.name as movie FROM bookings as bookings
INNER JOIN customers as customer on bookings.id_customer = customer.id
INNER JOIN prices prices on customer.id_price = prices.id
INNER JOIN sessions sessions on bookings.id_session = sessions.id
INNER join movies movies on sessions.id_Movie = movies.id;



