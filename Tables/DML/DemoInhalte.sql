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

alter trigger "ALEX"."RECHTE_NR_TRIG" disable;

INSERT INTO RECHTE
(RI_PK_NR, RI_NAME)
VALUES
(0, NULL);

alter trigger "ALEX"."RECHTE_NR_TRIG" enable;

commit;

select RI_PK_NR from Rechte where ri_name = 'Lesen / Schreiben';

-- Benutzer_Gruppen

INSERT INTO BENUTZER_GRUPPE
(USGR_NAME       ,     USGR_RI_FK_RECHT1     ,     USGR_RI_FK_RECHT2)
VALUES
('User'          ,    
            (select RI_PK_NR from Rechte where ri_name = 'Lesen')               
                                             ,        0             );


INSERT INTO BENUTZER_GRUPPE
(USGR_NAME       ,     USGR_RI_FK_RECHT1     ,     USGR_RI_FK_RECHT2)
VALUES
('Verwalter'     ,     
            (select RI_PK_NR from Rechte where ri_name = 'Lesen / Schreiben')               
                                             ,        0             );


INSERT INTO BENUTZER_GRUPPE
(USGR_NAME       ,     USGR_RI_FK_RECHT1     ,     USGR_RI_FK_RECHT2)
VALUES
('Administrator' ,     
            (select RI_PK_NR from Rechte where ri_name = 'Löschen'),
            (select RI_PK_NR from Rechte where ri_name = 'Lesen / Schreiben'));


-- Benutzer anlegen:

INSERT INTO BENUTZER
(US_USERNAME      ,         US_VORNAME       ,     US_NACHNAME          ,    US_PASSWORD   ,      US_USGR_FK)
VALUES
(   'alex'        ,         'Alexander'      ,          'Christ'        ,     'Test'       , (select USGR_PK_NR from benutzer_gruppe where USGR_NAME = 'Administrator'));


INSERT INTO BENUTZER
(US_USERNAME      ,         US_VORNAME       ,     US_NACHNAME          ,    US_PASSWORD   ,     US_USGR_FK)
VALUES
(   'dummy'       ,         'Dummy'          ,          'Dummy'         ,      'Käse'      ,  (select USGR_PK_NR from benutzer_gruppe where USGR_NAME = 'User'));

INSERT INTO BENUTZER
(US_USERNAME      ,         US_VORNAME       ,     US_NACHNAME          ,    US_PASSWORD   ,     US_USGR_FK)
VALUES
(   'Verwalter'   ,         'Peter'          ,          'Lustig'        ,      'Test'      ,  (select USGR_PK_NR from benutzer_gruppe where USGR_NAME = 'Verwalter'));


commit;


-- Dateien:
