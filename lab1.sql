--TABLES
CREATE TABLE OSOBY
(
ID_OSOBY INT GENERATED ALWAYS AS IDENTITY NOT NULL
, IMIE VARCHAR2(50)
, NAZWISKO VARCHAR2(50)
, PESEL VARCHAR2(11)
, KONTAKT VARCHAR2(100)
, CONSTRAINT OSOBY_PK PRIMARY KEY
(
ID_OSOBY
)
ENABLE
);

CREATE TABLE REZERWACJE
(
NR_REZERWACJI INT GENERATED ALWAYS AS IDENTITY NOT NULL
, ID_WYCIECZKI INT
, ID_OSOBY INT
, STATUS CHAR(1)
, CONSTRAINT REZERWACJE_PK PRIMARY KEY
(
NR_REZERWACJI
)
ENABLE
);




ALTER TABLE REZERWACJE
ADD CONSTRAINT REZERWACJE_FK1 FOREIGN KEY
(
ID_OSOBY
)
REFERENCES OSOBY
(
ID_OSOBY
)
ENABLE;


ALTER TABLE REZERWACJE
ADD CONSTRAINT REZERWACJE_FK2 FOREIGN KEY
(
ID_WYCIECZKI
)
REFERENCES WYCIECZKI
(
ID_WYCIECZKI
)
ENABLE;

ALTER TABLE REZERWACJE
ADD CONSTRAINT REZERWACJE_CHK1 CHECK
(status IN ('N','P','Z','A'))
ENABLE;


INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Adam', 'Kowalski', '87654321', 'tel: 6623');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Jakub', 'Pajor', '69696969', 'tel: 1111');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Ola', 'Gonera', '11111111', 'tel: 2222');

INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Kasper', 'Kadzielawa', '12121212', 'tel: 9497');

INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Michal', 'czajecki', '66754674', 'tel: 9746');

INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Tomek', 'Osadnik', '6754684', 'tel: 7777');


INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Kas', 'Kadzi', '3333333', 'tel: 7894');

INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Mic', 'cza', '74125896', 'tel: 9875');

INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Tom', 'Os', '08888888', 'tel: 3333');







INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Jan', 'Nowak', '12345678', 'tel: 2312, dzwonić po 18.00');
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wycieczka do Paryza','Francja',TO_DATE('2016-01-01', 'YYYY-MM-DD'),'Ciekawa wycieczka ...',3);
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Piękny Kraków','Polska',TO_DATE('2017-02-03','YYYY-MM-DD'),'Najciekawa wycieczka ...',2);
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wieliczka','Polska',TO_DATE('2017-03-03', 'YYYY-MM-DD'),'Zadziwiająca kopalnia ...',2);

INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Olsztyn','Polska',TO_DATE('2019-03-03', 'YYYY-MM-DD'),'jeziora ...',2);


INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Malbork','Polska',TO_DATE('2018-12-03', 'YYYY-MM-DD'),'Zamek ...',2);



--UWAGA
--W razie problemów z formatem daty można użyć funkcji TO_DATE
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wieliczka2','Polska',TO_DATE('2017-03-03','YYYY-MM-DD'),
'Zadziwiająca kopalnia ...',2);


drop table WYCIECZKI cascade constraints purge;
drop table REZERWACJE cascade constraints purge ;


INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (1,1,'N');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (2,2,'P');


INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (2,3,'N');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (2,4,'P');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (3,5,'N');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (4,6,'N');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (4,7,'P');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (2,8,'P');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (2,8,'P');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (3,3,'N');


INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (1,8,'A');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (1,8,'Z');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (4,3,'A');


INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (5,8,'N');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (5,9,'P');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (6,9,'P');








-- VIEWS

CREATE VIEW wycieczki_osoby
AS
SELECT
w.ID_WYCIECZKI,
w.NAZWA,
w.KRAJ,
w.DATA,
o.IMIE,
o.NAZWISKO,
r.STATUS
FROM WYCIECZKI w
JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY;


drop view  wycieczki_osoby_potwierdzone;
CREATE VIEW wycieczki_osoby_potwierdzone
AS
SELECT
  w.NAZWA,
  w.KRAJ,
  w.DATA,
  o.IMIE,
  o.NAZWISKO,
  r.STATUS
FROM WYCIECZKI w
JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
where STATUS = 'P';

CREATE VIEW wycieczki_przyszle AS
SELECT
  w.NAZWA,
  w.KRAJ,
  w.DATA,
  o.IMIE,
  o.NAZWISKO,
  r.STATUS
FROM WYCIECZKI w
JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
where w.DATA > SYSDATE;

CREATE VIEW wycieczki_miejsca AS
*/

SELECT
      COUNT(r.ID_OSOBY), r.ID_WYCIECZKI
FROM REZERWACJE r WHERE r.STATUS !='A'
group by r.ID_WYCIECZKI;


SELECT * FROM (SELECT COUNT(r.ID_OSOBY), r.ID_WYCIECZKI
               FROM REZERWACJE r
               WHERE r.STATUS != 'A'
               group by r.ID_WYCIECZKI) r
INNER JOIN WYCIECZKI W ON  r.ID_WYCIECZKI = w.ID_WYCIECZKI;



SELECT
      COUNT(r.ID_OSOBY), r.ID_WYCIECZKI
FROM REZERWACJE r
group by r.ID_WYCIECZKI;
