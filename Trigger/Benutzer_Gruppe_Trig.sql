CREATE OR REPLACE
TRIGGER ALEX.benutzer_gruppe_nr_trig
BEFORE INSERT
ON benutzer_gruppe FOR EACH ROW
DECLARE
   -- temporäre Variable
   tmpVar NUMBER;
BEGIN
   -- Wir selektieren aus der Sequenz und und addieren durch nextval +1
   -- Das Ganze wird in der Temporären Variable gespeichert.
   SELECT US_SEQ.NEXTVAL INTO tmpVar FROM dual;
   -- Schlussendlich sorgt der Trigger für jedes NEUE PID dafür, dass die
   -- Variable eingesetzt wird.
   :NEW.USGR_PK_NR := tmpVar;
END benutzer_gruppe_nr_trig;
