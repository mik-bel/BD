-- MIKITA YAKIMOVICH


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








-- 3. Tworzenie widoków. Należy przygotować kilka widoków ułatwiających dostęp do danych

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
  SELECT w.KRAJ,
         w.DATA,
         w.NAZWA,
         w.LICZBA_MIEJSC,
         w.LICZBA_MIEJSC -
         NVL((SELECT COUNT(*) FROM REZERWACJE r
              WHERE w.ID_WYCIECZKI = r.ID_WYCIECZKI
              GROUP BY r.ID_WYCIECZKI),
             0) AS LICZBA_MIEJSC_WOLNYCH
FROM WYCIECZKI w;


CREATE VIEW dostepne_wyciezki AS
  SELECT w.KRAJ,
         w.DATA,
         w.NAZWA,
         w.LICZBA_MIEJSC,
         w.LICZBA_MIEJSC -
         NVL((SELECT COUNT(*) FROM REZERWACJE r
              WHERE w.ID_WYCIECZKI = r.ID_WYCIECZKI
              GROUP BY r.ID_WYCIECZKI),
             0) AS LICZBA_MIEJSC_WOLNYCH
  FROM WYCIECZKI w
  where w.LICZBA_MIEJSC -
        NVL((SELECT COUNT(*) FROM REZERWACJE r
             WHERE w.ID_WYCIECZKI = r.ID_WYCIECZKI
             GROUP BY r.ID_WYCIECZKI),
             0) > 0
and (select CURRENT_DATE from DUAL) < w.DATA;


CREATE VIEW rezerwacje_do_anulowania AS
  SELECT r.NR_REZERWACJI as NR_REZERWACJI_DO_ANULOWANIA
  FROM REZERWACJE r
         INNER JOIN WYCIECZKI w ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
  WHERE r.STATUS = 'N'
    AND w.DATA - (SELECT CURRENT_DATE FROM DUAL) < 7
AND w.DATA > (SELECT CURRENT_DATE FROM DUAL);

create or replace type type_uczestnicy_wycieczki as object (
  id_osoby NUMBER,
  imie     varchar(50),
  nazwisko varchar(50)
);

create or replace type tab_uczestnicy_wycieczki
as table of type_uczestnicy_wycieczki;


-- 4. Tworzenie procedur/funkcji pobierających dane.
-- Podobnie jak w poprzednim przykładzie należy
-- przygotować kilka procedur ułatwiających dostęp do danych

CREATE OR REPLACE FUNCTION uczestnicy_wycieczki(id NUMBER)
  RETURN tab_uczestnicy_wycieczki
PIPELINED
AS

  BEGIN
    for x in (SELECT r.id_osoby, o.IMIE, o.NAZWISKO
              from REZERWACJE r
                     inner join osoby o on o.ID_OSOBY = r.ID_OSOBY
              where r.ID_WYCIECZKI = id)
    loop
      PIPE ROW (type_uczestnicy_wycieczki(x.id_osoby, x.imie, x.nazwisko));
    end loop;
    RETURN;
END uczestnicy_wycieczki;

create or replace type type_rezerwacje_osoby as object (
  nr_rezerwacji NUMBER
);

create or replace type tab_rezerwacje_osoby as table of type_rezerwacje_osoby;


CREATE OR REPLACE FUNCTION rezerwacje_osoby(id NUMBER)
  RETURN tab_rezerwacje_osoby PIPELINED
AS
  BEGIN
    for x in (SELECT r.NR_REZERWACJI
              FROM REZERWACJE r
                     INNER JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
              WHERE o.ID_OSOBY = id)
    loop
      PIPE ROW (type_rezerwacje_osoby(x.NR_REZERWACJI));
    end loop;
    RETURN;
END;


CREATE OR REPLACE FUNCTION przyszle_rezerwacje_osoby(id NUMBER)
  RETURN tab_rezerwacje_osoby PIPELINED
AS
  BEGIN
    for x in (SELECT r.NR_REZERWACJI
              FROM REZERWACJE r
                     INNER JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
                     INNER JOIN wycieczki w ON r.ID_WYCIECZKI = w.ID_WYCIECZKI
                   WHERE o.ID_OSOBY = id AND w.DATA > (
                                                      SELECT CURRENT_DATE FROM dual)
              )
    loop
      PIPE ROW (type_rezerwacje_osoby(x.NR_REZERWACJI));
    end loop;
    RETURN;
END;



CREATE OR REPLACE TYPE type_dostepne_wycieczki AS OBJECT(
  kraj varchar(50),
  data date
);

CREATE OR REPLACE TYPE tab_dostepne_wycieczki
AS TABLE OF type_dostepne_wycieczki;

CREATE OR REPLACE FUNCTION dostepne_wycieczki
  (kraj varchar2, data_od date, data_do date)
  RETURN tab_dostepne_wycieczki PIPELINED
AS
  BEGIN
    for x in (SELECT w.KRAJ, w.DATA
              FROM WYCIECZKI w
              WHERE w.LICZBA_MIEJSC -
                    NVL(
                      (SELECT count(*)
                       FROM REZERWACJE r
                       WHERE w.ID_WYCIECZKI = r.ID_WYCIECZKI
                       GROUP BY r.ID_WYCIECZKI),
                      0) > 0
                AND ((SELECT CURRENT_DATE FROM DUAL) < w.DATA)
                AND (w.DATA BETWEEN data_od AND data_do)
                AND w.KRAJ = kraj)
    loop
      PIPE ROW (type_dostepne_wycieczki(x.KRAJ, x.DATA));
    end loop;
    RETURN;
END;

-- 5.  Tworzenie procedur modyfikujących dane.
-- Należy przygotować zestaw procedur pozwalających
-- na modyfikację danych oraz kontrolę poprawności ich wprowadzania

CREATE OR REPLACE FUNCTION DOSTEPNE_MIEJSCA(ID_W NUMBER)
  RETURN NUMBER
IS
  LICZBA_WOLNYCH_MIEJSC NUMBER;
  BEGIN
    SELECT W.LICZBA_MIEJSC -
           NVL((SELECT COUNT(*)
                FROM REZERWACJE R
                WHERE W.ID_WYCIECZKI = R.ID_WYCIECZKI
                GROUP BY R.ID_WYCIECZKI),
               0) INTO LICZBA_WOLNYCH_MIEJSC
    FROM WYCIECZKI W
    WHERE W.ID_WYCIECZKI = ID_W;
    RETURN LICZBA_WOLNYCH_MIEJSC;
  END;


-- A) DODAJ_REZERWACJE(ID_WYCIECZKI, ID_OSOBY),
-- PROCEDURA POWINNA KONTROLOWAĆ CZY WYCIECZKA
-- JESZCZE SIĘ NIE ODBYŁA, I CZY SA WOLNE MIEJSCA
CREATE OR REPLACE PROCEDURE DODAJ_REZERWACJE(ID_W NUMBER, ID_O NUMBER)
AS
  BEGIN
    DECLARE
      WYCIECZKI NUMBER;
      OSOBA     NUMBER;
    BEGIN

      SELECT COUNT(W.ID_WYCIECZKI)
          INTO WYCIECZKI
      FROM WYCIECZKI W
      WHERE W.ID_WYCIECZKI = ID_W;
      SELECT O.ID_OSOBY
          INTO OSOBA
      FROM OSOBY O
      WHERE O.ID_OSOBY = ID_O;

      IF WYCIECZKI > 0 AND OSOBA > 0 AND
         DOSTEPNE_MIEJSCA(ID_W) > 0
      THEN
        INSERT INTO REZERWACJE (ID_WYCIECZKI, ID_OSOBY, STATUS)
        VALUES (ID_W, ID_O, 'N');
      END IF;

    END;
  END;

-- B) ZMIEN_STATUS_REZERWACJI(ID_REZERWACJI, STATUS), PROCEDURA KONTROLOWAĆ CZY MOŻLIWA JEST
-- ZMIANA STATUSU, NP. ZMIANA STATUSU JUŻ ANULOWANEJ WYCIECZKI (PRZYWRÓCENIE DO STANU
-- AKTYWNEGO NIE ZAWSZE JEST MOŻLIWE)
CREATE OR REPLACE PROCEDURE ZMIEN_STATUS_REZERWACJI(ID_REZERWACJI NUMBER, NEW_STATUS CHAR)
AS
  BEGIN
    DECLARE
      ID_R NUMBER;
      S    CHAR;
    BEGIN
      SELECT COUNT(R.NR_REZERWACJI) INTO ID_R FROM REZERWACJE R WHERE R.NR_REZERWACJI = ID_REZERWACJI;
      SELECT R.STATUS INTO S FROM REZERWACJE R WHERE R.NR_REZERWACJI = ID_REZERWACJI;
      IF ID_R = 1
      THEN
        IF (S <> 'A')
        THEN
          UPDATE REZERWACJE R SET R.STATUS = NEW_STATUS WHERE R.NR_REZERWACJI = ID_REZERWACJI;
        END IF;
      END IF;
    END;
  END;

-- C) ZMIEN_LICZBE_MIEJSC(ID_WYCIECZKI, LICZBA_MIEJSC), NIE WSZYSTKIE ZMIANY LICZBY MIEJSC SĄ
-- DOZWOLONE, NIE MOŻNA ZMNIEJSZYĆ LICZBY MIESC NA WARTOŚĆ PONIŻEJ LICZBY ZAREZERWOWANYCH
-- MIEJSC
CREATE OR REPLACE PROCEDURE ZMIEN_LICZBE_MIEJSC(ID_WYCIECZKI_ NUMBER, NOWA_LICZBA_MIEJSC NUMBER)
AS
  BEGIN
    DECLARE
      CALKOWITA_LICZBA_MIEJSC NUMBER;
      DOSTEPNE_MIEJSCA_ NUMBER;
    BEGIN
      SELECT W.LICZBA_MIEJSC INTO CALKOWITA_LICZBA_MIEJSC FROM WYCIECZKI W WHERE W.ID_WYCIECZKI = ID_WYCIECZKI_;
      SELECT DOSTEPNE_MIEJSCA(ID_WYCIECZKI_) INTO DOSTEPNE_MIEJSCA_ FROM DUAL;
      IF (NOWA_LICZBA_MIEJSC >= (CALKOWITA_LICZBA_MIEJSC - DOSTEPNE_MIEJSCA_))
      THEN
        UPDATE WYCIECZKI W SET W.LICZBA_MIEJSC = NOWA_LICZBA_MIEJSC WHERE W.ID_WYCIECZKI = ID_WYCIECZKI_;
      END IF;
    END;
  END;


-- 6. DODAJEMY TABELĘ DZIENNIKUJĄCĄ ZMIANY STATUSU REZERWACJI
-- REZERWACJE_LOG(ID, ID_REZERWACJI, DATA, STATUS)
-- NALEŻY ZMIENIĆ WARSTWĘ PROCEDUR MODYFIKUJĄCYCH DANE TAK ABY DOPISYWAŁY INFORMACJĘ DO
-- DZIENNIKA

CREATE TABLE DZIENNIK_REZERWACJI
(
ID_ZMIANY_STATUSU INT GENERATED ALWAYS AS IDENTITY NOT NULL
, NR_REZERWACJI INT
, DATA DATE
, NOWY_STATUS CHAR
, CONSTRAINT DZIENNIK_REZERWACJI_PK PRIMARY KEY
 (
 ID_ZMIANY_STATUSU
 )
 ENABLE
);


CREATE OR REPLACE PROCEDURE ZMIEN_STATUS_REZERWACJI(ID_REZERWACJI NUMBER, NOWY_STATUS_ CHAR)
AS
  BEGIN
    DECLARE
      ID_R            INT;
      S               CHAR;
      DZISIEJSZA_DATA DATE;
    BEGIN
      SELECT COUNT(R.NR_REZERWACJI) INTO ID_R FROM REZERWACJE R WHERE R.NR_REZERWACJI = ID_REZERWACJI;
      SELECT R.STATUS INTO S FROM REZERWACJE R WHERE R.NR_REZERWACJI = ID_REZERWACJI;
      SELECT CURRENT_DATE INTO DZISIEJSZA_DATA FROM DUAL;
      IF ID_R = 1
      THEN
        IF (S <> 'A') AND NOWY_STATUS_ IN ('N', 'P', 'Z') AND NOWY_STATUS_ <> S
        THEN
          UPDATE REZERWACJE R SET R.STATUS = NOWY_STATUS_ WHERE R.NR_REZERWACJI = ID_REZERWACJI;
          INSERT INTO DZIENNIK_REZERWACJI (NR_REZERWACJI, DATA, NOWY_STATUS)
          VALUES (ID_REZERWACJI, DZISIEJSZA_DATA, NOWY_STATUS_);
        END IF;
      END IF;
    END;
END;


-- 7. Zmiana struktury bazy danych, w tabeli wycieczki dodajemy redundantne pole
-- liczba_wolnych_miejsc

ALTER TABLE WYCIECZKI ADD WOLNE_MIEJSCA int NULL;

-- Należy zmodyfikować zestaw widoków. Proponuję dodać kolejne widoki (np. z sufiksem 2), które
-- pobierają informację o wolnych miejscach z nowo dodanego pola.

CREATE or REPLACE VIEW dostepne_wycieczki_2
AS
  SELECT
    W.ID_WYCIECZKI,
    W.KRAJ,
    W.DATA,
    W.NAZWA,
    W.LICZBA_MIEJSC,
    W.WOLNE_MIEJSCA
  FROM WYCIECZKI W
  WHERE WOLNE_MIEJSCA > 0;

-- Należy napisać procedurę przelicz która zaktualizuje wartość liczby wolnych miejsc dla już
-- istniejących danych

CREATE OR REPLACE PROCEDURE przelicz
AS
begin
  declare
  VAL number;
  begin
    FOR REC IN (SELECT w.ID_WYCIECZKI, w.LICZBA_MIEJSC - NVL((select count(*)
        from REZERWACJE r
        where w.ID_WYCIECZKI = r.ID_WYCIECZKI
        group by r.ID_WYCIECZKI),
      0) as LICZBA_MIEJSC_WOLNYCH
      from WYCIECZKI w)
    LOOP
      UPDATE WYCIECZKI s
      SET s.WOLNE_MIEJSCA = REC.LICZBA_MIEJSC_WOLNYCH
      WHERE s.ID_WYCIECZKI = REC.ID_WYCIECZKI;
    END LOOP;
  end;
end;

BEGIN
  PRZELICZ;
END;

-- Należy zmodyfikować warstwę procedur pobierających dane, podobnie jak w przypadku
-- widoków.
create or replace function dostepne_miejsca_2(id_w NUMBER)
  return NUMBER
is
  liczba_wolnych_miejsc_ number;
  begin
    select w.WOLNE_MIEJSCA into liczba_wolnych_miejsc_ from WYCIECZKI w where w.ID_WYCIECZKI = id_w;
    return liczba_wolnych_miejsc_;
  end;


create or replace function dostepne_wycieczki_2_(kraj_ varchar2, data_od date, data_do date)
  return tab_dostepne_wycieczki pipelined
as
  begin
    for x in (select w.KRAJ, w.DATA
              from WYCIECZKI w
              where w.WOLNE_MIEJSCA > 0
                and (select CURRENT_DATE from DUAL) < w.DATA
                and w.DATA between data_od and data_do
                and w.KRAJ = kraj_)
    loop
      pipe row (type_dostepne_wycieczki(x.KRAJ, x.DATA));
    end loop;
    return;
  end;


-- Należy zmodyfikować procedury wprowadzające dane tak aby korzystały/aktualizowały pole
-- liczba _wolnych_miejsc w tabeli wycieczki
-- Najlepiej to zrobić tworząc nowe wersje (np. z sufiksem 2)

create or replace procedure dodaj_rezerwacje_2(id_w NUMBER, id_o NUMBER)
as
  begin
    declare
      wycieczki NUMBER;
      osoba     NUMBER;
    begin

      select count(w.id_wycieczki) into wycieczki from WYCIECZKI w where w.ID_WYCIECZKI = id_w;
      select o.id_osoby into osoba from OSOBY o where o.id_osoby = id_o;

      if wycieczki > 0 and osoba > 0
      then
        INSERT INTO rezerwacje (id_wycieczki, id_osoby, status) VALUES (id_w, id_o, 'N');
        begin
          przelicz();
        end;
      end if;
    end;
  end;

create procedure zmien_liczbe_miejsc_2(id_wycieczki_ NUMBER, nowa_liczba_miejsc NUMBER)
as
  begin
    declare
      calkowita_liczba_miejsc NUMBER;
      dostepne_miejsca_       NUMBER;
    begin
      select w.LICZBA_MIEJSC into calkowita_liczba_miejsc
      from WYCIECZKI w where w.ID_WYCIECZKI = id_wycieczki_;
      select dostepne_miejsca(id_wycieczki_)
          into dostepne_miejsca_
      from dual;
      if (nowa_liczba_miejsc >= (calkowita_liczba_miejsc - dostepne_miejsca_))
      then
        update WYCIECZKI w set w.LICZBA_MIEJSC = nowa_liczba_miejsc
        where w.ID_WYCIECZKI = id_wycieczki_;
        begin
          przelicz();
        end;
      end if;
    end;
end;


-- 8. Zmiana strategii zapisywania do dziennika rezerwacji. Realizacja przy pomocy triggerów
-- Należy wprowadzić zmianę która spowoduje że zapis do dziennika rezerwacji będzie realizowany
-- przy pomocy trigerów
-- triger obsługujący dodanie rezerwacji

CREATE OR REPLACE TRIGGER dodanie_rezerwacji
  AFTER INSERT
  ON REZERWACJE
  FOR EACH ROW
  DECLARE
    aktualna_data date;
  BEGIN
    select current_date into aktualna_data from dual;
    INSERT INTO DZIENNIK_REZERWACJI (NR_REZERWACJI, DATA, NOWY_STATUS)
    VALUES (:new.NR_REZERWACJI, aktualna_data, :new.STATUS);
  END;

-- triger obsługujący zmianę statusu

CREATE OR REPLACE TRIGGER ZMIANA_STATUSU_REZERWACJI
  AFTER UPDATE
  ON REZERWACJE
  FOR EACH ROW
  DECLARE
    AKTUALNA_DATA DATE;
  BEGIN
    SELECT CURRENT_DATE INTO AKTUALNA_DATA FROM DUAL;
    INSERT INTO DZIENNIK_REZERWACJI (NR_REZERWACJI, DATA, NOWY_STATUS)
    VALUES (:NEW.NR_REZERWACJI, AKTUALNA_DATA, :NEW.STATUS);
  END;

-- triger zabraniający usunięcia rezerwacji

CREATE OR REPLACE TRIGGER usuwanie_rezerwacji
  BEFORE DELETE
  ON REZERWACJE
  BEGIN
    raise_application_error(-20001, 'Records can not be deleted');
  END;

create or replace procedure usun_rezerwacje(id_r NUMBER)
as
  begin
    declare
      rezerwacja NUMBER;
    begin
      select count(r.NR_REZERWACJI)
          into rezerwacja
      from rezerwacje r
      where r.NR_REZERWACJI = id_r;

      if rezerwacja = 1
      then
        DELETE FROM rezerwacje r where r.NR_REZERWACJI = id_r;
      end if;
    end;
  end;

-- Oczywiście po wprowadzeniu tej zmiany należy uaktualnić procedury modyfikujące dane.
-- Najlepiej to zrobić tworząc nowe wersje (np. z sufiksem 3)

create procedure zmien_status_rezerwacji_3(id_rezerwacji NUMBER, nowy_status_ char)
as
  begin
    declare
      id_r            NUMBER;
      s               CHAR;
      dzisiejsza_data DATE;
    begin
      select count(r.NR_REZERWACJI) into id_r
      from REZERWACJE r where r.NR_REZERWACJI = id_rezerwacji;
      select r.status into s from REZERWACJE r
      where r.NR_REZERWACJI = id_rezerwacji;

      select current_date into dzisiejsza_data from dual;
      if id_r = 1
      then
        if (s <> 'A') and nowy_status_ in ('N', 'P', 'Z') and nowy_status_ <> s
        then
          update REZERWACJE r set r.STATUS = nowy_status_
          where r.NR_REZERWACJI = id_rezerwacji;
        end if;
      end if;
    end;
end;


-- 9. Zmiana strategii obsługi redundantnego pola liczba_wolnych_miejsc . realizacja przy pomocy
-- trigerów
-- triger obsługujący dodanie rezerwacji
create procedure dodaj_rezerwacje_3(id_w NUMBER, id_o NUMBER)
as
  begin
    declare
      wycieczki NUMBER;
      osoba     NUMBER;
    begin

      select count(w.id_wycieczki) into wycieczki from WYCIECZKI w where w.ID_WYCIECZKI = id_w;
      select o.id_osoby into osoba from OSOBY o where o.id_osoby = id_o;

      if wycieczki > 0 and osoba > 0
      then
        INSERT INTO rezerwacje (id_wycieczki, id_osoby, status) VALUES (id_w, id_o, 'N');
      end if;
    end;
  end;

CREATE OR REPLACE TRIGGER dodanie_rezerwacji_3
  AFTER UPDATE
  ON REZERWACJE
  FOR EACH ROW
  DECLARE
    aktualna_data date;
  BEGIN
    select current_date into aktualna_data from dual;
    INSERT INTO DZIENNIK_REZERWACJI (NR_REZERWACJI, DATA, NOWY_STATUS)
    VALUES (:old.NR_REZERWACJI, aktualna_data, :new.STATUS);
    begin
      przelicz;
    end;
  END;

-- triger obsługujący zmianę statusu

-- ten sam co poprzednio

CREATE OR REPLACE TRIGGER zmiana_statusu_rezerwacji
  AFTER UPDATE
  ON REZERWACJE
  FOR EACH ROW
  DECLARE
    aktualna_data date;
  BEGIN
    select current_date into aktualna_data from dual;
    INSERT INTO DZIENNIK_REZERWACJI (NR_REZERWACJI, DATA, NOWY_STATUS)
    VALUES (:old.NR_REZERWACJI, aktualna_data, :new.STATUS);
  END;

-- triger obsługujący zmianę liczby miejsc na poziomie wycieczki
create procedure zmien_liczbe_miejsc_3(id_wycieczki_ NUMBER, nowa_liczba_miejsc NUMBER)
as
  begin
    declare
      calkowita_liczba_miejsc NUMBER;
      dostepne_miejsca_ NUMBER;
    begin
      select w.LICZBA_MIEJSC
          into calkowita_liczba_miejsc
      from WYCIECZKI w
      where w.ID_WYCIECZKI = id_wycieczki_;

      select dostepne_miejsca(id_wycieczki_)
          into dostepne_miejsca_
      from dual;
      if (nowa_liczba_miejsc >= (calkowita_liczba_miejsc - dostepne_miejsca_))
      then
        update WYCIECZKI w set w.LICZBA_MIEJSC = nowa_liczba_miejsc
        where w.ID_WYCIECZKI = id_wycieczki_;
      end if;
    end;
  end;

create or replace trigger zmiana_liczby_miejsc
  after update
  on wycieczki
  for each row
  when (new.LICZBA_MIEJSC >= 0)
  begin
    PRZELICZ();
  end;




















