#zadanie 1
create table pracownik (
id_pracownika INT primary key auto_increment,
imie  varchar(40) NOT NULL,
nazwisko varchar(60) NOT NULL,
data_ur DATE NOT NULL
);
INSERT INTO pracownik
VALUES (0,'przemek','lodzinski','2024-12-10');
INSERT INTO pracownik
VALUES (0,'kacper','lodzinski','2021-12-10');
INSERT INTO pracownik
VALUES (0,'kacper','lod','2020-12-10');

UPDATE pracownik SET data_ur= '2000-10-10' WHERE id_pracownika= 1;

#zadanie 2
create table zadanie (
id_zadania INT primary key auto_increment,
nazwa_zadania  varchar(150) NOT NULL,
priorytet ENUM('niski','wysoki','normalny'),
opis char,
id_pracownika INT ,
constraint fk_pracownik foreign key (id_pracownika) references pracownik(id_pracownika)
);

ALTER TABLE zadanie MODIFY COLUMN priorytet ENUM ('niski','normalny','wysoki') DEFAULT 'normalny';

INSERT INTO zadanie (nazwa_zadania, id_pracownika) VALUES ('nauka_baz',1), ('nauka_baz',2), ('nauka_baz',3);

#zadanie 3
CREATE TABLE projekt (
   id_projektu INT PRIMARY KEY AUTO_INCREMENT,
   nazwa_projektu VARCHAR(150) NOT NULL,
   data_rozpoczecia DATE NOT NULL,
   data_zakonczenia DATE
);

ALTER TABLE projekt 
ADD COLUMN menadzer_projektu INT,
ADD constraint fk_menadzer foreign key(menadzer_projektu) references pracownik(id_pracownika);

insert INTO projekt(id_projektu, nazwa_projektu,data_rozpoczecia,data_zakonczenia,menadzer_projektu) VALUES (0,'kaczor','2020-10-12','2020-10-13',2) , (0,'kaczka','2020-10-09','2020-10-15',1);

ALTER TABLE zadanie 
ADD COLUMN projekt INT, 
ADD CONSTRAINT fk_projekt
FOREIGN KEY(projekt) REFERENCES projekt(id_projektu) ON DELETE CASCADE;

UPDATE zadanie SET projekt = 1 WHERE id_zadania =1;
UPDATE zadanie SET projekt = 2 WHERE id_zadania =2;
# zadanie 4
CREATE TABLE sprint (
id_sprintu INT PRIMARY KEY auto_increment,
numer_sprintu INT NOT NULL,
data_rozpoczecia DATE,
data_zakonczenia DATE
);
ALTER TABLE zadanie 
ADD COLUMN sprint INT,
ADD CONSTRAINT fk_sprint
FOREIGN KEY(sprint) REFERENCES sprint(id_sprintu) ON DELETE SET NULL;
INSERT INTO sprint(id_sprintu,numer_sprintu,data_rozpoczecia,data_zakonczenia) VALUES (0,1,'2022-10-10','2022-11-10');
INSERT INTO zadanie(zadanie.id_pracownika,zadanie.id_zadania,zadanie.nazwa_zadania,zadanie.opis,zadanie.priorytet,zadanie.projekt,zadanie.sprint) VALUES (NULL,NULL,'SDAADS','grzybobranie',NULL,NULL,NULL);
#zadanie 5
CREATE TABLE status (
id_statusu INT PRIMARY KEY auto_increment,
nazwa_statusu VARCHAR(20)
);
INSERT INTO status(id_statusu,nazwa_statusu) values (0,'zrobiony');
INSERT INTO status(id_statusu,nazwa_statusu) values (0,'nie zrobiony');
INSERT INTO status(id_statusu,nazwa_statusu) values (0,'prawie zrobiony');
CREATE TABLE zadanie_has_status (
id_zdarzenia INT PRIMARY KEY auto_increment,
id_zadania INT,
id_statusu INT,
FOREIGN KEY (id_zadania) references zadanie(id_zadania),
FOREIGN KEY (id_statusu) references status(id_statusu),
data_zdarzenia datetime DEFAULT current_timestamp
);
DELETE FROM projekt WHERE projekt.id_projektu = 1;
DROP TABLE sprint 
