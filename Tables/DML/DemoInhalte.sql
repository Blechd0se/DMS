-- Insert - Skripte:
-- Rechte zuerst:


INSERT INTO RECHTE
(RI_NAME)
VALUES
('Lesen');

INSERT INTO RECHTE
(RI_NAME)
VALUES
('Lesen / Schreiben');

INSERT INTO RECHTE
(RI_NAME)
VALUES
('Löschen');

-- NULL Recht;

-- Schema "Alex"
alter trigger "ALEX"."RECHTE_NR_TRIG" disable;

INSERT INTO RECHTE
(RI_PK_NR, RI_NAME)
VALUES
(0, NULL);

alter trigger "ALEX"."RECHTE_NR_TRIG" enable;

commit;

-- select RI_PK_NR from Rechte where ri_name = 'Lesen / Schreiben';

-- Benutzer_Gruppen

INSERT INTO BENUTZER_GRUPPE
(USGR_NAME)
VALUES
('User');


INSERT INTO BENUTZER_GRUPPE
(USGR_NAME)
VALUES
('Verwalter');


INSERT INTO BENUTZER_GRUPPE
(USGR_NAME)
VALUES
('Administrator');

----- Intersect USGR_RI:

-- Gruppe: Administrator:
INSERT INTO USGR_RI
( benutzer_gruppe_usgr_pk_nr,   rechte_RI_PK_NR )
VALUES
( (select USGR_PK_NR from benutzer_gruppe where USGR_NAME = 'Administrator'), 
  (select RI_PK_NR from RECHTE where RI_Name = 'Lesen / Schreiben')

);

INSERT INTO USGR_RI
( benutzer_gruppe_usgr_pk_nr,   rechte_RI_PK_NR )
VALUES
( (select USGR_PK_NR from benutzer_gruppe where USGR_NAME = 'Administrator'), 
  (select RI_PK_NR from RECHTE where RI_Name = 'Löschen')

);

-- Gruppe: Verwalter:
INSERT INTO USGR_RI
( benutzer_gruppe_usgr_pk_nr,   rechte_RI_PK_NR )
VALUES
( (select USGR_PK_NR from benutzer_gruppe where USGR_NAME = 'Verwalter'), 
  (select RI_PK_NR from RECHTE where RI_Name = 'Lesen / Schreiben')

);

-- Gruppe: User:
INSERT INTO USGR_RI
( benutzer_gruppe_usgr_pk_nr,   rechte_RI_PK_NR )
VALUES
( (select USGR_PK_NR from benutzer_gruppe where USGR_NAME = 'User'), 
  (select RI_PK_NR from RECHTE where RI_Name = 'Lesen')

);

-- Benutzer anlegen:

INSERT INTO BENUTZER
(US_USERNAME      ,         US_VORNAME       ,     US_NACHNAME          ,    US_PASSWORD)
VALUES
(   'alex'        ,         'Alexander'      ,          'Christ'        ,     'Test'    );


INSERT INTO BENUTZER
(US_USERNAME      ,         US_VORNAME       ,     US_NACHNAME          ,    US_PASSWORD  )
VALUES
(   'dummy'       ,         'Dummy'          ,          'Dummy'         ,      'Käse'     );

INSERT INTO BENUTZER
(US_USERNAME      ,         US_VORNAME       ,     US_NACHNAME          ,    US_PASSWORD  )
VALUES
(   'Pete'        ,         'Peter'          ,          'Lustig'        ,      'Test'     );


-- Nutzer zu Gruppen hinzufügen:
INSERT INTO US_USGR
( BENUTZER_US_PK_NR,   BENUTZER_GRUPPE_USGR_PK_NR )
VALUES
( (select US_PK_NR from BENUTZER where US_USERNAME = 'alex'), 
  (select USGR_PK_NR from BENUTZER_GRUPPE where USGR_NAME = 'Administrator')

);

INSERT INTO US_USGR
( BENUTZER_US_PK_NR,   BENUTZER_GRUPPE_USGR_PK_NR )
VALUES
( (select US_PK_NR from BENUTZER where US_USERNAME = 'dummy'), 
  (select USGR_PK_NR from BENUTZER_GRUPPE where USGR_NAME = 'User')

);

INSERT INTO US_USGR
( BENUTZER_US_PK_NR,   BENUTZER_GRUPPE_USGR_PK_NR )
VALUES
( (select US_PK_NR from BENUTZER where US_USERNAME = 'Pete'), 
  (select USGR_PK_NR from BENUTZER_GRUPPE where USGR_NAME = 'Verwalter')

);

commit;


-- Dateien:
