CREATE OR REPLACE
TRIGGER ALEX.benutzer_nr_trig
BEFORE INSERT
ON benutzer FOR EACH ROW
DECLARE
   -- tempor�re Variable
   tmpVar NUMBER;
BEGIN
   -- Wir selektieren aus der Sequenz und und addieren durch nextval +1
   -- Das Ganze wird in der Tempor�ren Variable gespeichert.
   SELECT US_SEQ.NEXTVAL INTO tmpVar FROM dual;
   -- Schlussendlich sorgt der Trigger f�r jedes NEUE PID daf�r, dass die
   -- Variable eingesetzt wird.
   :NEW.US_PK_NR := tmpVar;
END benutzer_nr_trig;


