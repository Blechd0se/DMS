-- Generiert von Oracle SQL Developer Data Modeler 3.1.4.710
--   am/um:        2013-03-08 10:26:54 MEZ
--   Site:      Oracle Database 11g
--   Typ:      Oracle Database 11g



DROP TABLE Benutzer CASCADE CONSTRAINTS 
;
DROP TABLE Benutzer_Gruppe CASCADE CONSTRAINTS 
;
DROP TABLE Dateiendung CASCADE CONSTRAINTS 
;
DROP TABLE Dokumente CASCADE CONSTRAINTS 
;
DROP TABLE Rechte CASCADE CONSTRAINTS 
;
DROP TABLE USGR_RI CASCADE CONSTRAINTS 
;
DROP TABLE US_USGR CASCADE CONSTRAINTS 
;
CREATE TABLE Benutzer 
    ( 
     US_PK_NR NUMBER (5)  NOT NULL , 
     US_Username VARCHAR2 (30 CHAR)  NOT NULL , 
     US_Vorname VARCHAR2 (30 CHAR)  NOT NULL , 
     US_Nachname VARCHAR2 (30 CHAR)  NOT NULL , 
     US_PASSWORD VARCHAR2 (100 CHAR)  NOT NULL , 
     US_erstellt_am DATE DEFAULT sysdate  NOT NULL 
    ) 
;



ALTER TABLE Benutzer 
    ADD CONSTRAINT Benutzer_PK PRIMARY KEY ( US_PK_NR ) ;



CREATE TABLE Benutzer_Gruppe 
    ( 
     USGR_PK_NR NUMBER (5)  NOT NULL , 
     USGR_Name VARCHAR2 (100 CHAR)  NOT NULL , 
     USGR_erstellt_am DATE DEFAULT sysdate 
    ) 
;



ALTER TABLE Benutzer_Gruppe 
    ADD CONSTRAINT Benutzer_Gruppe_PK PRIMARY KEY ( USGR_PK_NR ) ;



CREATE TABLE Dateiendung 
    ( 
     END_PK_NR NUMBER (10)  NOT NULL , 
     END_name VARCHAR2 (5 CHAR)  NOT NULL , 
     END_erstellt_am DATE DEFAULT sysdate  NOT NULL , 
     US_END_erstellt_von_FK NUMBER (5)  NOT NULL 
    ) 
;



ALTER TABLE Dateiendung 
    ADD CONSTRAINT Dateiendung_PK PRIMARY KEY ( END_PK_NR ) ;



CREATE TABLE Dokumente 
    ( 
     DOC_PK_NR NUMBER (38)  NOT NULL , 
     DOC_Name VARCHAR2 (4000 CHAR)  NOT NULL , 
     DOC_aenderbar_jn VARCHAR2 (1 CHAR) DEFAULT 'N'  NOT NULL CHECK ( DOC_aenderbar_jn IN ('J', 'N')) , 
     DOC_erstellt_am DATE DEFAULT sysdate  NOT NULL , 
     DOC_geändert_am DATE , 
     US_DOC_geaendert_von_FK NUMBER (5)  NOT NULL , 
     US_DOC_erstellt_von_FK NUMBER (5)  NOT NULL , 
     RI_DOC_benoetigt_recht NUMBER (5)  NOT NULL , 
     END_DOC_FK NUMBER (10)  NOT NULL 
    ) 
;



ALTER TABLE Dokumente 
    ADD CONSTRAINT Dokumente_PK PRIMARY KEY ( DOC_PK_NR ) ;



CREATE TABLE Rechte 
    ( 
     RI_PK_NR NUMBER (5)  NOT NULL , 
     RI_Name VARCHAR2 (100 CHAR) , 
     RI_erstellt_am DATE DEFAULT sysdate 
    ) 
;



ALTER TABLE Rechte 
    ADD CONSTRAINT RI_Rechte_PK PRIMARY KEY ( RI_PK_NR ) ;



CREATE TABLE USGR_RI 
    ( 
     Benutzer_Gruppe_USGR_PK_NR NUMBER (5)  NOT NULL , 
     Rechte_RI_PK_NR NUMBER (5)  NOT NULL , 
     USGR_RI_erstellt_am DATE DEFAULT sysdate 
    ) 
;



ALTER TABLE USGR_RI 
    ADD CONSTRAINT USGR_RI_PK PRIMARY KEY ( Benutzer_Gruppe_USGR_PK_NR, Rechte_RI_PK_NR ) ;



CREATE TABLE US_USGR 
    ( 
     Benutzer_US_PK_NR NUMBER (5)  NOT NULL , 
     Benutzer_Gruppe_USGR_PK_NR NUMBER (5)  NOT NULL , 
     US_USGR_erstellt_am DATE DEFAULT sysdate 
    ) 
;



ALTER TABLE US_USGR 
    ADD CONSTRAINT US_USGR_PK PRIMARY KEY ( Benutzer_US_PK_NR, Benutzer_Gruppe_USGR_PK_NR ) ;




ALTER TABLE Dokumente 
    ADD CONSTRAINT DOC_END_FK FOREIGN KEY 
    ( 
     END_DOC_FK
    ) 
    REFERENCES Dateiendung 
    ( 
     END_PK_NR
    ) 
;


ALTER TABLE Dokumente 
    ADD CONSTRAINT DOC_RI_FK FOREIGN KEY 
    ( 
     RI_DOC_benoetigt_recht
    ) 
    REFERENCES Rechte 
    ( 
     RI_PK_NR
    ) 
;


ALTER TABLE Dokumente 
    ADD CONSTRAINT DOC_US_FK1 FOREIGN KEY 
    ( 
     US_DOC_geaendert_von_FK
    ) 
    REFERENCES Benutzer 
    ( 
     US_PK_NR
    ) 
;


ALTER TABLE USGR_RI 
    ADD CONSTRAINT USGR_RI_Benutzer_Gruppe_FK FOREIGN KEY 
    ( 
     Benutzer_Gruppe_USGR_PK_NR
    ) 
    REFERENCES Benutzer_Gruppe 
    ( 
     USGR_PK_NR
    ) 
;


ALTER TABLE USGR_RI 
    ADD CONSTRAINT USGR_RI_Rechte_FK FOREIGN KEY 
    ( 
     Rechte_RI_PK_NR
    ) 
    REFERENCES Rechte 
    ( 
     RI_PK_NR
    ) 
;


ALTER TABLE Dokumente 
    ADD CONSTRAINT US_DOC_FK2 FOREIGN KEY 
    ( 
     US_DOC_erstellt_von_FK
    ) 
    REFERENCES Benutzer 
    ( 
     US_PK_NR
    ) 
;


ALTER TABLE Dateiendung 
    ADD CONSTRAINT US_END_FK FOREIGN KEY 
    ( 
     US_END_erstellt_von_FK
    ) 
    REFERENCES Benutzer 
    ( 
     US_PK_NR
    ) 
;


ALTER TABLE US_USGR 
    ADD CONSTRAINT US_USGR_Benutzer_FK FOREIGN KEY 
    ( 
     Benutzer_US_PK_NR
    ) 
    REFERENCES Benutzer 
    ( 
     US_PK_NR
    ) 
;


ALTER TABLE US_USGR 
    ADD CONSTRAINT US_USGR_Benutzer_Gruppe_FK FOREIGN KEY 
    ( 
     Benutzer_Gruppe_USGR_PK_NR
    ) 
    REFERENCES Benutzer_Gruppe 
    ( 
     USGR_PK_NR
    ) 
;



-- Zusammenfassungsbericht für Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             0
-- ALTER TABLE                             16
-- CREATE VIEW                              0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE STRUCTURED TYPE                   0
-- CREATE COLLECTION TYPE                   0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
